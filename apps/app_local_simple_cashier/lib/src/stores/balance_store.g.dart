// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BalanceStore on _BalanceStore, Store {
  Computed<int>? _$totalBalanceComputed;

  @override
  int get totalBalance =>
      (_$totalBalanceComputed ??= Computed<int>(() => super.totalBalance,
              name: '_BalanceStore.totalBalance'))
          .value;

  late final _$balanceLogsAtom =
      Atom(name: '_BalanceStore.balanceLogs', context: context);

  @override
  ObservableList<BalanceLogData> get balanceLogs {
    _$balanceLogsAtom.reportRead();
    return super.balanceLogs;
  }

  @override
  set balanceLogs(ObservableList<BalanceLogData> value) {
    _$balanceLogsAtom.reportWrite(value, super.balanceLogs, () {
      super.balanceLogs = value;
    });
  }

  late final _$cashBalanceAtom =
      Atom(name: '_BalanceStore.cashBalance', context: context);

  @override
  int get cashBalance {
    _$cashBalanceAtom.reportRead();
    return super.cashBalance;
  }

  @override
  set cashBalance(int value) {
    _$cashBalanceAtom.reportWrite(value, super.cashBalance, () {
      super.cashBalance = value;
    });
  }

  late final _$digitalBalanceAtom =
      Atom(name: '_BalanceStore.digitalBalance', context: context);

  @override
  int get digitalBalance {
    _$digitalBalanceAtom.reportRead();
    return super.digitalBalance;
  }

  @override
  set digitalBalance(int value) {
    _$digitalBalanceAtom.reportWrite(value, super.digitalBalance, () {
      super.digitalBalance = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_BalanceStore.isLoading', context: context);

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
      Atom(name: '_BalanceStore.errorMessage', context: context);

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

  late final _$loadBalancesAsyncAction =
      AsyncAction('_BalanceStore.loadBalances', context: context);

  @override
  Future<void> loadBalances() {
    return _$loadBalancesAsyncAction.run(() => super.loadBalances());
  }

  late final _$addBalanceLogAsyncAction =
      AsyncAction('_BalanceStore.addBalanceLog', context: context);

  @override
  Future<bool> addBalanceLog(
      {required int amount,
      required String flowType,
      required String category,
      required String paymentType,
      required int userId,
      String? notes}) {
    return _$addBalanceLogAsyncAction.run(() => super.addBalanceLog(
        amount: amount,
        flowType: flowType,
        category: category,
        paymentType: paymentType,
        userId: userId,
        notes: notes));
  }

  @override
  String toString() {
    return '''
balanceLogs: ${balanceLogs},
cashBalance: ${cashBalance},
digitalBalance: ${digitalBalance},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
totalBalance: ${totalBalance}
    ''';
  }
}
