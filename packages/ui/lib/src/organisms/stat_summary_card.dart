import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../atoms/currency_text.dart';

class StatSummaryCard extends StatelessWidget {
  final String title;
  final int? amount;
  final String? customValue;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String? subtitle;

  const StatSummaryCard({
    super.key,
    required this.title,
    this.amount,
    this.customValue,
    required this.icon,
    this.iconColor = AppColors.primary,
    this.backgroundColor = AppColors.primaryContainer,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary(context),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: isDark ? AppColors.primaryDarkAccent : iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (amount != null)
            CurrencyText(
              amount: amount!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            )
          else if (customValue != null)
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                customValue!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary(context),
                ),
                maxLines: 1,
              ),
            ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.textMuted(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
