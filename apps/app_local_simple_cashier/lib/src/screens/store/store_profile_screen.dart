import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../../stores/settings_store.dart';
import '../settings/settings_screen.dart';
import '../auth/login_screen.dart';
import '../widgets/app_end_drawer.dart';

class StoreProfileScreen extends StatefulWidget {
  final VoidCallback? onOpenEndDrawer;

  const StoreProfileScreen({
    super.key,
    this.onOpenEndDrawer,
  });

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  final _authStore = getIt<AuthStore>();
  final _settingsStore = getIt<SettingsStore>();

  final _storeNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _headerController = TextEditingController();
  final _footerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _settingsStore.loadSettings().then((_) {
      final store = _settingsStore.storeProfile;
      if (store != null) {
        _storeNameController.text = store.storeName;
        _addressController.text = store.address;
        _phoneController.text = store.phone;
        _headerController.text = store.headerMessage;
        _footerController.text = store.footerMessage;
      }
    });
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _headerController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveStoreProfile() async {
    if (_storeNameController.text.trim().isEmpty) {
      AppNotification.showWarning(
        context,
        'Nama toko wajib diisi',
      );
      return;
    }

    final success = await _settingsStore.updateStoreProfile(
      storeName: _storeNameController.text.trim(),
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
      headerMessage: _headerController.text.trim(),
      footerMessage: _footerController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      AppNotification.showSuccess(
        context,
        'Profil toko berhasil disimpan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authStore.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      endDrawer: const AppEndDrawer(),
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profil Toko & Akun',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Informasi bisnis, struk kasir & staf',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu_rounded),
              tooltip: 'Buka Menu',
              onPressed: () {
                if (widget.onOpenEndDrawer != null) {
                  widget.onOpenEndDrawer!();
                } else {
                  Scaffold.of(ctx).openEndDrawer();
                }
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        children: [
          // Active User Info Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: isDark ? AppColors.primaryDark : AppColors.primaryContainer,
                  child: Text(
                    user?.fullname.isNotEmpty == true ? user!.fullname[0].toUpperCase() : 'U',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryAccent(context),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user?.fullname ?? 'Pengguna',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Role: ${user?.role.toUpperCase() ?? "-"} • @${user?.username ?? "-"}',
                        style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                  onPressed: () {
                    ConfirmationDialog.show(
                      context,
                      title: 'Keluar Akun?',
                      message: 'Anda akan keluar dari sesi kasir aktif.',
                      isDanger: true,
                      onConfirm: () async {
                        final nav = Navigator.of(context);
                        await _authStore.logout();
                        nav.pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Printer Shortcut Card
          Observer(
            builder: (_) {
              final isConnected = _settingsStore.connectedPrinter != null;
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isConnected
                        ? (isDark ? const Color(0xFF064E3B) : const Color(0xFFECFDF5))
                        : (isDark ? const Color(0xFF451A03) : const Color(0xFFFFFBEB)),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isConnected
                          ? (isDark ? const Color(0xFF047857) : const Color(0xFFA7F3D0))
                          : (isDark ? const Color(0xFF78350F) : const Color(0xFFFDE68A)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.print_rounded,
                        color: isConnected
                            ? (isDark ? const Color(0xFF34D399) : const Color(0xFF059669))
                            : (isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706)),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isConnected
                                  ? 'Printer: ${_settingsStore.connectedPrinter!.name}'
                                  : 'Printer Belum Terhubung',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                                color: isConnected
                                    ? (isDark ? const Color(0xFF6EE7B7) : const Color(0xFF065F46))
                                    : (isDark ? const Color(0xFFFDE68A) : const Color(0xFF92400E)),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              isConnected ? 'Siap mencetak struk kasir' : 'Ketuk untuk scan & sambungkan printer',
                              style: TextStyle(
                                fontSize: 10.5,
                                color: isConnected
                                    ? (isDark ? const Color(0xFFA7F3D0) : const Color(0xFF047857))
                                    : (isDark ? const Color(0xFFFCD34D) : const Color(0xFFB45309)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Store Profile Form Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Informasi Toko & Header Struk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                ),
              ),
              if (!_authStore.isOwner)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock_outline_rounded, size: 12, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Text(
                        'Mode Lihat (Kasir)',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  label: 'Nama Toko / Usaha',
                  hint: 'Nama Toko Anda',
                  controller: _storeNameController,
                  readOnly: !_authStore.isOwner,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: 'Nomor Telp / WA Toko',
                  hint: '08123456789',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  readOnly: !_authStore.isOwner,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: 'Alamat Toko',
                  hint: 'Alamat lengkap lokasi usaha',
                  controller: _addressController,
                  maxLines: 2,
                  readOnly: !_authStore.isOwner,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: 'Pesan Header Nota (Atas)',
                  hint: 'Terima kasih atas kunjungan Anda',
                  controller: _headerController,
                  readOnly: !_authStore.isOwner,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: 'Pesan Footer Nota (Bawah)',
                  hint: 'Barang yang dibeli tidak dapat ditukar',
                  controller: _footerController,
                  readOnly: !_authStore.isOwner,
                ),
                if (_authStore.isOwner) ...[
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Simpan Profil Toko',
                    height: 42,
                    onPressed: _handleSaveStoreProfile,
                  ),
                ] else ...[
                  const SizedBox(height: 12),
                  const Text(
                    '* Pengaturan identitas toko hanya dapat diubah oleh akun Pemilik (Owner).',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontStyle: FontStyle.italic),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
