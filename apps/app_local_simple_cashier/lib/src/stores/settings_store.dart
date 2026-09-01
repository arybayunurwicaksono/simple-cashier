// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:database/database.dart';
import 'package:thermal_printer/thermal_printer.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  final StoreProfileDao _storeProfileDao;
  final UserDao _userDao;
  final ThermalPrinterService _thermalPrinter;

  _SettingsStore({
    required StoreProfileDao storeProfileDao,
    required UserDao userDao,
    required ThermalPrinterService thermalPrinter,
  })  : _storeProfileDao = storeProfileDao,
        _userDao = userDao,
        _thermalPrinter = thermalPrinter;

  static const String _keyThemeMode = 'app_theme_mode';
  static const String _keyLanguageCode = 'app_language_code';
  static const String _keySoundEnabled = 'app_sound_enabled';
  static const String _keyAutoPrintEnabled = 'app_auto_print_enabled';

  @observable
  ThemeMode themeMode = ThemeMode.system;

  @observable
  Locale currentLocale = const Locale('id', 'ID');

  @observable
  bool isSoundEnabled = true;

  @observable
  bool isAutoPrintEnabled = false;

  @observable
  StoreProfileData? storeProfile;

  @observable
  ObservableList<UserData> staffList = ObservableList<UserData>();

  @observable
  ObservableList<PrinterDevice> availablePrinters = ObservableList<PrinterDevice>();

  @observable
  PrinterDevice? connectedPrinter;

  @observable
  bool isScanningPrinters = false;

  @observable
  bool isConnectingPrinter = false;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadSettings() async {
    isLoading = true;
    try {
      await loadPreferences();
      storeProfile = await _storeProfileDao.getStoreProfile();
      final users = await _userDao.getAllUsers();
      staffList = ObservableList.of(users);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Theme Mode
      final themeStr = prefs.getString(_keyThemeMode) ?? 'system';
      if (themeStr == 'light') {
        themeMode = ThemeMode.light;
      } else if (themeStr == 'dark') {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.system;
      }

      // Language Code
      final langCode = prefs.getString(_keyLanguageCode) ?? 'id';
      if (langCode == 'en') {
        currentLocale = const Locale('en', 'US');
      } else {
        currentLocale = const Locale('id', 'ID');
      }

      // Preferences
      isSoundEnabled = prefs.getBool(_keySoundEnabled) ?? true;
      isAutoPrintEnabled = prefs.getBool(_keyAutoPrintEnabled) ?? false;
    } catch (_) {}
  }

  @action
  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    String modeStr = 'system';
    if (mode == ThemeMode.light) modeStr = 'light';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    await prefs.setString(_keyThemeMode, modeStr);
  }

  @action
  Future<void> setLanguage(String languageCode) async {
    if (languageCode == 'en') {
      currentLocale = const Locale('en', 'US');
    } else {
      currentLocale = const Locale('id', 'ID');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguageCode, languageCode);
  }

  @action
  Future<void> toggleSound(bool enabled) async {
    isSoundEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySoundEnabled, enabled);
  }

  @action
  Future<void> toggleAutoPrint(bool enabled) async {
    isAutoPrintEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoPrintEnabled, enabled);
  }

  @action
  Future<bool> updateStoreProfile({
    required String storeName,
    required String phone,
    required String address,
    required String headerMessage,
    required String footerMessage,
  }) async {
    isLoading = true;
    try {
      await _storeProfileDao.setStoreProfile(
        StoreProfilesCompanion(
          storeName: Value(storeName),
          phone: Value(phone),
          address: Value(address),
          headerMessage: Value(headerMessage),
          footerMessage: Value(footerMessage),
          updatedAt: Value(DateTime.now()),
        ),
      );
      storeProfile = await _storeProfileDao.getStoreProfile();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> scanPrinters() async {
    isScanningPrinters = true;
    errorMessage = null;
    try {
      final granted = await _thermalPrinter.requestPermissions();
      if (!granted) {
        errorMessage = 'Izin Bluetooth belum diberikan';
        return;
      }

      final devices = await _thermalPrinter.getBondedDevices();
      availablePrinters = ObservableList.of(devices);
    } catch (e) {
      errorMessage = 'Gagal memindai printer: ${e.toString()}';
    } finally {
      isScanningPrinters = false;
    }
  }

  @action
  Future<bool> connectPrinter(PrinterDevice printer) async {
    isConnectingPrinter = true;
    errorMessage = null;
    try {
      final success = await _thermalPrinter.connect(printer);
      if (success) {
        connectedPrinter = printer;
        return true;
      } else {
        errorMessage = 'Gagal terhubung ke ${printer.name}';
        return false;
      }
    } catch (e) {
      errorMessage = 'Koneksi printer gagal: ${e.toString()}';
      return false;
    } finally {
      isConnectingPrinter = false;
    }
  }

  @action
  Future<void> disconnectPrinter() async {
    await _thermalPrinter.disconnect();
    connectedPrinter = null;
  }
}
