import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/store_profiles_table.dart';
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
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Future schema migration logic
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'simple_cashier_local.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
