import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/employee_store.dart';

class EmployeeResetPasswordDialog extends StatefulWidget {
  final UserData employee;

  const EmployeeResetPasswordDialog({super.key, required this.employee});

  static Future<bool?> show(BuildContext context, {required UserData employee}) {
    return showDialog<bool>(
      context: context,
      builder: (_) => EmployeeResetPasswordDialog(employee: employee),
    );
  }

  @override
  State<EmployeeResetPasswordDialog> createState() => _EmployeeResetPasswordDialogState();
}

class _EmployeeResetPasswordDialogState extends State<EmployeeResetPasswordDialog> {
  final _employeeStore = getIt<EmployeeStore>();
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      AppNotification.showWarning(context, 'Konfirmasi kata sandi tidak cocok');
      return;
    }

    setState(() => _isLoading = true);

    final success = await _employeeStore.resetPassword(
      userId: widget.employee.id,
      newPassword: _passwordController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      AppNotification.showSuccess(
        context,
        'Kata sandi untuk ${widget.employee.fullname} berhasil diperbarui',
      );
      Navigator.pop(context, true);
    } else {
      AppNotification.showError(
        context,
        _employeeStore.errorMessage ?? 'Gagal mereset kata sandi',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAB308).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.lock_reset_rounded, color: Color(0xFFCA8A04), size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Reset Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 2),
                          Text(
                            'Karyawan: ${widget.employee.fullname} (@${widget.employee.username})',
                            style: TextStyle(fontSize: 11.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                AppTextField(
                  label: 'Kata Sandi Baru *',
                  hint: '••••••••',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Kata sandi wajib diisi';
                    if (val.length < 4) return 'Minimal 4 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                AppTextField(
                  label: 'Konfirmasi Kata Sandi Baru *',
                  hint: '••••••••',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Konfirmasi wajib diisi';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Batal',
                        variant: AppButtonVariant.outline,
                        height: 42,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton(
                        label: 'Simpan',
                        variant: AppButtonVariant.primary,
                        height: 42,
                        isLoading: _isLoading,
                        onPressed: _handleReset,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
