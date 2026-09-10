import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/balance_logs_table.dart';

part 'balance_dao.g.dart';

@DriftAccessor(tables: [BalanceLogs])
class BalanceDao extends DatabaseAccessor<AppDatabase> with _$BalanceDaoMixin {
  BalanceDao(super.db);

  Stream<List<BalanceLogData>> watchAllBalanceLogs({int? storeId}) {
    final query = select(balanceLogs);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  Future<List<BalanceLogData>> getAllBalanceLogs({int? storeId}) {
    final query = select(balanceLogs);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();
  }

  Future<int> insertBalanceLog(BalanceLogsCompanion log) =>
      into(balanceLogs).insert(log);

  /// Calculates current cash balance (Inflow - Outflow)
  Future<int> getCashBalance({int? storeId}) async {
    final query = select(balanceLogs)..where((tbl) => tbl.paymentType.equals('cash'));
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    final logs = await query.get();
    int balance = 0;
    for (final l in logs) {
      if (l.flowType == 'in') {
        balance += l.amount;
      } else {
        balance -= l.amount;
      }
    }
    return balance;
  }

  /// Calculates current digital balance (Inflow - Outflow)
  Future<int> getDigitalBalance({int? storeId}) async {
    final query = select(balanceLogs)..where((tbl) => tbl.paymentType.equals('digital'));
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    final logs = await query.get();
    int balance = 0;
    for (final l in logs) {
      if (l.flowType == 'in') {
        balance += l.amount;
      } else {
        balance -= l.amount;
      }
    }
    return balance;
  }

  Stream<List<BalanceLogData>> watchBalanceLogsByUser(int userId, {int? storeId}) {
    final query = select(balanceLogs)..where((tbl) => tbl.userId.equals(userId));
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  Future<List<BalanceLogData>> getBalanceLogsByUser(int userId, {int? storeId}) {
    final query = select(balanceLogs)..where((tbl) => tbl.userId.equals(userId));
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();
  }
}
