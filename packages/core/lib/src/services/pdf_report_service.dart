import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../utils/currency_formatter.dart';

class PdfReportService {
  /// Generates a complete Monthly Ledger & Accounting Report PDF
  static Future<Uint8List> generateMonthlyReportPdf({
    required String storeName,
    required String storeAddress,
    required String storePhone,
    required String period,
    required String generatedBy,
    required int initialCash,
    required int initialDigital,
    required int initialStockValue,
    required int incomeGoods,
    required int incomeServices,
    required int totalExpense,
    required int netProfit,
    required int finalCash,
    required int finalDigital,
    required int finalStockValue,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.poppinsRegular();
    final fontBold = await PdfGoogleFonts.poppinsBold();

    final totalIncome = incomeGoods + incomeServices;
    final totalInitialBalance = initialCash + initialDigital;
    final totalFinalBalance = finalCash + finalDigital;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(storeName, style: pw.TextStyle(font: fontBold, fontSize: 20, color: PdfColors.blue900)),
                        pw.SizedBox(height: 4),
                        pw.Text(storeAddress, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                        pw.Text('Telp / WA: $storePhone', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('LAPORAN KEUANGAN BULANAN', style: pw.TextStyle(font: fontBold, fontSize: 12, color: PdfColors.blue800)),
                        pw.Text('Periode: $period', style: pw.TextStyle(font: fontBold, fontSize: 11)),
                        pw.Text('Dicetak oleh: $generatedBy', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
                      ],
                    ),
                  ],
                ),
                pw.Divider(thickness: 1.5, color: PdfColors.blue900),
                pw.SizedBox(height: 16),

                // Saldo Awal Box
                pw.Text('1. POSISI SALDO AWAL BULAN', style: pw.TextStyle(font: fontBold, fontSize: 12)),
                pw.SizedBox(height: 6),
                _buildTable([
                  ['Saldo Kas Tunai Awal', CurrencyFormatter.format(initialCash)],
                  ['Saldo Digital Awal (Bank/QRIS)', CurrencyFormatter.format(initialDigital)],
                  ['Total Saldo Awal', CurrencyFormatter.format(totalInitialBalance)],
                  ['Nilai Aset Stok Barang Awal', CurrencyFormatter.format(initialStockValue)],
                ]),
                pw.SizedBox(height: 16),

                // Pendapatan & Pengeluaran
                pw.Text('2. ARUS PENDAPATAN & PENGELUARAN', style: pw.TextStyle(font: fontBold, fontSize: 12)),
                pw.SizedBox(height: 6),
                _buildTable([
                  ['Pendapatan Penjualan Barang', CurrencyFormatter.format(incomeGoods)],
                  ['Pendapatan Jasa / Layanan', CurrencyFormatter.format(incomeServices)],
                  ['Total Pendapatan Kotor (Omzet)', CurrencyFormatter.format(totalIncome)],
                  ['Total Pengeluaran / Beban Operasional', CurrencyFormatter.format(totalExpense)],
                  ['LABA BERSIH OPERASIONAL', CurrencyFormatter.format(netProfit)],
                ], isProfitHighlight: true),
                pw.SizedBox(height: 16),

                // Saldo Akhir Box
                pw.Text('3. POSISI SALDO AKHIR BULAN', style: pw.TextStyle(font: fontBold, fontSize: 12)),
                pw.SizedBox(height: 6),
                _buildTable([
                  ['Saldo Kas Tunai Akhir', CurrencyFormatter.format(finalCash)],
                  ['Saldo Digital Akhir (Bank/QRIS)', CurrencyFormatter.format(finalDigital)],
                  ['Total Saldo Kas Akhir', CurrencyFormatter.format(totalFinalBalance)],
                  ['Nilai Aset Stok Barang Akhir', CurrencyFormatter.format(finalStockValue)],
                ]),
                pw.Spacer(),

                // Signatures
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text('Dibuat oleh (Kasir):', style: const pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 48),
                        pw.Text('( $generatedBy )', style: pw.TextStyle(font: fontBold, fontSize: 10)),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text('Disetujui oleh (Owner):', style: const pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 48),
                        pw.Text('( _____________________ )', style: pw.TextStyle(font: fontBold, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildTable(List<List<String>> rows, {bool isProfitHighlight = false}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      children: rows.map((row) {
        final isHighlight = isProfitHighlight && row == rows.last;
        return pw.TableRow(
          decoration: isHighlight ? const pw.BoxDecoration(color: PdfColors.blue50) : null,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: pw.Text(
                row[0],
                style: pw.TextStyle(fontSize: 10, fontWeight: isHighlight ? pw.FontWeight.bold : pw.FontWeight.normal),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: pw.Text(
                row[1],
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: isHighlight ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: isHighlight ? PdfColors.blue900 : PdfColors.black,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
