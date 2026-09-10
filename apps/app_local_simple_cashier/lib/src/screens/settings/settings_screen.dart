import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../../stores/settings_store.dart';
import '../auth/login_screen.dart';
import '../backup/backup_restore_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
      appBar: AppBar(
        titleSpacing: 16,
        title: const Text('Pengaturan Aplikasi', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Observer(
        builder: (_) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            children: [
              // Active User Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFF1E3A8A),
                      child: Text(
                        user?.fullname.isNotEmpty == true ? user!.fullname[0].toUpperCase() : 'U',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFF60A5FA) : Colors.white,
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
                          const SizedBox(height: 2),
                          Text(
                            'Peran: ${user?.role.toUpperCase() ?? "-"} • @${user?.username ?? "-"}',
                            style: TextStyle(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626)),
                      tooltip: 'Keluar Akun',
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
              const SizedBox(height: 16),

              // Section 1: Tampilan & Tema (Theme Mode)
              _buildThemeSection(isDark),
              const SizedBox(height: 16),

              // Section 2: Bahasa & Regional (Language)
              _buildLanguageSection(isDark),
              const SizedBox(height: 16),

              // Section 3: Preferensi POS & Suara
              _buildPreferencesSection(isDark),
              const SizedBox(height: 16),

              // Section 4: Bluetooth Printer Section
              _buildPrinterSection(isDark),
              const SizedBox(height: 16),

              // Section 5: Backup & Restore Data Section
              _buildBackupRestoreSection(isDark),
              const SizedBox(height: 16),

              // Section 6: Store Profile Form
              _buildStoreProfileSection(isDark),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeSection(bool isDark) {
    final currentTheme = _settingsStore.themeMode;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette_outlined, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A), size: 20),
              const SizedBox(width: 8),
              Text(
                'Tampilan & Tema',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildThemeCard(
                  isDark: isDark,
                  title: 'Terang',
                  subtitle: 'Light',
                  icon: Icons.light_mode_rounded,
                  isSelected: currentTheme == ThemeMode.light,
                  onTap: () => _settingsStore.setThemeMode(ThemeMode.light),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildThemeCard(
                  isDark: isDark,
                  title: 'Gelap',
                  subtitle: 'Dark',
                  icon: Icons.dark_mode_rounded,
                  isSelected: currentTheme == ThemeMode.dark,
                  onTap: () => _settingsStore.setThemeMode(ThemeMode.dark),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildThemeCard(
                  isDark: isDark,
                  title: 'Sistem',
                  subtitle: 'Auto',
                  icon: Icons.brightness_auto_rounded,
                  isSelected: currentTheme == ThemeMode.system,
                  onTap: () => _settingsStore.setThemeMode(ThemeMode.system),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard({
    required bool isDark,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF1E3A8A) : const Color(0xFFEFF6FF))
              : (isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A))
                : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? (isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E3A8A))
                  : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
              size: 22,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 12,
                color: isSelected
                    ? (isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E3A8A))
                    : (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155)),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? (isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6))
                    : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(bool isDark) {
    final isIndonesian = _settingsStore.currentLocale.languageCode == 'id';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.language_rounded, color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7), size: 20),
              const SizedBox(width: 8),
              Text(
                'Bahasa Aplikasi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildLanguageCard(
                  isDark: isDark,
                  flagEmoji: '🇮🇩',
                  title: 'Bahasa Indonesia',
                  subtitle: 'Default (ID)',
                  isSelected: isIndonesian,
                  onTap: () => _settingsStore.setLanguage('id'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildLanguageCard(
                  isDark: isDark,
                  flagEmoji: '🇬🇧',
                  title: 'English',
                  subtitle: 'United States (EN)',
                  isSelected: !isIndonesian,
                  onTap: () => _settingsStore.setLanguage('en'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard({
    required bool isDark,
    required String flagEmoji,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF0C4A6E) : const Color(0xFFF0F9FF))
              : (isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7))
                : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Text(flagEmoji, style: const TextStyle(fontSize: 22)),
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
                      fontSize: 12,
                      color: isSelected
                          ? (isDark ? const Color(0xFF7DD3FC) : const Color(0xFF0284C7))
                          : (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155)),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected
                          ? (isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7))
                          : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune_rounded, color: isDark ? const Color(0xFF34D399) : const Color(0xFF059669), size: 20),
              const SizedBox(width: 8),
              Text(
                'Preferensi Operasional Kasir',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: const Text('Suara Beep Kasir', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
            subtitle: Text('Feedback suara saat menambah produk ke keranjang', style: TextStyle(fontSize: 10.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
            value: _settingsStore.isSoundEnabled,
            activeTrackColor: const Color(0xFF10B981),
            onChanged: (val) => _settingsStore.toggleSound(val),
          ),
          const Divider(height: 1),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: const Text('Cetak Otomatis Struk', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
            subtitle: Text('Otomatis cetak nota ke printer setelah transaksi selesai', style: TextStyle(fontSize: 10.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
            value: _settingsStore.isAutoPrintEnabled,
            activeTrackColor: const Color(0xFF10B981),
            onChanged: (val) => _settingsStore.toggleAutoPrint(val),
          ),
        ],
      ),
    );
  }

  Widget _buildPrinterSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.print_rounded, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Printer Thermal Bluetooth',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                  ),
                ),
              ),
              AppButton(
                label: 'Pindai',
                icon: Icons.bluetooth_searching_rounded,
                isLoading: _settingsStore.isScanningPrinters,
                height: 32,
                onPressed: () => _settingsStore.scanPrinters(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _settingsStore.connectedPrinter != null
                  ? (isDark ? const Color(0xFF064E3B) : const Color(0xFFF0FDF4))
                  : (isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC)),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _settingsStore.connectedPrinter != null
                    ? (isDark ? const Color(0xFF047857) : const Color(0xFFBBF7D0))
                    : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _settingsStore.connectedPrinter != null ? Icons.check_circle_rounded : Icons.bluetooth_disabled_rounded,
                  color: _settingsStore.connectedPrinter != null ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _settingsStore.connectedPrinter != null
                        ? 'Terhubung: ${_settingsStore.connectedPrinter!.name}'
                        : 'Belum ada printer bluetooth yang terhubung',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.5,
                      color: _settingsStore.connectedPrinter != null
                          ? (isDark ? const Color(0xFF6EE7B7) : const Color(0xFF15803D))
                          : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_settingsStore.connectedPrinter != null)
                  InkWell(
                    onTap: () => _settingsStore.disconnectPrinter(),
                    child: const Text('Putus', style: TextStyle(fontSize: 11, color: Color(0xFFDC2626), fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
          ),
          if (_settingsStore.availablePrinters.isNotEmpty) ...[
            const Divider(height: 20),
            Text(
              'Daftar Perangkat Terdeteksi:',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
              ),
            ),
            const SizedBox(height: 6),
            ..._settingsStore.availablePrinters.map((printer) {
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.print_outlined, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A), size: 20),
                title: Text(
                  printer.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                  ),
                ),
                subtitle: Text(printer.address, style: TextStyle(fontSize: 10, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                trailing: AppButton(
                  label: 'Hubungkan',
                  height: 30,
                  variant: AppButtonVariant.outline,
                  onPressed: () => _settingsStore.connectPrinter(printer),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildBackupRestoreSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_backup_restore_rounded,
                color: isDark ? const Color(0xFF2DD4BF) : const Color(0xFF0F766E),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Backup & Restore Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Amankan data transaksi, produk, dan laporan toko dengan mengekspor file cadangan (.json) atau memulihkan data dari file cadangan sebelumnya.',
            style: TextStyle(
              fontSize: 11,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BackupRestoreScreen()),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF042F2E) : const Color(0xFFF0FDFA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? const Color(0xFF115E59) : const Color(0xFF99F6E4),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F766E).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.cloud_sync_rounded,
                      color: Color(0xFF0D9488),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelola Backup & Restore',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            color: isDark ? const Color(0xFF5EEAD4) : const Color(0xFF0F766E),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ekspor file cadangan atau pulihkan database',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isDark ? const Color(0xFF5EEAD4) : const Color(0xFF0F766E),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreProfileSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.store_rounded, color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFD97706), size: 20),
              const SizedBox(width: 8),
              Text(
                'Informasi Profil Toko & Struk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Nama Toko / Usaha',
            hint: 'Nama Toko Anda',
            controller: _storeNameController,
          ),
          const SizedBox(height: 10),
          AppTextField(
            label: 'Nomor Telp / WhatsApp',
            hint: '08123456789',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          AppTextField(
            label: 'Alamat Toko',
            hint: 'Alamat lengkap toko Anda',
            controller: _addressController,
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          AppTextField(
            label: 'Pesan Header Struk',
            hint: 'Terima kasih atas kunjungan Anda',
            controller: _headerController,
          ),
          const SizedBox(height: 10),
          AppTextField(
            label: 'Pesan Footer Struk',
            hint: 'Barang yang dibeli tidak dapat ditukar',
            controller: _footerController,
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Simpan Profil Toko',
            height: 42,
            onPressed: _handleSaveStoreProfile,
          ),
        ],
      ),
    );
  }
}
