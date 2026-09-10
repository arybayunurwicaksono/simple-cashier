import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:core/core.dart';

class TimeFilterChipBar extends StatelessWidget {
  final String selectedFilter; // 'yearly' | 'monthly' | 'weekly'
  final ValueChanged<String> onFilterChanged;
  final VoidCallback? onFilterTap;

  const TimeFilterChipBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final options = [
      {'key': 'yearly', 'label': 'Tahunan'},
      {'key': 'monthly', 'label': 'Bulanan'},
      {'key': 'weekly', 'label': '7 Hari'},
    ];

    final containerBorder = Border.all(
      color: isDark ? AppColors.borderDark : AppColors.borderLight,
      width: 1.2,
    );

    return Row(
      children: [
        // Left Filter Icon Button (Triggers detailed specific filter dialog)
        if (onFilterTap != null) ...[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(14),
                  border: containerBorder,
                ),
                child: Center(
                  child: Icon(
                    Icons.tune_rounded,
                    size: 20,
                    color: isDark ? AppColors.primaryDarkAccent : AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],

        // Segmented Filter Options
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(14),
              border: containerBorder,
            ),
            child: Row(
              children: options.map((opt) {
                final isSelected = selectedFilter == opt['key'];
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onFilterChanged(opt['key']!),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? AppColors.accentBlue : AppColors.primary)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: (isDark ? AppColors.accentBlue : AppColors.primary)
                                      .withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          opt['label']!,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
