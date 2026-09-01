import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../di/injection.dart';
import '../stores/auth_store.dart';
import 'auth/login_screen.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _checkInitialState();
  }

  Future<void> _checkInitialState() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    await _authStore.initAuth();

    if (!mounted) return;

    if (_authStore.isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.point_of_sale_rounded,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.appName,
              style: AppTextStyles.displayMedium.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              AppStrings.appTagline,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 36),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
