import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../../stores/settings_store.dart';
import '../settings/settings_screen.dart';
import '../catalog/catalog_management_screen.dart';
import '../store/store_selection_screen.dart';
import '../employee/employee_management_screen.dart';
import '../../stores/store_store.dart';

class AppEndDrawer extends StatelessWidget {
  const AppEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = getIt<AuthStore>();
    final settingsStore = getIt<SettingsStore>();
    final isDark = AppColors.isDark(context);

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with Store Info
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
              ),
              child: Observer(
                builder: (_) {
                  final user = authStore.currentUser;
                  final store = settingsStore.storeProfile;
                  final storeName = (store != null && store.storeName.trim().isNotEmpty)
                      ? store.storeName.trim()
                      : 'Simple Cashier Store';
                  final userName = (user != null && user.fullname.trim().isNotEmpty)
                      ? user.fullname.trim()
                      : 'Kasir';
                  final role = user?.role.toUpperCase() ?? 'OWNER';

                  return Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primaryAccent(context).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.storefront_rounded,
                          color: AppColors.primaryAccent(context),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              storeName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.textPrimary(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: authStore.isOwner
                                    ? const Color(0xFF059669).withValues(alpha: 0.25)
                                    : const Color(0xFF0284C7).withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: authStore.isOwner
                                      ? const Color(0xFF10B981).withValues(alpha: 0.4)
                                      : const Color(0xFF38BDF8).withValues(alpha: 0.4),
                                ),
                              ),
                              child: Text(
                                '$userName • $role',
                                style: TextStyle(
                                  color: authStore.isOwner ? const Color(0xFF6EE7B7) : const Color(0xFFBAE6FD),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Drawer Items List (Gradient Cards)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                children: [
                  // 0. Katalog Barang & Jasa Card
                  _buildDrawerGradientCard(
                    context: context,
                    title: 'Katalog Barang & Jasa',
                    subtitle: 'Kelola daftar produk, stok & tarif jasa',
                    icon: Icons.inventory_2_rounded,
                    gradientColors: const [Color(0xFF0D9488), Color(0xFF14B8A6)],
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CatalogManagementScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 1. Settings & Preferences Card
                  _buildDrawerGradientCard(
                    context: context,
                    title: 'Pengaturan Aplikasi',
                    subtitle: 'Printer, backup data, tema & sistem',
                    icon: Icons.settings_rounded,
                    gradientColors: const [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // Ganti Toko Card
                  _buildDrawerGradientCard(
                    context: context,
                    title: 'Ganti Toko / Beralih Usaha',
                    subtitle: 'Beralih ke toko atau cabang lain',
                    icon: Icons.swap_horiz_rounded,
                    gradientColors: const [Color(0xFF0D9488), Color(0xFF14B8A6)],
                    onTap: () {
                      Navigator.pop(context);
                      ConfirmationDialog.show(
                        context,
                        title: 'Ganti Toko?',
                        message: 'Sesi toko saat ini akan ditutup dan Anda akan kembali ke daftar pilihan toko.',
                        onConfirm: () async {
                          final nav = Navigator.of(context);
                          final storeStore = getIt<StoreStore>();
                          await storeStore.switchStore();
                          nav.pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const StoreSelectionScreen()),
                            (route) => false,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 2. Multi-Cashier & Staff Management Card
                  _buildDrawerGradientCard(
                    context: context,
                    title: 'Manajemen Akun & Log Karyawan',
                    subtitle: authStore.isOwner
                        ? 'Kelola akun kasir & pantau log aktivitas'
                        : 'Khusus Akun Pemilik (Owner)',
                    icon: Icons.people_alt_rounded,
                    gradientColors: authStore.isOwner
                        ? const [Color(0xFF059669), Color(0xFF10B981)]
                        : (isDark ? const [Color(0xFF334155), Color(0xFF475569)] : const [Color(0xFF475569), Color(0xFF64748B)]),
                    trailing: authStore.isOwner
                        ? null
                        : Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 14),
                          ),
                    onTap: () {
                      Navigator.pop(context);
                      if (authStore.isOwner) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const EmployeeManagementScreen()),
                        );
                      } else {
                        AppNotification.showError(
                          context,
                          'Akses ditolak: Hanya Pemilik Toko yang dapat mengelola kasir & staf.',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),

                  // 5. Panduan Kasir Offline Card
                  _buildDrawerGradientCard(
                    context: context,
                    title: 'Panduan Kasir Offline',
                    subtitle: 'Petunjuk & panduan transaksi toko',
                    icon: Icons.menu_book_rounded,
                    gradientColors: const [Color(0xFFD97706), Color(0xFFF59E0B)],
                    onTap: () {
                      Navigator.pop(context);
                      _showHelpDialog(context);
                    },
                  ),
                  const SizedBox(height: 10),

                  // 6. Tentang Aplikasi Card
                  _buildDrawerGradientCard(
                    context: context,
                    title: 'Tentang Aplikasi',
                    subtitle: 'Simple Cashier v1.0.0 Local Offline',
                    icon: Icons.info_outline_rounded,
                    gradientColors: const [Color(0xFF6D28D9), Color(0xFF8B5CF6)],
                    onTap: () {
                      Navigator.pop(context);
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            ),

            // Logout Footer Card / Button
            Padding(
              padding: const EdgeInsets.all(14),
              child: InkWell(
                onTap: () {
                  ConfirmationDialog.show(
                    context,
                    title: 'Tutup Sesi Toko?',
                    message: 'Anda akan keluar dari sesi toko aktif dan kembali ke daftar pilihan toko.',
                    isDanger: true,
                    onConfirm: () async {
                      final nav = Navigator.of(context);
                      final storeStore = getIt<StoreStore>();
                      await storeStore.switchStore();
                      await authStore.logout();
                      nav.pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const StoreSelectionScreen()),
                        (route) => false,
                      );
                    },
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainerAdaptive(context),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFECACA)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.store_rounded, color: isDark ? AppColors.errorDark : AppColors.error, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Keluar Sesi Toko',
                        style: TextStyle(
                          color: isDark ? AppColors.errorDark : AppColors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerGradientCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withValues(alpha: 0.28),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.menu_book_rounded, color: AppColors.primaryAccent(context)),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('Panduan Kasir', style: TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('1. Tombol Tengah (Kasir):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('Tekan tombol lingkaran biru di tengah untuk membuka POS kasir transaksi belanja.', style: TextStyle(fontSize: 12)),
              SizedBox(height: 8),
              Text('2. Katalog & Foto:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('Kelola foto produk & jasa di menu Katalog.', style: TextStyle(fontSize: 12)),
              SizedBox(height: 8),
              Text('3. Cetak Struk Bluetooth:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('Pastikan Bluetooth dan GPS aktif saat menghubungkan printer thermal.', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.store_rounded, color: AppColors.primaryAccent(context)),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('Simple Cashier', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Versi: 1.0.0 (Local SQLite Offline Mode)', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              'Aplikasi kasir & pembukuan lokal tanpa internet.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary(context)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
  }
}
