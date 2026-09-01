// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountingStore on _AccountingStore, Store {
  Computed<int>? _$currentTotalIncomeComputed;

  @override
  int get currentTotalIncome => (_$currentTotalIncomeComputed ??= Computed<int>(
          () => super.currentTotalIncome,
          name: '_AccountingStore.currentTotalIncome'))
      .value;
  Computed<int>? _$todayTotalBalanceComputed;

  @override
  int get todayTotalBalance => (_$todayTotalBalanceComputed ??= Computed<int>(
          () => super.todayTotalBalance,
          name: '_AccountingStore.todayTotalBalance'))
      .value;

  late final _$monthlyLedgersAtom =
      Atom(name: '_AccountingStore.monthlyLedgers', context: context);

  @override
  ObservableList<MonthlyAccountingData> get monthlyLedgers {
    _$monthlyLedgersAtom.reportRead();
    return super.monthlyLedgers;
  }

  @override
  set monthlyLedgers(ObservableList<MonthlyAccountingData> value) {
    _$monthlyLedgersAtom.reportWrite(value, super.monthlyLedgers, () {
      super.monthlyLedgers = value;
    });
  }

  late final _$currentPeriodLedgerAtom =
      Atom(name: '_AccountingStore.currentPeriodLedger', context: context);

  @override
  MonthlyAccountingData? get currentPeriodLedger {
    _$currentPeriodLedgerAtom.reportRead();
    return super.currentPeriodLedger;
  }

  @override
  set currentPeriodLedger(MonthlyAccountingData? value) {
    _$currentPeriodLedgerAtom.reportWrite(value, super.currentPeriodLedger, () {
      super.currentPeriodLedger = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AccountingStore.isLoading', context: context);

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
      Atom(name: '_AccountingStore.errorMessage', context: context);

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

  late final _$currentIncomeGoodsAtom =
      Atom(name: '_AccountingStore.currentIncomeGoods', context: context);

  @override
  int get currentIncomeGoods {
    _$currentIncomeGoodsAtom.reportRead();
    return super.currentIncomeGoods;
  }

  @override
  set currentIncomeGoods(int value) {
    _$currentIncomeGoodsAtom.reportWrite(value, super.currentIncomeGoods, () {
      super.currentIncomeGoods = value;
    });
  }

  late final _$currentIncomeServicesAtom =
      Atom(name: '_AccountingStore.currentIncomeServices', context: context);

  @override
  int get currentIncomeServices {
    _$currentIncomeServicesAtom.reportRead();
    return super.currentIncomeServices;
  }

  @override
  set currentIncomeServices(int value) {
    _$currentIncomeServicesAtom.reportWrite(value, super.currentIncomeServices,
        () {
      super.currentIncomeServices = value;
    });
  }

  late final _$currentTotalExpenseAtom =
      Atom(name: '_AccountingStore.currentTotalExpense', context: context);

  @override
  int get currentTotalExpense {
    _$currentTotalExpenseAtom.reportRead();
    return super.currentTotalExpense;
  }

  @override
  set currentTotalExpense(int value) {
    _$currentTotalExpenseAtom.reportWrite(value, super.currentTotalExpense, () {
      super.currentTotalExpense = value;
    });
  }

  late final _$currentNetProfitAtom =
      Atom(name: '_AccountingStore.currentNetProfit', context: context);

  @override
  int get currentNetProfit {
    _$currentNetProfitAtom.reportRead();
    return super.currentNetProfit;
  }

  @override
  set currentNetProfit(int value) {
    _$currentNetProfitAtom.reportWrite(value, super.currentNetProfit, () {
      super.currentNetProfit = value;
    });
  }

  late final _$currentCashAtom =
      Atom(name: '_AccountingStore.currentCash', context: context);

  @override
  int get currentCash {
    _$currentCashAtom.reportRead();
    return super.currentCash;
  }

  @override
  set currentCash(int value) {
    _$currentCashAtom.reportWrite(value, super.currentCash, () {
      super.currentCash = value;
    });
  }

  late final _$currentDigitalAtom =
      Atom(name: '_AccountingStore.currentDigital', context: context);

  @override
  int get currentDigital {
    _$currentDigitalAtom.reportRead();
    return super.currentDigital;
  }

  @override
  set currentDigital(int value) {
    _$currentDigitalAtom.reportWrite(value, super.currentDigital, () {
      super.currentDigital = value;
    });
  }

  late final _$currentStockValueAtom =
      Atom(name: '_AccountingStore.currentStockValue', context: context);

  @override
  int get currentStockValue {
    _$currentStockValueAtom.reportRead();
    return super.currentStockValue;
  }

  @override
  set currentStockValue(int value) {
    _$currentStockValueAtom.reportWrite(value, super.currentStockValue, () {
      super.currentStockValue = value;
    });
  }

  late final _$todayTotalIncomeAtom =
      Atom(name: '_AccountingStore.todayTotalIncome', context: context);

  @override
  int get todayTotalIncome {
    _$todayTotalIncomeAtom.reportRead();
    return super.todayTotalIncome;
  }

  @override
  set todayTotalIncome(int value) {
    _$todayTotalIncomeAtom.reportWrite(value, super.todayTotalIncome, () {
      super.todayTotalIncome = value;
    });
  }

  late final _$todayNetProfitAtom =
      Atom(name: '_AccountingStore.todayNetProfit', context: context);

  @override
  int get todayNetProfit {
    _$todayNetProfitAtom.reportRead();
    return super.todayNetProfit;
  }

  @override
  set todayNetProfit(int value) {
    _$todayNetProfitAtom.reportWrite(value, super.todayNetProfit, () {
      super.todayNetProfit = value;
    });
  }

  late final _$todayTotalExpenseAtom =
      Atom(name: '_AccountingStore.todayTotalExpense', context: context);

  @override
  int get todayTotalExpense {
    _$todayTotalExpenseAtom.reportRead();
    return super.todayTotalExpense;
  }

  @override
  set todayTotalExpense(int value) {
    _$todayTotalExpenseAtom.reportWrite(value, super.todayTotalExpense, () {
      super.todayTotalExpense = value;
    });
  }

  late final _$todayCashBalanceAtom =
      Atom(name: '_AccountingStore.todayCashBalance', context: context);

  @override
  int get todayCashBalance {
    _$todayCashBalanceAtom.reportRead();
    return super.todayCashBalance;
  }

  @override
  set todayCashBalance(int value) {
    _$todayCashBalanceAtom.reportWrite(value, super.todayCashBalance, () {
      super.todayCashBalance = value;
    });
  }

  late final _$todayDigitalBalanceAtom =
      Atom(name: '_AccountingStore.todayDigitalBalance', context: context);

  @override
  int get todayDigitalBalance {
    _$todayDigitalBalanceAtom.reportRead();
    return super.todayDigitalBalance;
  }

  @override
  set todayDigitalBalance(int value) {
    _$todayDigitalBalanceAtom.reportWrite(value, super.todayDigitalBalance, () {
      super.todayDigitalBalance = value;
    });
  }

  late final _$todayTransactionCountAtom =
      Atom(name: '_AccountingStore.todayTransactionCount', context: context);

  @override
  int get todayTransactionCount {
    _$todayTransactionCountAtom.reportRead();
    return super.todayTransactionCount;
  }

  @override
  set todayTransactionCount(int value) {
    _$todayTransactionCountAtom.reportWrite(value, super.todayTransactionCount,
        () {
      super.todayTransactionCount = value;
    });
  }

  late final _$todaySoldItemsCountAtom =
      Atom(name: '_AccountingStore.todaySoldItemsCount', context: context);

  @override
  int get todaySoldItemsCount {
    _$todaySoldItemsCountAtom.reportRead();
    return super.todaySoldItemsCount;
  }

  @override
  set todaySoldItemsCount(int value) {
    _$todaySoldItemsCountAtom.reportWrite(value, super.todaySoldItemsCount, () {
      super.todaySoldItemsCount = value;
    });
  }

  late final _$recentTransactionsAtom =
      Atom(name: '_AccountingStore.recentTransactions', context: context);

  @override
  ObservableList<TransactionData> get recentTransactions {
    _$recentTransactionsAtom.reportRead();
    return super.recentTransactions;
  }

  @override
  set recentTransactions(ObservableList<TransactionData> value) {
    _$recentTransactionsAtom.reportWrite(value, super.recentTransactions, () {
      super.recentTransactions = value;
    });
  }

  late final _$loadTodayDashboardMetricsAsyncAction = AsyncAction(
      '_AccountingStore.loadTodayDashboardMetrics',
      context: context);

  @override
  Future<void> loadTodayDashboardMetrics() {
    return _$loadTodayDashboardMetricsAsyncAction
        .run(() => super.loadTodayDashboardMetrics());
  }

  late final _$loadLedgersAsyncAction =
      AsyncAction('_AccountingStore.loadLedgers', context: context);

  @override
  Future<void> loadLedgers() {
    return _$loadLedgersAsyncAction.run(() => super.loadLedgers());
  }

  late final _$calculateCurrentMonthLivePreviewAsyncAction = AsyncAction(
      '_AccountingStore.calculateCurrentMonthLivePreview',
      context: context);

  @override
  Future<void> calculateCurrentMonthLivePreview() {
    return _$calculateCurrentMonthLivePreviewAsyncAction
        .run(() => super.calculateCurrentMonthLivePreview());
  }

  late final _$closeMonthlyLedgerAsyncAction =
      AsyncAction('_AccountingStore.closeMonthlyLedger', context: context);

  @override
  Future<bool> closeMonthlyLedger(
      {required String period,
      required int initialCash,
      required int initialDigital,
      required int initialStockValue,
      required int closedByUserId}) {
    return _$closeMonthlyLedgerAsyncAction.run(() => super.closeMonthlyLedger(
        period: period,
        initialCash: initialCash,
        initialDigital: initialDigital,
        initialStockValue: initialStockValue,
        closedByUserId: closedByUserId));
  }

  late final _$exportAndShareMonthlyReportPdfAsyncAction = AsyncAction(
      '_AccountingStore.exportAndShareMonthlyReportPdf',
      context: context);

  @override
  Future<void> exportAndShareMonthlyReportPdf(
      {required MonthlyAccountingData ledger, required String generatedBy}) {
    return _$exportAndShareMonthlyReportPdfAsyncAction.run(() => super
        .exportAndShareMonthlyReportPdf(
            ledger: ledger, generatedBy: generatedBy));
  }

  @override
  String toString() {
    return '''
monthlyLedgers: ${monthlyLedgers},
currentPeriodLedger: ${currentPeriodLedger},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
currentIncomeGoods: ${currentIncomeGoods},
currentIncomeServices: ${currentIncomeServices},
currentTotalExpense: ${currentTotalExpense},
currentNetProfit: ${currentNetProfit},
currentCash: ${currentCash},
currentDigital: ${currentDigital},
currentStockValue: ${currentStockValue},
todayTotalIncome: ${todayTotalIncome},
todayNetProfit: ${todayNetProfit},
todayTotalExpense: ${todayTotalExpense},
todayCashBalance: ${todayCashBalance},
todayDigitalBalance: ${todayDigitalBalance},
todayTransactionCount: ${todayTransactionCount},
todaySoldItemsCount: ${todaySoldItemsCount},
recentTransactions: ${recentTransactions},
currentTotalIncome: ${currentTotalIncome},
todayTotalBalance: ${todayTotalBalance}
    ''';
  }
}
