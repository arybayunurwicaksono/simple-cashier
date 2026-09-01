import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authStore = getIt<AuthStore>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _authStore.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        AppNotification.showError(
          context,
          _authStore.errorMessage ?? 'Login gagal. Periksa username dan password.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainerAdaptive(context),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.store_outlined,
                        size: 36,
                        color: AppColors.primaryAccent(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.loginTitle,
                    style: AppTextStyles.displayMedium.copyWith(
                      color: AppColors.textPrimary(context),
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.loginSubtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary(context),
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Inputs Card
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
                          label: 'Username atau Email',
                          hint: 'Masukkan username / email',
                          controller: _usernameController,
                          prefixIcon: Icons.person_outline,
                          validator: (v) => FormValidators.required(v, 'Username / Email wajib diisi'),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          label: AppStrings.password,
                          hint: 'Masukkan password',
                          controller: _passwordController,
                          isPassword: true,
                          prefixIcon: Icons.lock_outline,
                          validator: (v) => FormValidators.required(v, 'Password wajib diisi'),
                        ),
                        const SizedBox(height: 20),
                        Observer(
                          builder: (_) => AppButton(
                            label: AppStrings.signIn,
                            width: double.infinity,
                            height: 42,
                            isLoading: _authStore.isLoading,
                            onPressed: _handleLogin,
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
                        'Belum memiliki akun kasir? ',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                        child: Text(
                          AppStrings.signUp,
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
