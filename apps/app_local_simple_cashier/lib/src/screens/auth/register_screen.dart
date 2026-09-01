import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'owner';
  final _authStore = getIt<AuthStore>();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.registerTitle),
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
                        const SizedBox(height: 20),
                        Observer(
                          builder: (_) => AppButton(
                            label: AppStrings.signUp,
                            width: double.infinity,
                            height: 42,
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
                        'Sudah memiliki akun? ',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
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
    );
  }
}
