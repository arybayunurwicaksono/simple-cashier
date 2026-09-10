// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreStore on _StoreStore, Store {
  Computed<bool>? _$hasActiveStoreComputed;

  @override
  bool get hasActiveStore =>
      (_$hasActiveStoreComputed ??= Computed<bool>(() => super.hasActiveStore,
              name: '_StoreStore.hasActiveStore'))
          .value;
  Computed<int>? _$storeCountComputed;

  @override
  int get storeCount => (_$storeCountComputed ??=
          Computed<int>(() => super.storeCount, name: '_StoreStore.storeCount'))
      .value;
  Computed<int?>? _$activeStoreIdComputed;

  @override
  int? get activeStoreId =>
      (_$activeStoreIdComputed ??= Computed<int?>(() => super.activeStoreId,
              name: '_StoreStore.activeStoreId'))
          .value;

  late final _$storeListAtom =
      Atom(name: '_StoreStore.storeList', context: context);

  @override
  ObservableList<StoreData> get storeList {
    _$storeListAtom.reportRead();
    return super.storeList;
  }

  @override
  set storeList(ObservableList<StoreData> value) {
    _$storeListAtom.reportWrite(value, super.storeList, () {
      super.storeList = value;
    });
  }

  late final _$activeStoreAtom =
      Atom(name: '_StoreStore.activeStore', context: context);

  @override
  StoreData? get activeStore {
    _$activeStoreAtom.reportRead();
    return super.activeStore;
  }

  @override
  set activeStore(StoreData? value) {
    _$activeStoreAtom.reportWrite(value, super.activeStore, () {
      super.activeStore = value;
    });
  }

  late final _$defaultStoreIdAtom =
      Atom(name: '_StoreStore.defaultStoreId', context: context);

  @override
  int? get defaultStoreId {
    _$defaultStoreIdAtom.reportRead();
    return super.defaultStoreId;
  }

  @override
  set defaultStoreId(int? value) {
    _$defaultStoreIdAtom.reportWrite(value, super.defaultStoreId, () {
      super.defaultStoreId = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_StoreStore.isLoading', context: context);

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
      Atom(name: '_StoreStore.errorMessage', context: context);

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

  late final _$loadStoresAsyncAction =
      AsyncAction('_StoreStore.loadStores', context: context);

  @override
  Future<void> loadStores() {
    return _$loadStoresAsyncAction.run(() => super.loadStores());
  }

  late final _$verifyStorePinAsyncAction =
      AsyncAction('_StoreStore.verifyStorePin', context: context);

  @override
  Future<bool> verifyStorePin(
      {required int storeId,
      required String pin,
      bool rememberThisStore = false}) {
    return _$verifyStorePinAsyncAction.run(() => super.verifyStorePin(
        storeId: storeId, pin: pin, rememberThisStore: rememberThisStore));
  }

  late final _$verifySecurityAnswerAsyncAction =
      AsyncAction('_StoreStore.verifySecurityAnswer', context: context);

  @override
  Future<bool> verifySecurityAnswer(
      {required int storeId, required String answer}) {
    return _$verifySecurityAnswerAsyncAction.run(
        () => super.verifySecurityAnswer(storeId: storeId, answer: answer));
  }

  late final _$resetStorePinAsyncAction =
      AsyncAction('_StoreStore.resetStorePin', context: context);

  @override
  Future<bool> resetStorePin({required int storeId, required String newPin}) {
    return _$resetStorePinAsyncAction
        .run(() => super.resetStorePin(storeId: storeId, newPin: newPin));
  }

  late final _$createStoreAsyncAction =
      AsyncAction('_StoreStore.createStore', context: context);

  @override
  Future<StoreData?> createStore(
      {required String storeName,
      required String ownerName,
      required String phone,
      required String address,
      required String pin,
      required String securityQuestion,
      required String securityAnswer,
      String? logoPath,
      String? headerMessage,
      String? footerMessage,
      bool setAsDefault = true}) {
    return _$createStoreAsyncAction.run(() => super.createStore(
        storeName: storeName,
        ownerName: ownerName,
        phone: phone,
        address: address,
        pin: pin,
        securityQuestion: securityQuestion,
        securityAnswer: securityAnswer,
        logoPath: logoPath,
        headerMessage: headerMessage,
        footerMessage: footerMessage,
        setAsDefault: setAsDefault));
  }

  late final _$switchStoreAsyncAction =
      AsyncAction('_StoreStore.switchStore', context: context);

  @override
  Future<void> switchStore() {
    return _$switchStoreAsyncAction.run(() => super.switchStore());
  }

  late final _$clearRememberedStoreAsyncAction =
      AsyncAction('_StoreStore.clearRememberedStore', context: context);

  @override
  Future<void> clearRememberedStore() {
    return _$clearRememberedStoreAsyncAction
        .run(() => super.clearRememberedStore());
  }

  late final _$setActiveStoreAsyncAction =
      AsyncAction('_StoreStore.setActiveStore', context: context);

  @override
  Future<void> setActiveStore(StoreData store) {
    return _$setActiveStoreAsyncAction.run(() => super.setActiveStore(store));
  }

  @override
  String toString() {
    return '''
storeList: ${storeList},
activeStore: ${activeStore},
defaultStoreId: ${defaultStoreId},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
hasActiveStore: ${hasActiveStore},
storeCount: ${storeCount},
activeStoreId: ${activeStoreId}
    ''';
  }
}
