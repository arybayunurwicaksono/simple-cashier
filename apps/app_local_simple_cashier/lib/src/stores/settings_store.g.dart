// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  late final _$themeModeAtom =
      Atom(name: '_SettingsStore.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$currentLocaleAtom =
      Atom(name: '_SettingsStore.currentLocale', context: context);

  @override
  Locale get currentLocale {
    _$currentLocaleAtom.reportRead();
    return super.currentLocale;
  }

  @override
  set currentLocale(Locale value) {
    _$currentLocaleAtom.reportWrite(value, super.currentLocale, () {
      super.currentLocale = value;
    });
  }

  late final _$isSoundEnabledAtom =
      Atom(name: '_SettingsStore.isSoundEnabled', context: context);

  @override
  bool get isSoundEnabled {
    _$isSoundEnabledAtom.reportRead();
    return super.isSoundEnabled;
  }

  @override
  set isSoundEnabled(bool value) {
    _$isSoundEnabledAtom.reportWrite(value, super.isSoundEnabled, () {
      super.isSoundEnabled = value;
    });
  }

  late final _$isAutoPrintEnabledAtom =
      Atom(name: '_SettingsStore.isAutoPrintEnabled', context: context);

  @override
  bool get isAutoPrintEnabled {
    _$isAutoPrintEnabledAtom.reportRead();
    return super.isAutoPrintEnabled;
  }

  @override
  set isAutoPrintEnabled(bool value) {
    _$isAutoPrintEnabledAtom.reportWrite(value, super.isAutoPrintEnabled, () {
      super.isAutoPrintEnabled = value;
    });
  }

  late final _$storeProfileAtom =
      Atom(name: '_SettingsStore.storeProfile', context: context);

  @override
  StoreProfileData? get storeProfile {
    _$storeProfileAtom.reportRead();
    return super.storeProfile;
  }

  @override
  set storeProfile(StoreProfileData? value) {
    _$storeProfileAtom.reportWrite(value, super.storeProfile, () {
      super.storeProfile = value;
    });
  }

  late final _$staffListAtom =
      Atom(name: '_SettingsStore.staffList', context: context);

  @override
  ObservableList<UserData> get staffList {
    _$staffListAtom.reportRead();
    return super.staffList;
  }

  @override
  set staffList(ObservableList<UserData> value) {
    _$staffListAtom.reportWrite(value, super.staffList, () {
      super.staffList = value;
    });
  }

  late final _$availablePrintersAtom =
      Atom(name: '_SettingsStore.availablePrinters', context: context);

  @override
  ObservableList<PrinterDevice> get availablePrinters {
    _$availablePrintersAtom.reportRead();
    return super.availablePrinters;
  }

  @override
  set availablePrinters(ObservableList<PrinterDevice> value) {
    _$availablePrintersAtom.reportWrite(value, super.availablePrinters, () {
      super.availablePrinters = value;
    });
  }

  late final _$connectedPrinterAtom =
      Atom(name: '_SettingsStore.connectedPrinter', context: context);

  @override
  PrinterDevice? get connectedPrinter {
    _$connectedPrinterAtom.reportRead();
    return super.connectedPrinter;
  }

  @override
  set connectedPrinter(PrinterDevice? value) {
    _$connectedPrinterAtom.reportWrite(value, super.connectedPrinter, () {
      super.connectedPrinter = value;
    });
  }

  late final _$isScanningPrintersAtom =
      Atom(name: '_SettingsStore.isScanningPrinters', context: context);

  @override
  bool get isScanningPrinters {
    _$isScanningPrintersAtom.reportRead();
    return super.isScanningPrinters;
  }

  @override
  set isScanningPrinters(bool value) {
    _$isScanningPrintersAtom.reportWrite(value, super.isScanningPrinters, () {
      super.isScanningPrinters = value;
    });
  }

  late final _$isConnectingPrinterAtom =
      Atom(name: '_SettingsStore.isConnectingPrinter', context: context);

  @override
  bool get isConnectingPrinter {
    _$isConnectingPrinterAtom.reportRead();
    return super.isConnectingPrinter;
  }

  @override
  set isConnectingPrinter(bool value) {
    _$isConnectingPrinterAtom.reportWrite(value, super.isConnectingPrinter, () {
      super.isConnectingPrinter = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SettingsStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_SettingsStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadSettingsAsyncAction =
      AsyncAction('_SettingsStore.loadSettings', context: context);

  @override
  Future<void> loadSettings() {
    return _$loadSettingsAsyncAction.run(() => super.loadSettings());
  }

  late final _$loadPreferencesAsyncAction =
      AsyncAction('_SettingsStore.loadPreferences', context: context);

  @override
  Future<void> loadPreferences() {
    return _$loadPreferencesAsyncAction.run(() => super.loadPreferences());
  }

  late final _$setThemeModeAsyncAction =
      AsyncAction('_SettingsStore.setThemeMode', context: context);

  @override
  Future<void> setThemeMode(ThemeMode mode) {
    return _$setThemeModeAsyncAction.run(() => super.setThemeMode(mode));
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('_SettingsStore.setLanguage', context: context);

  @override
  Future<void> setLanguage(String languageCode) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(languageCode));
  }

  late final _$toggleSoundAsyncAction =
      AsyncAction('_SettingsStore.toggleSound', context: context);

  @override
  Future<void> toggleSound(bool enabled) {
    return _$toggleSoundAsyncAction.run(() => super.toggleSound(enabled));
  }

  late final _$toggleAutoPrintAsyncAction =
      AsyncAction('_SettingsStore.toggleAutoPrint', context: context);

  @override
  Future<void> toggleAutoPrint(bool enabled) {
    return _$toggleAutoPrintAsyncAction
        .run(() => super.toggleAutoPrint(enabled));
  }

  late final _$updateStoreProfileAsyncAction =
      AsyncAction('_SettingsStore.updateStoreProfile', context: context);

  @override
  Future<bool> updateStoreProfile(
      {required String storeName,
      required String phone,
      required String address,
      required String headerMessage,
      required String footerMessage}) {
    return _$updateStoreProfileAsyncAction.run(() => super.updateStoreProfile(
        storeName: storeName,
        phone: phone,
        address: address,
        headerMessage: headerMessage,
        footerMessage: footerMessage));
  }

  late final _$scanPrintersAsyncAction =
      AsyncAction('_SettingsStore.scanPrinters', context: context);

  @override
  Future<void> scanPrinters() {
    return _$scanPrintersAsyncAction.run(() => super.scanPrinters());
  }

  late final _$connectPrinterAsyncAction =
      AsyncAction('_SettingsStore.connectPrinter', context: context);

  @override
  Future<bool> connectPrinter(PrinterDevice printer) {
    return _$connectPrinterAsyncAction.run(() => super.connectPrinter(printer));
  }

  late final _$disconnectPrinterAsyncAction =
      AsyncAction('_SettingsStore.disconnectPrinter', context: context);

  @override
  Future<void> disconnectPrinter() {
    return _$disconnectPrinterAsyncAction.run(() => super.disconnectPrinter());
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
currentLocale: ${currentLocale},
isSoundEnabled: ${isSoundEnabled},
isAutoPrintEnabled: ${isAutoPrintEnabled},
storeProfile: ${storeProfile},
staffList: ${staffList},
availablePrinters: ${availablePrinters},
connectedPrinter: ${connectedPrinter},
isScanningPrinters: ${isScanningPrinters},
isConnectingPrinter: ${isConnectingPrinter},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
