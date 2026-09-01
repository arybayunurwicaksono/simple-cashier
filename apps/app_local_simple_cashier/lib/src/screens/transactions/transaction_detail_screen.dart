import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../pos/receipt_screen.dart';
import 'return_dialog.dart';

class TransactionDetailScreen extends StatefulWidget {
  final int transactionId;

  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  State<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final _transactionDao = getIt<TransactionDao>();
  TransactionWithItems? _txData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    setState(() => _isLoading = true);
    final data = await _transactionDao.getTransactionWithItems(widget.transactionId);
    setState(() {
      _txData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_txData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Transaksi')),
        body: const Center(child: Text('Transaksi tidak ditemukan')),
      );
    }

    final tx = _txData!.transaction;
    final items = _txData!.items;

    return Scaffold(
      appBar: AppBar(
        title: Text(tx.invoiceNumber),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReceiptScreen(transactionWithItems: _txData!),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        children: [
          // Transaction Summary Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'No. Nota: ${tx.invoiceNumber}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AppBadge(
                      label: tx.paymentMethod.toUpperCase(),
                      variant: tx.paymentMethod == 'cash' ? BadgeVariant.neutral : BadgeVariant.info,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormatter.formatFull(tx.createdAt),
                  style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                ),
                Text(
                  'Kasir: ${_txData!.user?.fullname ?? "Kasir"}',
                  style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                ),
                if (tx.customerName != null && tx.customerName!.isNotEmpty) ...[
                  Text(
                    'Pelanggan: ${tx.customerName} (${tx.customerPhone ?? "-"})',
                    style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),

          Text(
            'Daftar Item Transaksi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),

          // Items List
          ...items.map((item) {
            final isService = item.itemType == 'service';
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.itemName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      CurrencyText(
                        amount: item.subtotalPrice,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: isDark ? const Color(0xFF60A5FA) : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.quantity} x ${CurrencyFormatter.format(item.sellingPrice)}',
                          style: TextStyle(fontSize: 10, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isService)
                        _buildServiceStatusDropdown(item)
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 14),

          // Totals
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                _buildRow(context, 'Subtotal', tx.subtotal),
                if (tx.discount > 0) _buildRow(context, 'Diskon', -tx.discount, color: AppColors.error),
                const Divider(height: 14),
                _buildRow(context, 'TOTAL TRANSAKSI', tx.totalAmount, isBold: true, color: isDark ? const Color(0xFF60A5FA) : AppColors.primary),
                _buildRow(context, 'Uang Diterima', tx.paymentAmount),
                _buildRow(context, 'Kembalian', tx.changeAmount),
                const Divider(height: 14),
                _buildRow(context, 'Estimasi Keuntungan / Profit', tx.totalProfit, color: isDark ? const Color(0xFF34D399) : AppColors.secondaryDark),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Return Button
          AppButton(
            label: 'Proses Retur / Pengembalian Barang',
            variant: AppButtonVariant.danger,
            height: 42,
            icon: Icons.assignment_return_outlined,
            onPressed: () {
              ReturnDialog.show(
                context,
                transactionWithItems: _txData!,
                onSuccess: () => _loadDetail(),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildServiceStatusDropdown(TransactionItemData item) {
    return DropdownButton<String>(
      value: item.serviceStatus,
      isDense: true,
      underline: const SizedBox.shrink(),
      items: const [
        DropdownMenuItem(value: 'queued', child: Text('Antre', style: TextStyle(fontSize: 11))),
        DropdownMenuItem(value: 'in_progress', child: Text('Proses', style: TextStyle(fontSize: 11))),
        DropdownMenuItem(value: 'completed', child: Text('Selesai', style: TextStyle(fontSize: 11))),
        DropdownMenuItem(value: 'picked_up', child: Text('Diambil', style: TextStyle(fontSize: 11))),
      ],
      onChanged: (newStatus) async {
        if (newStatus != null) {
          await _transactionDao.updateServiceItemStatus(item.id, newStatus);
          _loadDetail();
        }
      },
    );
  }

  Widget _buildRow(BuildContext context, String label, int amount, {bool isBold = false, Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? const Color(0xFFF8FAFC) : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold ? (color ?? defaultColor) : (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155)),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          CurrencyText(
            amount: amount,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? defaultColor,
            ),
          ),
        ],
      ),
    );
  }
}
