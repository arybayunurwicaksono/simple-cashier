import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/store_profiles_table.dart';
import '../tables/users_table.dart';
import '../tables/categories_table.dart';
import '../tables/products_table.dart';
import '../tables/services_table.dart';
import '../tables/transactions_table.dart';
import '../tables/transaction_items_table.dart';
import '../tables/restocks_table.dart';
import '../tables/returns_table.dart';
import '../tables/balance_logs_table.dart';
import '../tables/monthly_accounting_table.dart';

part 'backup_dao.g.dart';

@DriftAccessor(tables: [
  StoreProfiles,
  Users,
  Categories,
  Products,
  Services,
  Transactions,
  TransactionItems,
  Restocks,
  Returns,
  BalanceLogs,
  MonthlyAccounting,
])
class BackupDao extends DatabaseAccessor<AppDatabase> with _$BackupDaoMixin {
  BackupDao(super.db);

  /// Exports all data across all 11 tables to a comprehensive Map
  Future<Map<String, dynamic>> exportAllData({required String appVersion}) async {
    final storeProfileList = await select(storeProfiles).get();
    final userList = await select(users).get();
    final categoryList = await select(categories).get();
    final productList = await select(products).get();
    final serviceList = await select(services).get();
    final transactionList = await select(transactions).get();
    final transactionItemList = await select(transactionItems).get();
    final restockList = await select(restocks).get();
    final returnList = await select(returns).get();
    final balanceLogList = await select(balanceLogs).get();
    final monthlyAccountingList = await select(monthlyAccounting).get();

    final storeName = storeProfileList.isNotEmpty ? storeProfileList.first.storeName : 'Simple Cashier';

    return {
      'metadata': {
        'format': 'simple_cashier_backup',
        'schemaVersion': 1,
        'appVersion': appVersion,
        'storeName': storeName,
        'exportedAt': DateTime.now().toIso8601String(),
        'counts': {
          'users': userList.length,
          'storeProfiles': storeProfileList.length,
          'categories': categoryList.length,
          'products': productList.length,
          'services': serviceList.length,
          'transactions': transactionList.length,
          'transactionItems': transactionItemList.length,
          'balanceLogs': balanceLogList.length,
          'monthlyAccounting': monthlyAccountingList.length,
          'restocks': restockList.length,
          'returns': returnList.length,
        },
      },
      'storeProfiles': storeProfileList.map((e) => e.toJson()).toList(),
      'users': userList.map((e) => e.toJson()).toList(),
      'categories': categoryList.map((e) => e.toJson()).toList(),
      'products': productList.map((e) => e.toJson()).toList(),
      'services': serviceList.map((e) => e.toJson()).toList(),
      'transactions': transactionList.map((e) => e.toJson()).toList(),
      'transactionItems': transactionItemList.map((e) => e.toJson()).toList(),
      'balanceLogs': balanceLogList.map((e) => e.toJson()).toList(),
      'monthlyAccounting': monthlyAccountingList.map((e) => e.toJson()).toList(),
      'restocks': restockList.map((e) => e.toJson()).toList(),
      'returns': returnList.map((e) => e.toJson()).toList(),
    };
  }

  /// Restores all data from an imported backup Map in a safe transaction
  Future<bool> restoreAllData(Map<String, dynamic> backupData) async {
    return transaction(() async {
      // 1. Clear existing records in reverse dependency order
      await delete(returns).go();
      await delete(restocks).go();
      await delete(monthlyAccounting).go();
      await delete(balanceLogs).go();
      await delete(transactionItems).go();
      await delete(transactions).go();
      await delete(services).go();
      await delete(products).go();
      await delete(categories).go();
      await delete(storeProfiles).go();
      await delete(users).go();

      // 2. Insert records from backup data in forward dependency order

      // Store Profiles
      if (backupData['storeProfiles'] != null) {
        for (final raw in (backupData['storeProfiles'] as List)) {
          await into(storeProfiles).insert(StoreProfileData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Users
      if (backupData['users'] != null) {
        for (final raw in (backupData['users'] as List)) {
          await into(users).insert(UserData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Categories
      if (backupData['categories'] != null) {
        for (final raw in (backupData['categories'] as List)) {
          await into(categories).insert(CategoryData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Products
      if (backupData['products'] != null) {
        for (final raw in (backupData['products'] as List)) {
          await into(products).insert(ProductData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Services
      if (backupData['services'] != null) {
        for (final raw in (backupData['services'] as List)) {
          await into(services).insert(ServiceData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Transactions
      if (backupData['transactions'] != null) {
        for (final raw in (backupData['transactions'] as List)) {
          await into(transactions).insert(TransactionData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Transaction Items
      if (backupData['transactionItems'] != null) {
        for (final raw in (backupData['transactionItems'] as List)) {
          await into(transactionItems).insert(TransactionItemData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Balance Logs
      if (backupData['balanceLogs'] != null) {
        for (final raw in (backupData['balanceLogs'] as List)) {
          await into(balanceLogs).insert(BalanceLogData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Monthly Accounting
      if (backupData['monthlyAccounting'] != null) {
        for (final raw in (backupData['monthlyAccounting'] as List)) {
          await into(monthlyAccounting).insert(MonthlyAccountingData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Restocks
      if (backupData['restocks'] != null) {
        for (final raw in (backupData['restocks'] as List)) {
          await into(restocks).insert(RestockData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      // Returns
      if (backupData['returns'] != null) {
        for (final raw in (backupData['returns'] as List)) {
          await into(returns).insert(ReturnData.fromJson(Map<String, dynamic>.from(raw)));
        }
      }

      return true;
    });
  }
}
