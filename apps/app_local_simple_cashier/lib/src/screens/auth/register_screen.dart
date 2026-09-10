import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../dashboard_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final bool isInitialOwnerSetup;
  final String? initialFullname;

  const RegisterScreen({
    super.key,
    this.isInitialOwnerSetup = false,
    this.initialFullname,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullnameController;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late String _selectedRole;
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _fullnameController = TextEditingController(text: widget.initialFullname ?? '');
    _selectedRole = widget.isInitialOwnerSetup ? 'owner' : 'owner';
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _authStore.register(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullname: _fullnameController.text.trim(),
        role: _selectedRole,
      );

      if (!mounted) return;

      if (success) {
        AppNotification.showSuccess(
          context,
          widget.isInitialOwnerSetup
              ? 'Akun Pemilik berhasil dibuat! Selamat datang di aplikasi.'
              : 'Pendaftaran akun berhasil!',
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
        );
      } else {
        AppNotification.showError(
          context,
          _authStore.errorMessage ?? 'Pendaftaran gagal.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: !widget.isInitialOwnerSetup,
      child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isInitialOwnerSetup ? 'Registrasi Akun Pemilik' : AppStrings.registerTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: !widget.isInitialOwnerSetup,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.isInitialOwnerSetup) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF064E3B).withValues(alpha: 0.3) : const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark ? const Color(0xFF047857) : const Color(0xFFA7F3D0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF059669).withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.verified_user_rounded, color: Color(0xFF059669), size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Setup Akun Pemilik (Owner)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF059669),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Toko berhasil dibuat! Silakan buat akun login pemilik untuk mengelola toko Anda.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          label: AppStrings.fullname,
                          hint: 'Nama Pemilik / Kasir',
                          controller: _fullnameController,
                          prefixIcon: Icons.badge_outlined,
                          validator: (v) => FormValidators.required(v, 'Nama lengkap wajib diisi'),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: AppStrings.username,
                          hint: 'Contoh: owner123',
                          controller: _usernameController,
                          prefixIcon: Icons.person_outline,
                          validator: (v) => FormValidators.required(v, 'Username wajib diisi'),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: AppStrings.email,
                          hint: 'email@example.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          validator: (v) => FormValidators.email(v),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: AppStrings.password,
                          hint: 'Minimal 6 karakter',
                          controller: _passwordController,
                          isPassword: true,
                          prefixIcon: Icons.lock_outline,
                          validator: (v) => FormValidators.password(v, 6),
                        ),
                        const SizedBox(height: 12),
                        if (widget.isInitialOwnerSetup) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF059669).withValues(alpha: 0.5),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.shield_rounded, color: Color(0xFF059669), size: 20),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Peran: Pemilik Toko (Owner)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xFF059669),
                                        ),
                                      ),
                                      Text(
                                        'Akses penuh manajemen toko, karyawan, dan laporan',
                                        style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.role,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary(context),
                                ),
                              ),
                              const SizedBox(height: 4),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedRole,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.security_outlined),
                                ),
                                dropdownColor: Theme.of(context).cardColor,
                                items: const [
                                  DropdownMenuItem(value: 'owner', child: Text('Pemilik Toko (Full Akses)')),
                                  DropdownMenuItem(value: 'cashier', child: Text('Karyawan / Kasir (POS & Transaksi)')),
                                ],
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedRole = val);
                                },
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 20),
                        Observer(
                          builder: (_) => AppButton(
                            label: widget.isInitialOwnerSetup ? 'Buat Akun & Masuk ke Toko' : AppStrings.signUp,
                            width: double.infinity,
                            height: 44,
                            isLoading: _authStore.isLoading,
                            onPressed: _handleRegister,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.isInitialOwnerSetup ? 'Sudah pernah membuat akun? ' : 'Sudah memiliki akun? ',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (widget.isInitialOwnerSetup) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          AppStrings.signIn,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryAccent(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
