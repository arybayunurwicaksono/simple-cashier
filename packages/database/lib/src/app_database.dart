import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/store_profiles_table.dart';
import 'tables/stores_table.dart';
import 'tables/users_table.dart';
import 'tables/categories_table.dart';
import 'tables/products_table.dart';
import 'tables/services_table.dart';
import 'tables/transactions_table.dart';
import 'tables/transaction_items_table.dart';
import 'tables/restocks_table.dart';
import 'tables/returns_table.dart';
import 'tables/balance_logs_table.dart';
import 'tables/monthly_accounting_table.dart';

import 'daos/user_dao.dart';
import 'daos/store_profile_dao.dart';
import 'daos/store_dao.dart';
import 'daos/category_dao.dart';
import 'daos/product_dao.dart';
import 'daos/service_dao.dart';
import 'daos/transaction_dao.dart';
import 'daos/balance_dao.dart';
import 'daos/accounting_dao.dart';
import 'daos/backup_dao.dart';
import 'daos/analytics_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    StoreProfiles,
    Stores,
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
  ],
  daos: [
    UserDao,
    StoreProfileDao,
    StoreDao,
    CategoryDao,
    ProductDao,
    ServiceDao,
    TransactionDao,
    BalanceDao,
    AccountingDao,
    BackupDao,
    AnalyticsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await _ensureTable(m, stores);
            await _ensureColumn(m, categories, categories.storeId);
            await _ensureColumn(m, products, products.storeId);
            await _ensureColumn(m, services, services.storeId);
            await _ensureColumn(m, transactions, transactions.storeId);
            await _ensureColumn(m, balanceLogs, balanceLogs.storeId);
            await _ensureColumn(m, monthlyAccounting, monthlyAccounting.storeId);
          }
        },
        beforeOpen: (OpeningDetails details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
          final m = Migrator(this);
          await _ensureTable(m, stores);
          await _ensureColumn(m, categories, categories.storeId);
          await _ensureColumn(m, products, products.storeId);
          await _ensureColumn(m, services, services.storeId);
          await _ensureColumn(m, transactions, transactions.storeId);
          await _ensureColumn(m, balanceLogs, balanceLogs.storeId);
          await _ensureColumn(m, monthlyAccounting, monthlyAccounting.storeId);
        },
      );

  Future<void> _ensureTable(Migrator m, TableInfo table) async {
    final tables = await customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='${table.actualTableName}';",
    ).get();
    if (tables.isEmpty) {
      await m.createTable(table);
    }
  }

  Future<void> _ensureColumn(Migrator m, TableInfo table, GeneratedColumn column) async {
    final tables = await customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='${table.actualTableName}';",
    ).get();
    if (tables.isNotEmpty) {
      final info = await customSelect('PRAGMA table_info("${table.actualTableName}");').get();
      final columnExists = info.any((row) => row.data['name'] == column.$name);
      if (!columnExists) {
        await m.addColumn(table, column);
      }
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'simple_cashier_local.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
