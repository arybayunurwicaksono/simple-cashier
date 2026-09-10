// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'store_store.g.dart';

class StoreStore = _StoreStore with _$StoreStore;

abstract class _StoreStore with Store {
  final StoreDao _storeDao;
  final SecureStorageService _secureStorage;

  _StoreStore({
    required StoreDao storeDao,
    required SecureStorageService secureStorage,
  })  : _storeDao = storeDao,
        _secureStorage = secureStorage;

  @observable
  ObservableList<StoreData> storeList = ObservableList<StoreData>();

  @observable
  StoreData? activeStore;

  @observable
  int? defaultStoreId;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get hasActiveStore => activeStore != null;

  @computed
  int get storeCount => storeList.length;

  @computed
  int? get activeStoreId => activeStore?.id;

  @action
  Future<void> loadStores() async {
    isLoading = true;
    errorMessage = null;
    try {
      final stores = await _storeDao.getAllStores();
      storeList = ObservableList.of(stores);

      defaultStoreId = await _secureStorage.getDefaultStoreId();
      final activeId = await _secureStorage.getActiveStoreId();

      if (activeId != null) {
        activeStore = stores.where((s) => s.id == activeId).firstOrNull;
      } else if (defaultStoreId != null) {
        activeStore = stores.where((s) => s.id == defaultStoreId).firstOrNull;
      }
    } catch (e) {
      errorMessage = 'Gagal memuat daftar toko: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> verifyStorePin({
    required int storeId,
    required String pin,
    bool rememberThisStore = false,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final store = await _storeDao.getStoreById(storeId);
      if (store == null) {
        errorMessage = 'Toko tidak ditemukan';
        return false;
      }

      final isMatch = PasswordHasher.verifyPin(pin, store.pinHash, store.pinSalt);
      if (!isMatch) {
        errorMessage = 'PIN yang Anda masukkan salah';
        return false;
      }

      activeStore = store;
      await _secureStorage.setActiveStoreId(store.id);

      if (rememberThisStore) {
        defaultStoreId = store.id;
        await _secureStorage.setDefaultStoreId(store.id);
      } else {
        defaultStoreId = null;
        await _secureStorage.setDefaultStoreId(null);
      }

      return true;
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> verifySecurityAnswer({
    required int storeId,
    required String answer,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final store = await _storeDao.getStoreById(storeId);
      if (store == null) {
        errorMessage = 'Toko tidak ditemukan';
        return false;
      }

      final isMatch = PasswordHasher.verifySecurityAnswer(
        answer,
        store.securityAnswerHash,
        store.securityAnswerSalt,
      );

      if (!isMatch) {
        errorMessage = 'Jawaban keamanan tidak cocok';
        return false;
      }

      return true;
    } catch (e) {
      errorMessage = 'Gagal memverifikasi jawaban: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> resetStorePin({
    required int storeId,
    required String newPin,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final salt = PasswordHasher.generateSalt();
      final pinHash = PasswordHasher.hashPin(newPin, salt);

      await _storeDao.updateStorePin(
        storeId: storeId,
        pinHash: pinHash,
        pinSalt: salt,
      );

      // Refresh store data
      final updatedStore = await _storeDao.getStoreById(storeId);
      if (updatedStore != null) {
        final index = storeList.indexWhere((s) => s.id == storeId);
        if (index != -1) {
          storeList[index] = updatedStore;
        }
        if (activeStore?.id == storeId) {
          activeStore = updatedStore;
        }
      }

      return true;
    } catch (e) {
      errorMessage = 'Gagal menyetel ulang PIN: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<StoreData?> createStore({
    required String storeName,
    required String ownerName,
    required String phone,
    required String address,
    required String pin,
    required String securityQuestion,
    required String securityAnswer,
    String? logoPath,
    String? headerMessage,
    String? footerMessage,
    bool setAsDefault = true,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final pinSalt = PasswordHasher.generateSalt();
      final pinHash = PasswordHasher.hashPin(pin, pinSalt);

      final answerSalt = PasswordHasher.generateSalt();
      final answerHash = PasswordHasher.hashSecurityAnswer(securityAnswer, answerSalt);

      final newStoreId = await _storeDao.insertStore(
        StoresCompanion(
          storeName: Value(storeName),
          ownerName: Value(ownerName),
          phone: Value(phone),
          address: Value(address),
          pinHash: Value(pinHash),
          pinSalt: Value(pinSalt),
          securityQuestion: Value(securityQuestion),
          securityAnswerHash: Value(answerHash),
          securityAnswerSalt: Value(answerSalt),
          logoPath: Value(logoPath),
          headerMessage: headerMessage != null ? Value(headerMessage) : const Value.absent(),
          footerMessage: footerMessage != null ? Value(footerMessage) : const Value.absent(),
        ),
      );

      final createdStore = await _storeDao.getStoreById(newStoreId);
      if (createdStore != null) {
        storeList.add(createdStore);
        activeStore = createdStore;
        await _secureStorage.setActiveStoreId(newStoreId);

        if (setAsDefault) {
          defaultStoreId = newStoreId;
          await _secureStorage.setDefaultStoreId(newStoreId);
        }
      }

      return createdStore;
    } catch (e) {
      errorMessage = 'Gagal membuat toko baru: ${e.toString()}';
      return null;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> switchStore() async {
    activeStore = null;
    await _secureStorage.setActiveStoreId(null);
  }

  @action
  Future<void> clearRememberedStore() async {
    defaultStoreId = null;
    await _secureStorage.setDefaultStoreId(null);
  }

  @action
  Future<void> setActiveStore(StoreData store) async {
    activeStore = store;
    await _secureStorage.setActiveStoreId(store.id);
  }
}
