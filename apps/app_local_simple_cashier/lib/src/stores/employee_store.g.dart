// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmployeeStore on _EmployeeStore, Store {
  Computed<List<UserData>>? _$filteredEmployeesComputed;

  @override
  List<UserData> get filteredEmployees => (_$filteredEmployeesComputed ??=
          Computed<List<UserData>>(() => super.filteredEmployees,
              name: '_EmployeeStore.filteredEmployees'))
      .value;
  Computed<List<TransactionData>>? _$filteredTransactionsComputed;

  @override
  List<TransactionData> get filteredTransactions =>
      (_$filteredTransactionsComputed ??= Computed<List<TransactionData>>(
              () => super.filteredTransactions,
              name: '_EmployeeStore.filteredTransactions'))
          .value;
  Computed<List<RestockWithProduct>>? _$filteredRestocksComputed;

  @override
  List<RestockWithProduct> get filteredRestocks =>
      (_$filteredRestocksComputed ??= Computed<List<RestockWithProduct>>(
              () => super.filteredRestocks,
              name: '_EmployeeStore.filteredRestocks'))
          .value;
  Computed<List<BalanceLogData>>? _$filteredBalanceLogsComputed;

  @override
  List<BalanceLogData> get filteredBalanceLogs =>
      (_$filteredBalanceLogsComputed ??= Computed<List<BalanceLogData>>(
              () => super.filteredBalanceLogs,
              name: '_EmployeeStore.filteredBalanceLogs'))
          .value;
  Computed<List<ReturnData>>? _$filteredReturnsComputed;

  @override
  List<ReturnData> get filteredReturns => (_$filteredReturnsComputed ??=
          Computed<List<ReturnData>>(() => super.filteredReturns,
              name: '_EmployeeStore.filteredReturns'))
      .value;
  Computed<int>? _$totalSalesComputed;

  @override
  int get totalSales =>
      (_$totalSalesComputed ??= Computed<int>(() => super.totalSales,
              name: '_EmployeeStore.totalSales'))
          .value;
  Computed<int>? _$totalTransactionsCountComputed;

  @override
  int get totalTransactionsCount => (_$totalTransactionsCountComputed ??=
          Computed<int>(() => super.totalTransactionsCount,
              name: '_EmployeeStore.totalTransactionsCount'))
      .value;
  Computed<int>? _$totalEstimatedProfitComputed;

  @override
  int get totalEstimatedProfit => (_$totalEstimatedProfitComputed ??=
          Computed<int>(() => super.totalEstimatedProfit,
              name: '_EmployeeStore.totalEstimatedProfit'))
      .value;
  Computed<int>? _$totalRestockCostComputed;

  @override
  int get totalRestockCost => (_$totalRestockCostComputed ??= Computed<int>(
          () => super.totalRestockCost,
          name: '_EmployeeStore.totalRestockCost'))
      .value;
  Computed<int>? _$totalRestockQtyComputed;

  @override
  int get totalRestockQty =>
      (_$totalRestockQtyComputed ??= Computed<int>(() => super.totalRestockQty,
              name: '_EmployeeStore.totalRestockQty'))
          .value;
  Computed<int>? _$totalCashInComputed;

  @override
  int get totalCashIn =>
      (_$totalCashInComputed ??= Computed<int>(() => super.totalCashIn,
              name: '_EmployeeStore.totalCashIn'))
          .value;
  Computed<int>? _$totalCashOutComputed;

  @override
  int get totalCashOut =>
      (_$totalCashOutComputed ??= Computed<int>(() => super.totalCashOut,
              name: '_EmployeeStore.totalCashOut'))
          .value;
  Computed<int>? _$totalRefundAmountComputed;

  @override
  int get totalRefundAmount => (_$totalRefundAmountComputed ??= Computed<int>(
          () => super.totalRefundAmount,
          name: '_EmployeeStore.totalRefundAmount'))
      .value;
  Computed<int>? _$totalReturnsCountComputed;

  @override
  int get totalReturnsCount => (_$totalReturnsCountComputed ??= Computed<int>(
          () => super.totalReturnsCount,
          name: '_EmployeeStore.totalReturnsCount'))
      .value;

  late final _$employeeListAtom =
      Atom(name: '_EmployeeStore.employeeList', context: context);

  @override
  ObservableList<UserData> get employeeList {
    _$employeeListAtom.reportRead();
    return super.employeeList;
  }

  @override
  set employeeList(ObservableList<UserData> value) {
    _$employeeListAtom.reportWrite(value, super.employeeList, () {
      super.employeeList = value;
    });
  }

  late final _$selectedEmployeeAtom =
      Atom(name: '_EmployeeStore.selectedEmployee', context: context);

  @override
  UserData? get selectedEmployee {
    _$selectedEmployeeAtom.reportRead();
    return super.selectedEmployee;
  }

  @override
  set selectedEmployee(UserData? value) {
    _$selectedEmployeeAtom.reportWrite(value, super.selectedEmployee, () {
      super.selectedEmployee = value;
    });
  }

  late final _$transactionsAtom =
      Atom(name: '_EmployeeStore.transactions', context: context);

  @override
  ObservableList<TransactionData> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(ObservableList<TransactionData> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  late final _$restocksAtom =
      Atom(name: '_EmployeeStore.restocks', context: context);

  @override
  ObservableList<RestockWithProduct> get restocks {
    _$restocksAtom.reportRead();
    return super.restocks;
  }

  @override
  set restocks(ObservableList<RestockWithProduct> value) {
    _$restocksAtom.reportWrite(value, super.restocks, () {
      super.restocks = value;
    });
  }

  late final _$balanceLogsAtom =
      Atom(name: '_EmployeeStore.balanceLogs', context: context);

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

  late final _$returnsAtom =
      Atom(name: '_EmployeeStore.returns', context: context);

  @override
  ObservableList<ReturnData> get returns {
    _$returnsAtom.reportRead();
    return super.returns;
  }

  @override
  set returns(ObservableList<ReturnData> value) {
    _$returnsAtom.reportWrite(value, super.returns, () {
      super.returns = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_EmployeeStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$dateFilterAtom =
      Atom(name: '_EmployeeStore.dateFilter', context: context);

  @override
  String get dateFilter {
    _$dateFilterAtom.reportRead();
    return super.dateFilter;
  }

  @override
  set dateFilter(String value) {
    _$dateFilterAtom.reportWrite(value, super.dateFilter, () {
      super.dateFilter = value;
    });
  }

  late final _$customDateRangeAtom =
      Atom(name: '_EmployeeStore.customDateRange', context: context);

  @override
  DateTimeRange<DateTime>? get customDateRange {
    _$customDateRangeAtom.reportRead();
    return super.customDateRange;
  }

  @override
  set customDateRange(DateTimeRange<DateTime>? value) {
    _$customDateRangeAtom.reportWrite(value, super.customDateRange, () {
      super.customDateRange = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_EmployeeStore.isLoading', context: context);

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

  late final _$isLogsLoadingAtom =
      Atom(name: '_EmployeeStore.isLogsLoading', context: context);

  @override
  bool get isLogsLoading {
    _$isLogsLoadingAtom.reportRead();
    return super.isLogsLoading;
  }

  @override
  set isLogsLoading(bool value) {
    _$isLogsLoadingAtom.reportWrite(value, super.isLogsLoading, () {
      super.isLogsLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_EmployeeStore.errorMessage', context: context);

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

  late final _$loadEmployeesAsyncAction =
      AsyncAction('_EmployeeStore.loadEmployees', context: context);

  @override
  Future<void> loadEmployees() {
    return _$loadEmployeesAsyncAction.run(() => super.loadEmployees());
  }

  late final _$selectEmployeeAsyncAction =
      AsyncAction('_EmployeeStore.selectEmployee', context: context);

  @override
  Future<void> selectEmployee(UserData employee, {int? storeId}) {
    return _$selectEmployeeAsyncAction
        .run(() => super.selectEmployee(employee, storeId: storeId));
  }

  late final _$loadEmployeeLogsAsyncAction =
      AsyncAction('_EmployeeStore.loadEmployeeLogs', context: context);

  @override
  Future<void> loadEmployeeLogs(int userId, {int? storeId}) {
    return _$loadEmployeeLogsAsyncAction
        .run(() => super.loadEmployeeLogs(userId, storeId: storeId));
  }

  late final _$addEmployeeAsyncAction =
      AsyncAction('_EmployeeStore.addEmployee', context: context);

  @override
  Future<bool> addEmployee(
      {required String username,
      required String fullname,
      required String email,
      required String password,
      required String role}) {
    return _$addEmployeeAsyncAction.run(() => super.addEmployee(
        username: username,
        fullname: fullname,
        email: email,
        password: password,
        role: role));
  }

  late final _$updateEmployeeAsyncAction =
      AsyncAction('_EmployeeStore.updateEmployee', context: context);

  @override
  Future<bool> updateEmployee(
      {required int userId,
      required String fullname,
      required String email,
      required String role,
      String? newPassword}) {
    return _$updateEmployeeAsyncAction.run(() => super.updateEmployee(
        userId: userId,
        fullname: fullname,
        email: email,
        role: role,
        newPassword: newPassword));
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('_EmployeeStore.resetPassword', context: context);

  @override
  Future<bool> resetPassword(
      {required int userId, required String newPassword}) {
    return _$resetPasswordAsyncAction.run(
        () => super.resetPassword(userId: userId, newPassword: newPassword));
  }

  late final _$deleteEmployeeAsyncAction =
      AsyncAction('_EmployeeStore.deleteEmployee', context: context);

  @override
  Future<bool> deleteEmployee(
      {required int userId, required int currentUserId}) {
    return _$deleteEmployeeAsyncAction.run(() =>
        super.deleteEmployee(userId: userId, currentUserId: currentUserId));
  }

  late final _$_EmployeeStoreActionController =
      ActionController(name: '_EmployeeStore', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateFilter(String filter, [DateTimeRange<DateTime>? range]) {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.setDateFilter');
    try {
      return super.setDateFilter(filter, range);
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
employeeList: ${employeeList},
selectedEmployee: ${selectedEmployee},
transactions: ${transactions},
restocks: ${restocks},
balanceLogs: ${balanceLogs},
returns: ${returns},
searchQuery: ${searchQuery},
dateFilter: ${dateFilter},
customDateRange: ${customDateRange},
isLoading: ${isLoading},
isLogsLoading: ${isLogsLoading},
errorMessage: ${errorMessage},
filteredEmployees: ${filteredEmployees},
filteredTransactions: ${filteredTransactions},
filteredRestocks: ${filteredRestocks},
filteredBalanceLogs: ${filteredBalanceLogs},
filteredReturns: ${filteredReturns},
totalSales: ${totalSales},
totalTransactionsCount: ${totalTransactionsCount},
totalEstimatedProfit: ${totalEstimatedProfit},
totalRestockCost: ${totalRestockCost},
totalRestockQty: ${totalRestockQty},
totalCashIn: ${totalCashIn},
totalCashOut: ${totalCashOut},
totalRefundAmount: ${totalRefundAmount},
totalReturnsCount: ${totalReturnsCount}
    ''';
  }
}
