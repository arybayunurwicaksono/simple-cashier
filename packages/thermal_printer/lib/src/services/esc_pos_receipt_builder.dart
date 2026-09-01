import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

class ReceiptLineItem {
  final String name;
  final int unitPrice;
  final int quantity;
  final int subtotal;

  const ReceiptLineItem({
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.subtotal,
  });
}

class EscPosReceiptBuilder {
  static Future<List<int>> buildReceiptBytes({
    PaperSize paperSize = PaperSize.mm58,
    required String storeName,
    required String storeAddress,
    required String storePhone,
    required String invoiceNumber,
    required String dateFormatted,
    required String cashierName,
    String? customerName,
    required List<ReceiptLineItem> items,
    required int subtotal,
    int discount = 0,
    required int totalAmount,
    required int paymentAmount,
    required int changeAmount,
    String paymentMethod = 'CASH',
    String headerMessage = 'Terima kasih atas kunjungan Anda',
    String footerMessage = 'Barang yang sudah dibeli tidak dapat ditukar',
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];

    // Header
    bytes += generator.text(
      storeName,
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );

    if (storeAddress.isNotEmpty) {
      bytes += generator.text(
        storeAddress,
        styles: const PosStyles(align: PosAlign.center),
      );
    }
    if (storePhone.isNotEmpty) {
      bytes += generator.text(
        'Telp: $storePhone',
        styles: const PosStyles(align: PosAlign.center),
      );
    }

    bytes += generator.hr();

    // Metadata
    bytes += generator.row([
      PosColumn(text: 'Nota:', width: 4),
      PosColumn(text: invoiceNumber, width: 8, styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += generator.row([
      PosColumn(text: 'Tgl:', width: 4),
      PosColumn(text: dateFormatted, width: 8, styles: const PosStyles(align: PosAlign.right)),
    ]);
    bytes += generator.row([
      PosColumn(text: 'Kasir:', width: 4),
      PosColumn(text: cashierName, width: 8, styles: const PosStyles(align: PosAlign.right)),
    ]);
    if (customerName != null && customerName.isNotEmpty) {
      bytes += generator.row([
        PosColumn(text: 'Cust:', width: 4),
        PosColumn(text: customerName, width: 8, styles: const PosStyles(align: PosAlign.right)),
      ]);
    }

    bytes += generator.hr();

    // Items list (Single batch iteration - no N+1 queries!)
    for (final item in items) {
      bytes += generator.text(
        item.name,
        styles: const PosStyles(bold: true),
      );
      bytes += generator.row([
        PosColumn(
          text: '${item.quantity} x ${item.unitPrice}',
          width: 7,
        ),
        PosColumn(
          text: item.subtotal.toString(),
          width: 5,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.hr();

    // Totals
    bytes += generator.row([
      PosColumn(text: 'Subtotal', width: 6),
      PosColumn(text: subtotal.toString(), width: 6, styles: const PosStyles(align: PosAlign.right)),
    ]);

    if (discount > 0) {
      bytes += generator.row([
        PosColumn(text: 'Diskon', width: 6),
        PosColumn(text: '-$discount', width: 6, styles: const PosStyles(align: PosAlign.right)),
      ]);
    }

    bytes += generator.row([
      PosColumn(text: 'TOTAL', width: 6, styles: const PosStyles(bold: true, height: PosTextSize.size1)),
      PosColumn(
        text: 'Rp $totalAmount',
        width: 6,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]);

    bytes += generator.row([
      PosColumn(text: 'Bayar ($paymentMethod)', width: 6),
      PosColumn(text: paymentAmount.toString(), width: 6, styles: const PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.row([
      PosColumn(text: 'Kembalian', width: 6),
      PosColumn(text: changeAmount.toString(), width: 6, styles: const PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.hr();

    // Footer
    bytes += generator.text(
      footerMessage,
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }
}
