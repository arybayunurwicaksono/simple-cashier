import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:core/core.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final void Function(String)? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;
  final bool autofocus;

  const AppSearchBar({
    super.key,
    this.controller,
    this.hint = 'Cari barang atau jasa...',
    this.onChanged,
    this.onClear,
    this.onFilterTap,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border(context),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 22, color: AppColors.textSecondary(context)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: autofocus,
              onChanged: onChanged,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary(context),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: AppColors.textMuted(context),
                  fontSize: 13.5,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (controller != null && controller!.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.cancel, size: 18, color: AppColors.textMuted(context)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              onPressed: () {
                controller?.clear();
                onClear?.call();
              },
            ),
          if (onFilterTap != null) ...[
            const SizedBox(width: 6),
            Container(
              height: 24,
              width: 1,
              color: AppColors.border(context),
            ),
            const SizedBox(width: 6),
            IconButton(
              icon: Icon(Icons.tune_rounded, size: 20, color: AppColors.primaryAccent(context)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              onPressed: onFilterTap,
            ),
          ],
        ],
      ),
    );
  }
}
