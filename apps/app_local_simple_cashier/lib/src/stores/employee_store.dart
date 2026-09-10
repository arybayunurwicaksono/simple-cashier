// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'employee_store.g.dart';

class EmployeeStore = _EmployeeStore with _$EmployeeStore;

abstract class _EmployeeStore with Store {
  final UserDao _userDao;
  final TransactionDao _transactionDao;
  final ProductDao _productDao;
  final BalanceDao _balanceDao;

  _EmployeeStore({
    required UserDao userDao,
    required TransactionDao transactionDao,
    required ProductDao productDao,
    required BalanceDao balanceDao,
  })  : _userDao = userDao,
        _transactionDao = transactionDao,
        _productDao = productDao,
        _balanceDao = balanceDao;

  @observable
  ObservableList<UserData> employeeList = ObservableList<UserData>();

  @observable
  UserData? selectedEmployee;

  @observable
  ObservableList<TransactionData> transactions = ObservableList<TransactionData>();

  @observable
  ObservableList<RestockWithProduct> restocks = ObservableList<RestockWithProduct>();

  @observable
  ObservableList<BalanceLogData> balanceLogs = ObservableList<BalanceLogData>();

  @observable
  ObservableList<ReturnData> returns = ObservableList<ReturnData>();

  @observable
  String searchQuery = '';

  @observable
  String dateFilter = 'all'; // 'all' | 'today' | 'week' | 'month' | 'custom'

  @observable
  DateTimeRange? customDateRange;

  @observable
  bool isLoading = false;

  @observable
  bool isLogsLoading = false;

  @observable
  String? errorMessage;

  @computed
  List<UserData> get filteredEmployees {
    if (searchQuery.trim().isEmpty) {
      return employeeList.toList();
    }
    final q = searchQuery.toLowerCase().trim();
    return employeeList.where((u) {
      return u.fullname.toLowerCase().contains(q) ||
          u.username.toLowerCase().contains(q) ||
          u.email.toLowerCase().contains(q) ||
          u.role.toLowerCase().contains(q);
    }).toList();
  }

  bool _isDateInRange(DateTime date) {
    final now = DateTime.now();
    switch (dateFilter) {
      case 'today':
        return date.year == now.year && date.month == now.month && date.day == now.day;
      case 'week':
        final sevenDaysAgo = now.subtract(const Duration(days: 7));
        return date.isAfter(DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day));
      case 'month':
        return date.year == now.year && date.month == now.month;
      case 'custom':
        if (customDateRange == null) return true;
        final start = DateTime(
          customDateRange!.start.year,
          customDateRange!.start.month,
          customDateRange!.start.day,
        );
        final end = DateTime(
          customDateRange!.end.year,
          customDateRange!.end.month,
          customDateRange!.end.day,
          23,
          59,
          59,
        );
        return (date.isAfter(start) || date.isAtSameMomentAs(start)) &&
            (date.isBefore(end) || date.isAtSameMomentAs(end));
      case 'all':
      default:
        return true;
    }
  }

  @computed
  List<TransactionData> get filteredTransactions {
    return transactions.where((t) => _isDateInRange(t.createdAt)).toList();
  }

  @computed
  List<RestockWithProduct> get filteredRestocks {
    return restocks.where((r) => _isDateInRange(r.restock.restockDate)).toList();
  }

  @computed
  List<BalanceLogData> get filteredBalanceLogs {
    return balanceLogs.where((b) => _isDateInRange(b.createdAt)).toList();
  }

  @computed
  List<ReturnData> get filteredReturns {
    return returns.where((r) => _isDateInRange(r.returnDate)).toList();
  }

  @computed
  int get totalSales =>
      filteredTransactions.fold<int>(0, (sum, t) => sum + t.totalAmount);

  @computed
  int get totalTransactionsCount => filteredTransactions.length;

  @computed
  int get totalEstimatedProfit =>
      filteredTransactions.fold<int>(0, (sum, t) => sum + t.totalProfit);

  @computed
  int get totalRestockCost =>
      filteredRestocks.fold<int>(0, (sum, r) => sum + r.restock.totalPurchaseCost);

  @computed
  int get totalRestockQty =>
      filteredRestocks.fold<int>(0, (sum, r) => sum + r.restock.quantityAdded);

  @computed
  int get totalCashIn => filteredBalanceLogs
      .where((b) => b.flowType == 'in')
      .fold<int>(0, (sum, b) => sum + b.amount);

  @computed
  int get totalCashOut => filteredBalanceLogs
      .where((b) => b.flowType == 'out')
      .fold<int>(0, (sum, b) => sum + b.amount);

  @computed
  int get totalRefundAmount =>
      filteredReturns.fold<int>(0, (sum, r) => sum + r.totalRefundAmount);

  @computed
  int get totalReturnsCount => filteredReturns.length;

  @action
  Future<void> loadEmployees() async {
    isLoading = true;
    errorMessage = null;
    try {
      final users = await _userDao.getAllUsers();
      employeeList = ObservableList.of(users);
    } catch (e) {
      errorMessage = 'Gagal memuat daftar karyawan: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void setDateFilter(String filter, [DateTimeRange? range]) {
    dateFilter = filter;
    customDateRange = range;
  }

  @action
  Future<void> selectEmployee(UserData employee, {int? storeId}) async {
    selectedEmployee = employee;
    await loadEmployeeLogs(employee.id, storeId: storeId);
  }

  @action
  Future<void> loadEmployeeLogs(int userId, {int? storeId}) async {
    isLogsLoading = true;
    errorMessage = null;
    try {
      final txs = await _transactionDao.getTransactionsByUser(userId, storeId: storeId);
      final rst = await _productDao.getRestocksWithProduct(userId: userId, storeId: storeId);
      final bls = await _balanceDao.getBalanceLogsByUser(userId, storeId: storeId);
      final ret = await _transactionDao.getReturnsByUser(userId);

      transactions = ObservableList.of(txs);
      restocks = ObservableList.of(rst);
      balanceLogs = ObservableList.of(bls);
      returns = ObservableList.of(ret);
    } catch (e) {
      errorMessage = 'Gagal memuat log aktivitas karyawan: ${e.toString()}';
    } finally {
      isLogsLoading = false;
    }
  }

  @action
  Future<bool> addEmployee({
    required String username,
    required String fullname,
    required String email,
    required String password,
    required String role,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final existingUser = await _userDao.getUserByUsername(username.trim());
      if (existingUser != null) {
        errorMessage = 'Username "$username" sudah digunakan';
        return false;
      }

      final existingEmail = await _userDao.getUserByEmail(email.trim());
      if (existingEmail != null) {
        errorMessage = 'Email "$email" sudah terdaftar';
        return false;
      }

      final salt = PasswordHasher.generateSalt();
      final passwordHash = PasswordHasher.hashPassword(password, salt);

      await _userDao.insertUser(
        UsersCompanion(
          username: Value(username.trim()),
          email: Value(email.trim().toLowerCase()),
          fullname: Value(fullname.trim()),
          passwordHash: Value(passwordHash),
          salt: Value(salt),
          role: Value(role),
        ),
      );

      await loadEmployees();
      return true;
    } catch (e) {
      errorMessage = 'Gagal menambahkan karyawan: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> updateEmployee({
    required int userId,
    required String fullname,
    required String email,
    required String role,
    String? newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final existingEmail = await _userDao.getUserByEmail(email.trim());
      if (existingEmail != null && existingEmail.id != userId) {
        errorMessage = 'Email "$email" sudah digunakan karyawan lain';
        return false;
      }

      await _userDao.updateUserProfile(
        userId: userId,
        fullname: fullname.trim(),
        email: email.trim().toLowerCase(),
        role: role,
      );

      if (newPassword != null && newPassword.trim().isNotEmpty) {
        final salt = PasswordHasher.generateSalt();
        final passwordHash = PasswordHasher.hashPassword(newPassword.trim(), salt);
        await _userDao.updateUserPassword(
          userId: userId,
          newPasswordHash: passwordHash,
          newSalt: salt,
        );
      }

      await loadEmployees();

      if (selectedEmployee?.id == userId) {
        selectedEmployee = await _userDao.getUserById(userId);
      }

      return true;
    } catch (e) {
      errorMessage = 'Gagal memperbarui karyawan: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> resetPassword({
    required int userId,
    required String newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final salt = PasswordHasher.generateSalt();
      final passwordHash = PasswordHasher.hashPassword(newPassword.trim(), salt);
      final success = await _userDao.updateUserPassword(
        userId: userId,
        newPasswordHash: passwordHash,
        newSalt: salt,
      );
      return success;
    } catch (e) {
      errorMessage = 'Gagal mereset kata sandi: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deleteEmployee({
    required int userId,
    required int currentUserId,
  }) async {
    if (userId == currentUserId) {
      errorMessage = 'Anda tidak dapat menghapus akun Anda sendiri yang sedang aktif.';
      return false;
    }

    isLoading = true;
    errorMessage = null;
    try {
      final targetUser = await _userDao.getUserById(userId);
      if (targetUser == null) {
        errorMessage = 'Pengguna tidak ditemukan.';
        return false;
      }

      // If target is owner, check if other owners exist
      if (targetUser.role == 'owner') {
        final allUsers = await _userDao.getAllUsers();
        final ownerCount = allUsers.where((u) => u.role == 'owner').length;
        if (ownerCount <= 1) {
          errorMessage = 'Tidak dapat menghapus satu-satunya akun Pemilik (Owner).';
          return false;
        }
      }

      await _userDao.deleteUser(userId);
      await loadEmployees();
      if (selectedEmployee?.id == userId) {
        selectedEmployee = null;
      }
      return true;
    } catch (e) {
      errorMessage = 'Gagal menghapus karyawan: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }
}
