import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/monthly_accounting_table.dart';
import '../tables/transactions_table.dart';
import '../tables/transaction_items_table.dart';
import '../tables/balance_logs_table.dart';
import '../tables/products_table.dart';

part 'accounting_dao.g.dart';

@DriftAccessor(tables: [
  MonthlyAccounting,
  Transactions,
  TransactionItems,
  BalanceLogs,
  Products
])
class AccountingDao extends DatabaseAccessor<AppDatabase> with _$AccountingDaoMixin {
  AccountingDao(super.db);

  Stream<List<MonthlyAccountingData>> watchAllMonthlyLedgers({int? storeId}) {
    final query = select(monthlyAccounting);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).watch();
  }

  Future<List<MonthlyAccountingData>> getAllMonthlyLedgers({int? storeId}) {
    final query = select(monthlyAccounting);
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return (query..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])).get();
  }

  Future<MonthlyAccountingData?> getLedgerByPeriod(String period, {int? storeId}) {
    final query = select(monthlyAccounting)
      ..where((tbl) => tbl.periodMonthYear.equals(period));
    if (storeId != null) {
      query.where((tbl) => tbl.storeId.equals(storeId));
    }
    return query.getSingleOrNull();
  }

  Future<int> insertOrUpdateLedger(MonthlyAccountingCompanion ledger, {int? storeId}) async {
    final targetStoreId = storeId ?? ledger.storeId.value;
    final existing = await getLedgerByPeriod(ledger.periodMonthYear.value, storeId: targetStoreId);
    if (existing != null) {
      return (update(monthlyAccounting)
            ..where((tbl) => tbl.id.equals(existing.id)))
          .write(ledger);
    } else {
      return into(monthlyAccounting).insert(ledger);
    }
  }

  /// Calculates automated financial aggregation for a period (e.g. "Agustus 2026")
  Future<Map<String, int>> calculatePeriodAggregation({
    required DateTime startDate,
    required DateTime endDate,
    int? storeId,
  }) async {
    final txQuery = select(transactions)
      ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate));
    if (storeId != null) {
      txQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final txList = await txQuery.get();

    int incomeGoods = 0;
    int incomeServices = 0;
    int totalSoldItems = 0;

    for (final tx in txList) {
      final items = await (select(transactionItems)
            ..where((tbl) => tbl.transactionId.equals(tx.id)))
          .get();
      for (final item in items) {
        totalSoldItems += item.quantity;
        if (item.itemType == 'product') {
          incomeGoods += item.subtotalPrice;
        } else {
          incomeServices += item.subtotalPrice;
        }
      }
    }

    final balanceQuery = select(balanceLogs)
      ..where((tbl) =>
          tbl.createdAt.isBetweenValues(startDate, endDate) &
          tbl.flowType.equals('out'));
    if (storeId != null) {
      balanceQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final balanceOutLogs = await balanceQuery.get();

    int totalExpense = balanceOutLogs.fold(0, (sum, log) => sum + log.amount);
    int totalIncome = incomeGoods + incomeServices;
    int netProfit = totalIncome - totalExpense;

    return {
      'incomeGoods': incomeGoods,
      'incomeServices': incomeServices,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'netProfit': netProfit,
      'txCount': txList.length,
      'itemCount': totalSoldItems,
    };
  }
}
