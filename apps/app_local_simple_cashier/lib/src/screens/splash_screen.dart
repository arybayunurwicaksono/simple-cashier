import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../di/injection.dart';
import '../stores/auth_store.dart';
import '../stores/store_store.dart';
import 'auth/register_screen.dart';
import 'auth/login_screen.dart';
import 'dashboard_screen.dart';
import 'store/store_selection_screen.dart';
import 'store/store_setup_wizard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storeStore = getIt<StoreStore>();

  @override
  void initState() {
    super.initState();
    _checkInitialState();
  }

  Future<void> _checkInitialState() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final authStore = getIt<AuthStore>();
    final userDao = getIt<UserDao>();

    await _storeStore.loadStores();
    await authStore.initAuth();

    if (!mounted) return;

    // 1. Belum ada toko terdaftar -> Wizard Setup Toko Pertama
    if (_storeStore.storeCount == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const StoreSetupWizardScreen()),
      );
      return;
    }

    // 2. Ada toko, periksa apakah akun Owner sudah terdaftar
    final allUsers = await userDao.getAllUsers();
    final hasOwner = allUsers.any((u) => u.role == 'owner');

    if (!mounted) return;

    if (!hasOwner) {
      // Toko sudah dibuat tetapi registrasi owner tertutup sebelum selesai
      final activeOrFirstStore = _storeStore.activeStore ?? _storeStore.storeList.firstOrNull;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => RegisterScreen(
            isInitialOwnerSetup: true,
            initialFullname: activeOrFirstStore?.ownerName,
          ),
        ),
      );
      return;
    }

    // 3. Ada toko & akun Owner sudah ada -> cek status autentikasi
    if (authStore.isAuthenticated) {
      if (_storeStore.hasActiveStore) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => StoreSelectionScreen(
              autoPromptStoreId: _storeStore.defaultStoreId,
            ),
          ),
        );
      }
    } else {
      // Belum login
      if (_storeStore.hasActiveStore) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => StoreSelectionScreen(
              autoPromptStoreId: _storeStore.defaultStoreId,
            ),
          ),
        );
      }
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
