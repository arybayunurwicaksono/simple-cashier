import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/pos_store.dart';
import '../../stores/settings_store.dart';
import '../dashboard_screen.dart';

class ReceiptScreen extends StatefulWidget {
  final TransactionWithItems transactionWithItems;

  const ReceiptScreen({super.key, required this.transactionWithItems});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final _posStore = getIt<PosStore>();
  final _settingsStore = getIt<SettingsStore>();
  bool _isPrinting = false;

  @override
  void initState() {
    super.initState();
    _settingsStore.loadSettings();
  }

  Future<void> _handlePrint() async {
    setState(() {
      _isPrinting = true;
    });

    final success = await _posStore.printReceipt(widget.transactionWithItems);

    if (!mounted) return;

    setState(() {
      _isPrinting = false;
    });

    if (success) {
      AppNotification.showSuccess(
        context,
        'Struk berhasil dicetak',
      );
    } else {
      AppNotification.showError(
        context,
        _posStore.errorMessage ?? 'Gagal mencetak struk. Periksa printer Bluetooth Anda.',
      );
    }
  }

  Future<void> _handleShareWhatsApp() async {
    final tx = widget.transactionWithItems.transaction;
    final phone = tx.customerPhone;
    if (phone == null || phone.isEmpty) {
      AppNotification.showWarning(
        context,
        'Nomor telepon pelanggan tidak tersedia',
      );
      return;
    }

    final store = _settingsStore.storeProfile;
    final msg = '''
*NOTA TRANSAKSI - ${store?.storeName ?? 'Simple Cashier'}*
No. Nota: ${tx.invoiceNumber}
Tanggal: ${DateFormatter.formatFull(tx.createdAt)}
Kasir: ${widget.transactionWithItems.user?.fullname ?? 'Kasir'}

*Rincian Belanja:*
${widget.transactionWithItems.items.map((i) => '• ${i.itemName} (${i.quantity}x) = ${CurrencyFormatter.format(i.subtotalPrice)}').join('\n')}

*Total: ${CurrencyFormatter.format(tx.totalAmount)}*
Bayar: ${CurrencyFormatter.format(tx.paymentAmount)}
Kembali: ${CurrencyFormatter.format(tx.changeAmount)}

Terima kasih atas kunjungan Anda!
''';

    await ShareService.sendWhatsAppMessage(phoneNumber: phone, message: msg);
  }

  @override
  Widget build(BuildContext context) {
    final tx = widget.transactionWithItems.transaction;
    final items = widget.transactionWithItems.items;
    final store = _settingsStore.storeProfile;

    final receiptItems = items.map((i) {
      return ReceiptItemDto(
        name: i.itemName,
        unitPrice: i.sellingPrice,
        quantity: i.quantity,
        subtotal: i.subtotalPrice,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bukti Pembayaran'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          children: [
            ReceiptPreviewCard(
              storeName: store?.storeName ?? 'Simple Cashier Store',
              storeAddress: store?.address ?? '',
              storePhone: store?.phone ?? '',
              invoiceNumber: tx.invoiceNumber,
              date: DateFormatter.formatFull(tx.createdAt),
              cashierName: widget.transactionWithItems.user?.fullname ?? 'Kasir',
              customerName: tx.customerName,
              items: receiptItems,
              subtotal: tx.subtotal,
              discount: tx.discount,
              totalAmount: tx.totalAmount,
              paymentAmount: tx.paymentAmount,
              changeAmount: tx.changeAmount,
              paymentMethod: tx.paymentMethod,
              footerMessage: store?.footerMessage ?? 'Terima kasih atas kunjungan Anda!',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Cetak Struk',
                    icon: Icons.print,
                    height: 42,
                    isLoading: _isPrinting,
                    onPressed: _handlePrint,
                  ),
                ),
                if (tx.customerPhone != null && tx.customerPhone!.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppButton(
                      label: 'Kirim WA',
                      icon: Icons.send,
                      height: 42,
                      variant: AppButtonVariant.secondary,
                      onPressed: _handleShareWhatsApp,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Kembali ke Kasir',
              variant: AppButtonVariant.outline,
              width: double.infinity,
              height: 42,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
