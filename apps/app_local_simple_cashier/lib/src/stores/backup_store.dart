// ignore_for_file: library_private_types_in_public_api
import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'backup_store.g.dart';

class BackupStore = _BackupStore with _$BackupStore;

abstract class _BackupStore with Store {
  final BackupDao _backupDao;
  final StoreProfileDao _storeProfileDao;
  final BackupService _backupService;

  _BackupStore({
    required BackupDao backupDao,
    required StoreProfileDao storeProfileDao,
    required BackupService backupService,
  })  : _backupDao = backupDao,
        _storeProfileDao = storeProfileDao,
        _backupService = backupService;

  @observable
  bool isLoading = false;

  @observable
  bool isExporting = false;

  @observable
  bool isRestoring = false;

  @observable
  String? statusMessage;

  @observable
  String? errorMessage;

  @observable
  File? lastExportedFile;

  @observable
  Map<String, dynamic>? pendingRestoreData;

  @computed
  bool get hasPendingRestore => pendingRestoreData != null;

  @computed
  Map<String, dynamic>? get pendingMetadata =>
      pendingRestoreData != null ? pendingRestoreData!['metadata'] as Map<String, dynamic>? : null;

  @action
  Future<File?> exportAndShareDatabase() async {
    isExporting = true;
    errorMessage = null;
    statusMessage = 'Mengekspor seluruh database...';
    try {
      final store = await _storeProfileDao.getStoreProfile();
      final data = await _backupDao.exportAllData(appVersion: '1.0.0');
      final file = await _backupService.generateBackupFile(data: data);
      lastExportedFile = file;

      await _backupService.shareBackupFile(file, storeName: store?.storeName);
      statusMessage = 'Backup berhasil diekspor!';
      return file;
    } catch (e) {
      errorMessage = 'Gagal mengekspor data: ${e.toString()}';
      return null;
    } finally {
      isExporting = false;
    }
  }

  @action
  Future<bool> selectAndPreviewBackupFile() async {
    isLoading = true;
    errorMessage = null;
    statusMessage = 'Memeriksa file backup...';
    try {
      final data = await _backupService.pickAndValidateBackupFile();
      if (data == null) {
        statusMessage = null;
        return false;
      }

      pendingRestoreData = data;
      statusMessage = 'File backup valid dan siap dipulihkan.';
      return true;
    } catch (e) {
      errorMessage = e.toString();
      pendingRestoreData = null;
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> executeRestore({
    required Function onReloadAllStores,
  }) async {
    if (pendingRestoreData == null) {
      errorMessage = 'Tidak ada file backup yang dipilih.';
      return false;
    }

    isRestoring = true;
    errorMessage = null;
    statusMessage = 'Memulihkan data ke database...';
    try {
      final success = await _backupDao.restoreAllData(pendingRestoreData!);

      if (success) {
        pendingRestoreData = null;
        statusMessage = 'Data berhasil dipulihkan secara menyeluruh!';
        await onReloadAllStores();
        return true;
      } else {
        errorMessage = 'Gagal memulihkan data database.';
        return false;
      }
    } catch (e) {
      errorMessage = 'Terjadi kesalahan saat memulihkan: ${e.toString()}';
      return false;
    } finally {
      isRestoring = false;
    }
  }

  @action
  void cancelPendingRestore() {
    pendingRestoreData = null;
    errorMessage = null;
    statusMessage = null;
  }
}
