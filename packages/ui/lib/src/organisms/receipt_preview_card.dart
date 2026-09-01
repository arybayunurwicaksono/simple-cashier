import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../atoms/currency_text.dart';

class ReceiptItemDto {
  final String name;
  final int unitPrice;
  final int quantity;
  final int subtotal;

  const ReceiptItemDto({
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.subtotal,
  });
}

class ReceiptPreviewCard extends StatelessWidget {
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String invoiceNumber;
  final String date;
  final String cashierName;
  final String? customerName;
  final List<ReceiptItemDto> items;
  final int subtotal;
  final int discount;
  final int totalAmount;
  final int paymentAmount;
  final int changeAmount;
  final String paymentMethod;
  final String footerMessage;

  const ReceiptPreviewCard({
    super.key,
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.invoiceNumber,
    required this.date,
    required this.cashierName,
    this.customerName,
    required this.items,
    required this.subtotal,
    this.discount = 0,
    required this.totalAmount,
    required this.paymentAmount,
    required this.changeAmount,
    this.paymentMethod = 'cash',
    this.footerMessage = 'Terima kasih atas kunjungan Anda!',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Store Header
          Text(
            storeName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.textPrimary(context),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (storeAddress.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              storeAddress,
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary(context)),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (storePhone.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              'Telp: $storePhone',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary(context)),
              textAlign: TextAlign.center,
            ),
          ],
          const Divider(thickness: 1, height: 20),

          // Metadata Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'No: $invoiceNumber',
                  style: TextStyle(fontSize: 11, color: AppColors.textPrimary(context)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(date, style: TextStyle(fontSize: 11, color: AppColors.textSecondary(context))),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Kasir: $cashierName',
                  style: TextStyle(fontSize: 11, color: AppColors.textPrimary(context)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (customerName != null && customerName!.isNotEmpty)
                Expanded(
                  child: Text(
                    'Plg: $customerName',
                    style: TextStyle(fontSize: 11, color: AppColors.textPrimary(context)),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          const Divider(thickness: 1, height: 20),

          // Items Table
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.textPrimary(context),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${item.quantity} x Rp ${item.unitPrice}',
                          style: TextStyle(fontSize: 10, color: AppColors.textSecondary(context)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CurrencyText(
                    amount: item.subtotal,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                ],
              ),
            );
          }),
          const Divider(thickness: 1, height: 20),

          // Totals
          _buildRow(context, 'Subtotal', subtotal),
          if (discount > 0) _buildRow(context, 'Diskon', -discount),
          const SizedBox(height: 2),
          _buildRow(context, 'TOTAL', totalAmount, isBold: true, fontSize: 13),
          const SizedBox(height: 2),
          _buildRow(context, 'Bayar (${paymentMethod.toUpperCase()})', paymentAmount),
          _buildRow(context, 'Kembalian', changeAmount),
          const Divider(thickness: 1, height: 20),

          // Footer
          Text(
            footerMessage,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary(context),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, int amount, {bool isBold = false, double fontSize = 11}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold
                    ? AppColors.primaryAccent(context)
                    : AppColors.textSecondary(context),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          CurrencyText(
            amount: amount,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold
                  ? AppColors.primaryAccent(context)
                  : AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }
}
