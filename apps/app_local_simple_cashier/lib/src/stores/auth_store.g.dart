// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated =>
      (_$isAuthenticatedComputed ??= Computed<bool>(() => super.isAuthenticated,
              name: '_AuthStore.isAuthenticated'))
          .value;
  Computed<bool>? _$isOwnerComputed;

  @override
  bool get isOwner => (_$isOwnerComputed ??=
          Computed<bool>(() => super.isOwner, name: '_AuthStore.isOwner'))
      .value;

  late final _$currentUserAtom =
      Atom(name: '_AuthStore.currentUser', context: context);

  @override
  UserData? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserData? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AuthStore.isLoading', context: context);

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
      Atom(name: '_AuthStore.errorMessage', context: context);

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

  late final _$isInitializedAtom =
      Atom(name: '_AuthStore.isInitialized', context: context);

  @override
  bool get isInitialized {
    _$isInitializedAtom.reportRead();
    return super.isInitialized;
  }

  @override
  set isInitialized(bool value) {
    _$isInitializedAtom.reportWrite(value, super.isInitialized, () {
      super.isInitialized = value;
    });
  }

  late final _$initAuthAsyncAction =
      AsyncAction('_AuthStore.initAuth', context: context);

  @override
  Future<void> initAuth() {
    return _$initAuthAsyncAction.run(() => super.initAuth());
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<bool> login(String usernameOrEmail, String password) {
    return _$loginAsyncAction.run(() => super.login(usernameOrEmail, password));
  }

  late final _$registerAsyncAction =
      AsyncAction('_AuthStore.register', context: context);

  @override
  Future<bool> register(
      {required String username,
      required String email,
      required String password,
      required String fullname,
      required String role}) {
    return _$registerAsyncAction.run(() => super.register(
        username: username,
        email: email,
        password: password,
        fullname: fullname,
        role: role));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$hasAnyUsersAsyncAction =
      AsyncAction('_AuthStore.hasAnyUsers', context: context);

  @override
  Future<bool> hasAnyUsers() {
    return _$hasAnyUsersAsyncAction.run(() => super.hasAnyUsers());
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
isInitialized: ${isInitialized},
isAuthenticated: ${isAuthenticated},
isOwner: ${isOwner}
    ''';
  }
}
