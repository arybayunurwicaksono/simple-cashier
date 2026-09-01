import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../atoms/app_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final bool isDanger;
  final IconData icon;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Ya, Lanjutkan',
    this.cancelText = 'Batal',
    required this.onConfirm,
    this.isDanger = false,
    this.icon = Icons.info_outline,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Ya, Lanjutkan',
    String cancelText = 'Batal',
    required VoidCallback onConfirm,
    bool isDanger = false,
    IconData icon = Icons.info_outline,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () {
          Navigator.of(ctx).pop(true);
          onConfirm();
        },
        isDanger: isDanger,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDanger
                    ? AppColors.errorContainerAdaptive(context)
                    : AppColors.infoContainerAdaptive(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color: isDanger
                    ? (isDark ? AppColors.errorDark : AppColors.error)
                    : (isDark ? AppColors.infoDark : AppColors.info),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary(context),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: cancelText,
                    variant: AppButtonVariant.outline,
                    height: 40,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    label: confirmText,
                    variant: isDanger ? AppButtonVariant.danger : AppButtonVariant.primary,
                    height: 40,
                    onPressed: onConfirm,
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
