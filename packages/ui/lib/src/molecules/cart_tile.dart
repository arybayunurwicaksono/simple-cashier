import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:core/core.dart';
import '../atoms/currency_text.dart';

class CartTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int unitPrice;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final String? itemType; // 'product' | 'service'

  const CartTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.unitPrice,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    this.itemType = 'product',
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = unitPrice * quantity;
    final isService = itemType == 'service';
    final isDark = AppColors.isDark(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isService
                  ? AppColors.infoContainerAdaptive(context)
                  : AppColors.warningContainerAdaptive(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isService ? Icons.build_outlined : Icons.inventory_2_outlined,
              size: 18,
              color: isService
                  ? (isDark ? AppColors.infoDark : AppColors.info)
                  : (isDark ? AppColors.warningDark : AppColors.warning),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.textPrimary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                CurrencyText(
                  amount: subtotal,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.primaryAccent(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  quantity > 1 ? Icons.remove_circle_outline : Icons.delete_outline,
                  color: quantity > 1 ? AppColors.textSecondary(context) : AppColors.error,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                onPressed: quantity > 1 ? onDecrement : onRemove,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  quantity.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: AppColors.primaryAccent(context),
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
