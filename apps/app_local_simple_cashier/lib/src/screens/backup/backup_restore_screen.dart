import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/backup_store.dart';
import '../../stores/settings_store.dart';
import '../../stores/product_store.dart';
import '../../stores/service_store.dart';
import '../../stores/accounting_store.dart';
import '../../stores/balance_store.dart';

class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  final _backupStore = getIt<BackupStore>();

  Future<void> _handleExport() async {
    final file = await _backupStore.exportAndShareDatabase();

    if (!mounted) return;

    if (file != null) {
      AppNotification.showSuccess(
        context,
        'File backup database berhasil dibuat & siap dibagikan!',
      );
    } else if (_backupStore.errorMessage != null) {
      AppNotification.showError(
        context,
        _backupStore.errorMessage!,
      );
    }
  }

  Future<void> _handlePickFile() async {
    final success = await _backupStore.selectAndPreviewBackupFile();

    if (!mounted) return;

    if (!success && _backupStore.errorMessage != null) {
      AppNotification.showError(
        context,
        _backupStore.errorMessage!,
      );
    }
  }

  void _handleConfirmRestore() {
    ConfirmationDialog.show(
      context,
      title: 'PENTING: Pulihkan Data Toko?',
      message:
          'Data yang ada saat ini di database lokal akan ditimpa (overwrite) oleh data dari file backup yang Anda pilih.\n\nApakah Anda yakin ingin melanjutkan proses restore?',
      isDanger: true,
      onConfirm: () async {
        final success = await _backupStore.executeRestore(
          onReloadAllStores: () async {
            getIt<ProductStore>().loadProducts();
            getIt<ServiceStore>().loadServices();
            getIt<AccountingStore>().loadLedgers();
            getIt<BalanceStore>().loadBalances();
            getIt<SettingsStore>().loadSettings();
          },
        );

        if (!mounted) return;

        if (success) {
          AppNotification.showSuccess(
            context,
            'Semua data database toko berhasil dipulihkan (Restored)!',
          );
        } else if (_backupStore.errorMessage != null) {
          AppNotification.showError(
            context,
            _backupStore.errorMessage!,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: const Text('Backup & Restore Data', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Observer(
        builder: (_) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            children: [
              // Header Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.shield_rounded, color: Color(0xFF38BDF8), size: 30),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keamanan Data Lokal',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Semua data toko tersimpan aman di HP. Lakukan backup berkala ke Google Drive / WA agar data tetap aman saat ganti perangkat.',
                            style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Section 1: Export Card
              _buildExportCard(context, isDark),
              const SizedBox(height: 16),

              // Section 2: Import Card
              _buildImportCard(context, isDark),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExportCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF059669), Color(0xFF10B981)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF059669).withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.file_download_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ekspor Data Keseluruhan (Backup)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    Text(
                      'Katalog, Nota Transaksi, Kas & Pembukuan',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary(context)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Menghasilkan file arsip .json yang berisi seluruh isi database toko. Anda dapat membagikannya langsung ke Google Drive, WhatsApp, atau menyimpannya di file manager.',
            style: TextStyle(fontSize: 11.5, color: AppColors.borderSubtle(context), height: 1.35),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: _backupStore.isExporting ? 'Sedang Mengekspor...' : 'Ekspor & Bagikan Backup',
            icon: Icons.share_rounded,
            height: 42,
            width: double.infinity,
            isLoading: _backupStore.isExporting,
            onPressed: _backupStore.isExporting ? null : _handleExport,
          ),
        ],
      ),
    );
  }

  Widget _buildImportCard(BuildContext context, bool isDark) {
    final hasPending = _backupStore.hasPendingRestore;
    final metadata = _backupStore.pendingMetadata;
    final counts = metadata?['counts'] as Map<String, dynamic>?;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasPending ? AppColors.primaryLight : AppColors.border(context),
          width: hasPending ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: hasPending
                ? AppColors.primaryLight.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.file_upload_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Impor / Pulihkan Data (Restore)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: AppColors.textPrimary(context),
                      ),
                    ),
                    Text(
                      'Pulihkan dari file cadangan .json',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary(context)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Pilih file backup .json yang telah dibuat sebelumnya untuk mengembalikan seluruh catatan penjualan, stok produk, dan laporan keuangan.',
            style: TextStyle(fontSize: 11.5, color: AppColors.borderSubtle(context), height: 1.35),
          ),
          const SizedBox(height: 14),

          if (!hasPending) ...[
            AppButton(
              label: _backupStore.isLoading ? 'Memeriksa File...' : 'Pilih File Backup (.json)',
              variant: AppButtonVariant.outline,
              icon: Icons.folder_open_rounded,
              height: 42,
              width: double.infinity,
              isLoading: _backupStore.isLoading,
              onPressed: _backupStore.isLoading ? null : _handlePickFile,
            ),
          ] else ...[
            // Preview Card of selected backup
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.infoContainerAdaptive(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isDark ? AppColors.info : const Color(0xFFBAE6FD)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle_rounded, color: isDark ? AppColors.infoDark : AppColors.info, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'File Backup Valid & Terverifikasi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                          color: isDark ? const Color(0xFF7DD3FC) : const Color(0xFF0369A1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Toko: ${metadata?['storeName'] ?? "-"}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary(context))),
                  Text(
                    'Waktu Backup: ${metadata?['exportedAt'] != null ? DateFormatter.formatFull(DateTime.tryParse(metadata!['exportedAt']) ?? DateTime.now()) : "-"}',
                    style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary(context)),
                  ),
                  const Divider(height: 16),
                  Text('Rincian Isi Data Backup:', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary(context))),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _buildChip(context, 'Barang', '${counts?['products'] ?? 0}'),
                      _buildChip(context, 'Jasa', '${counts?['services'] ?? 0}'),
                      _buildChip(context, 'Transaksi', '${counts?['transactions'] ?? 0}'),
                      _buildChip(context, 'Arus Kas', '${counts?['balanceLogs'] ?? 0}'),
                      _buildChip(context, 'Buku Bulanan', '${counts?['monthlyAccounting'] ?? 0}'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Batal',
                    variant: AppButtonVariant.outline,
                    height: 40,
                    onPressed: () => _backupStore.cancelPendingRestore(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    label: _backupStore.isRestoring ? 'Memulihkan...' : 'Ya, Pulihkan Data',
                    variant: AppButtonVariant.danger,
                    icon: Icons.restore_rounded,
                    height: 40,
                    isLoading: _backupStore.isRestoring,
                    onPressed: _backupStore.isRestoring ? null : _handleConfirmRestore,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary(context),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
