import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:thermal_printer/thermal_printer.dart';
import 'package:ui/ui.dart';
import '../stores/auth_store.dart';
import '../stores/product_store.dart';
import '../stores/service_store.dart';
import '../stores/pos_store.dart';
import '../stores/balance_store.dart';
import '../stores/accounting_store.dart';
import '../stores/settings_store.dart';
import '../stores/backup_store.dart';
import '../stores/analytics_store.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // 1. Core Services & Image File Resolver Initialization
  await FileStorageService.initialize();
  ProductCard.customImageResolver = FileStorageService.resolveFile;
  ServiceCard.customImageResolver = FileStorageService.resolveFile;

  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  getIt.registerLazySingleton<FileStorageService>(() => FileStorageService());
  getIt.registerLazySingleton<BackupService>(() => BackupService());
  getIt.registerLazySingleton<ThermalPrinterService>(() => ThermalPrinterService());

  // 2. Drift SQLite Database & DAOs
  final db = AppDatabase();
  getIt.registerSingleton<AppDatabase>(db);
  getIt.registerLazySingleton<UserDao>(() => db.userDao);
  getIt.registerLazySingleton<StoreProfileDao>(() => db.storeProfileDao);
  getIt.registerLazySingleton<CategoryDao>(() => db.categoryDao);
  getIt.registerLazySingleton<ProductDao>(() => db.productDao);
  getIt.registerLazySingleton<ServiceDao>(() => db.serviceDao);
  getIt.registerLazySingleton<TransactionDao>(() => db.transactionDao);
  getIt.registerLazySingleton<BalanceDao>(() => db.balanceDao);
  getIt.registerLazySingleton<AccountingDao>(() => db.accountingDao);
  getIt.registerLazySingleton<BackupDao>(() => db.backupDao);
  getIt.registerLazySingleton<AnalyticsDao>(() => db.analyticsDao);

  // 3. MobX Stores
  getIt.registerLazySingleton<AuthStore>(
    () => AuthStore(
      userDao: getIt<UserDao>(),
      secureStorage: getIt<SecureStorageService>(),
    ),
  );

  getIt.registerLazySingleton<ProductStore>(
    () => ProductStore(
      productDao: getIt<ProductDao>(),
      categoryDao: getIt<CategoryDao>(),
      fileStorage: getIt<FileStorageService>(),
    ),
  );

  getIt.registerLazySingleton<ServiceStore>(
    () => ServiceStore(
      serviceDao: getIt<ServiceDao>(),
      categoryDao: getIt<CategoryDao>(),
      fileStorage: getIt<FileStorageService>(),
    ),
  );

  getIt.registerLazySingleton<PosStore>(
    () => PosStore(
      transactionDao: getIt<TransactionDao>(),
      thermalPrinter: getIt<ThermalPrinterService>(),
      storeProfileDao: getIt<StoreProfileDao>(),
    ),
  );

  getIt.registerLazySingleton<BalanceStore>(
    () => BalanceStore(
      balanceDao: getIt<BalanceDao>(),
    ),
  );

  getIt.registerLazySingleton<AccountingStore>(
    () => AccountingStore(
      accountingDao: getIt<AccountingDao>(),
      productDao: getIt<ProductDao>(),
      balanceDao: getIt<BalanceDao>(),
      storeProfileDao: getIt<StoreProfileDao>(),
      transactionDao: getIt<TransactionDao>(),
    ),
  );

  getIt.registerLazySingleton<SettingsStore>(
    () => SettingsStore(
      storeProfileDao: getIt<StoreProfileDao>(),
      userDao: getIt<UserDao>(),
      thermalPrinter: getIt<ThermalPrinterService>(),
    ),
  );

  getIt.registerLazySingleton<BackupStore>(
    () => BackupStore(
      backupDao: getIt<BackupDao>(),
      storeProfileDao: getIt<StoreProfileDao>(),
      backupService: getIt<BackupService>(),
    ),
  );

  getIt.registerLazySingleton<AnalyticsStore>(
    () => AnalyticsStore(
      getIt<AnalyticsDao>(),
    ),
  );
}
