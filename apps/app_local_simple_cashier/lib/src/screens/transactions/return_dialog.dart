import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';

class ReturnDialog extends StatefulWidget {
  final TransactionWithItems transactionWithItems;
  final VoidCallback onSuccess;

  const ReturnDialog({super.key, required this.transactionWithItems, required this.onSuccess});

  static Future<void> show(
    BuildContext context, {
    required TransactionWithItems transactionWithItems,
    required VoidCallback onSuccess,
  }) {
    return showDialog(
      context: context,
      builder: (_) => ReturnDialog(
        transactionWithItems: transactionWithItems,
        onSuccess: onSuccess,
      ),
    );
  }

  @override
  State<ReturnDialog> createState() => _ReturnDialogState();
}

class _ReturnDialogState extends State<ReturnDialog> {
  final _transactionDao = getIt<TransactionDao>();
  final _authStore = getIt<AuthStore>();
  final _refundAmountController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refundAmountController.text = widget.transactionWithItems.transaction.totalAmount.toString();
  }

  @override
  void dispose() {
    _refundAmountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _handleProcessReturn() async {
    final refund = int.tryParse(_refundAmountController.text) ?? 0;
    final userId = _authStore.currentUser?.id ?? 1;

    final restorations = <Map<String, int>>[];
    for (final item in widget.transactionWithItems.items) {
      if (item.itemType == 'product' && item.productId != null) {
        restorations.add({
          'productId': item.productId!,
          'quantity': item.quantity,
        });
      }
    }

    await _transactionDao.processReturn(
      transactionId: widget.transactionWithItems.transaction.id,
      invoiceNumber: widget.transactionWithItems.transaction.invoiceNumber,
      refundAmount: refund,
      totalItemReturned: widget.transactionWithItems.items.length,
      userId: userId,
      reason: _reasonController.text.trim(),
      productRestorations: restorations,
    );

    if (!mounted) return;

    AppNotification.showSuccess(
      context,
      'Retur barang berhasil diproses dan stok telah dikembalikan',
    );
    Navigator.of(context).pop();
    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Retur Transaksi', style: AppTextStyles.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Nota: ${widget.transactionWithItems.transaction.invoiceNumber}',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary(context)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),
            AppTextField(
              label: 'Jumlah Pengembalian Dana (Rp) *',
              hint: '0',
              controller: _refundAmountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            AppTextField(
              label: 'Alasan Retur / Pengembalian',
              hint: 'Contoh: Barang cacat / batal',
              controller: _reasonController,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Batal',
                    variant: AppButtonVariant.outline,
                    height: 40,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    label: 'Proses Retur',
                    variant: AppButtonVariant.danger,
                    height: 40,
                    onPressed: _handleProcessReturn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
