import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/employee_store.dart';

class EmployeeFormDialog extends StatefulWidget {
  final UserData? employee; // null for create, not null for edit

  const EmployeeFormDialog({super.key, this.employee});

  static Future<bool?> show(BuildContext context, {UserData? employee}) {
    return showDialog<bool>(
      context: context,
      builder: (_) => EmployeeFormDialog(employee: employee),
    );
  }

  @override
  State<EmployeeFormDialog> createState() => _EmployeeFormDialogState();
}

class _EmployeeFormDialogState extends State<EmployeeFormDialog> {
  final _employeeStore = getIt<EmployeeStore>();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullnameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late String _selectedRole;
  bool _isSaving = false;

  bool get _isEdit => widget.employee != null;

  @override
  void initState() {
    super.initState();
    _fullnameController = TextEditingController(text: widget.employee?.fullname ?? '');
    _usernameController = TextEditingController(text: widget.employee?.username ?? '');
    _emailController = TextEditingController(text: widget.employee?.email ?? '');
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _selectedRole = widget.employee?.role ?? 'cashier';
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_isEdit || _passwordController.text.isNotEmpty) {
      if (_passwordController.text != _confirmPasswordController.text) {
        AppNotification.showWarning(context, 'Konfirmasi kata sandi tidak cocok');
        return;
      }
    }

    setState(() => _isSaving = true);

    bool success;
    if (_isEdit) {
      success = await _employeeStore.updateEmployee(
        userId: widget.employee!.id,
        fullname: _fullnameController.text.trim(),
        email: _emailController.text.trim(),
        role: _selectedRole,
        newPassword: _passwordController.text.trim().isEmpty ? null : _passwordController.text.trim(),
      );
    } else {
      success = await _employeeStore.addEmployee(
        username: _usernameController.text.trim(),
        fullname: _fullnameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: _selectedRole,
      );
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (success) {
      AppNotification.showSuccess(
        context,
        _isEdit ? 'Data akun karyawan berhasil diperbarui' : 'Akun karyawan baru berhasil ditambahkan',
      );
      Navigator.pop(context, true);
    } else {
      AppNotification.showError(
        context,
        _employeeStore.errorMessage ?? 'Gagal menyimpan data karyawan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
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
                        color: _isEdit
                            ? const Color(0xFF0284C7).withValues(alpha: 0.15)
                            : const Color(0xFF059669).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _isEdit ? Icons.edit_rounded : Icons.person_add_rounded,
                        color: _isEdit ? const Color(0xFF0284C7) : const Color(0xFF059669),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isEdit ? 'Edit Akun Karyawan' : 'Tambah Akun Karyawan',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isEdit ? 'Ubah informasi identitas dan peran' : 'Daftarkan kasir atau staf baru',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Full Name
                AppTextField(
                  label: 'Nama Lengkap *',
                  hint: 'Contoh: Ahmad Fauzi',
                  controller: _fullnameController,
                  validator: (val) => FormValidators.required(val, 'Nama lengkap'),
                ),
                const SizedBox(height: 12),

                // Username
                AppTextField(
                  label: 'Username *',
                  hint: 'ahmad_kasir',
                  controller: _usernameController,
                  readOnly: _isEdit, // Username cannot be changed once created for security
                  validator: (val) => FormValidators.required(val, 'Username'),
                ),
                if (_isEdit) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Username tidak dapat diubah untuk menjaga integritas riwayat log.',
                    style: TextStyle(fontSize: 10.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                  ),
                ],
                const SizedBox(height: 12),

                // Email
                AppTextField(
                  label: 'Alamat Email *',
                  hint: 'ahmad@toko.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => FormValidators.email(val),
                ),
                const SizedBox(height: 12),

                // Role Selector
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Peran Akun / Hak Akses *',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: _buildRoleRadioCard(
                            isDark: isDark,
                            roleValue: 'cashier',
                            title: 'Kasir / Staf',
                            subtitle: 'Transaksi & Restock',
                            icon: Icons.point_of_sale_rounded,
                            isSelected: _selectedRole == 'cashier',
                            color: const Color(0xFF0284C7),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildRoleRadioCard(
                            isDark: isDark,
                            roleValue: 'owner',
                            title: 'Pemilik (Owner)',
                            subtitle: 'Akses Penuh Toko',
                            icon: Icons.shield_rounded,
                            isSelected: _selectedRole == 'owner',
                            color: const Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Password Fields
                AppTextField(
                  label: _isEdit ? 'Kata Sandi Baru (Kosongkan jika tidak diubah)' : 'Kata Sandi *',
                  hint: '••••••••',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (val) {
                    if (!_isEdit && (val == null || val.trim().isEmpty)) {
                      return 'Kata sandi wajib diisi';
                    }
                    if (val != null && val.isNotEmpty && val.length < 4) {
                      return 'Kata sandi minimal 4 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                AppTextField(
                  label: _isEdit ? 'Konfirmasi Kata Sandi Baru' : 'Konfirmasi Kata Sandi *',
                  hint: '••••••••',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (val) {
                    if (!_isEdit && (val == null || val.trim().isEmpty)) {
                      return 'Konfirmasi kata sandi wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 22),

                // Buttons
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
                        label: _isEdit ? 'Simpan Perubahan' : 'Tambah Akun',
                        variant: AppButtonVariant.primary,
                        height: 42,
                        isLoading: _isSaving,
                        onPressed: _handleSubmit,
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

  Widget _buildRoleRadioCard({
    required bool isDark,
    required String roleValue,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required Color color,
  }) {
    return InkWell(
      onTap: () => setState(() => _selectedRole = roleValue),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: isDark ? 0.2 : 0.1)
              : (isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? color : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)), size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 11.5,
                      color: isSelected ? color : (isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A)),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9.5,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: color, size: 16),
          ],
        ),
      ),
    );
  }
}
