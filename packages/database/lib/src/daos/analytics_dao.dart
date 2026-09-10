import 'package:drift/drift.dart';
import 'package:core/core.dart';
import '../app_database.dart';
import '../tables/transactions_table.dart';
import '../tables/transaction_items_table.dart';
import '../tables/balance_logs_table.dart';
import '../tables/restocks_table.dart';
import '../tables/products_table.dart';
import '../tables/services_table.dart';

part 'analytics_dao.g.dart';

@DriftAccessor(tables: [
  Transactions,
  TransactionItems,
  BalanceLogs,
  Restocks,
  Products,
  Services,
])
class AnalyticsDao extends DatabaseAccessor<AppDatabase> with _$AnalyticsDaoMixin {
  AnalyticsDao(super.db);

  /// Fetches profit/loss trend grouped by yearly (12 months), monthly (weeks), or weekly (7 days)
  Future<List<ChartDataPoint>> getProfitTrend({
    required DateTime startDate,
    required DateTime endDate,
    required String interval, // 'yearly' | 'monthly' | 'weekly'
    int? storeId,
  }) async {
    final txQuery = select(transactions)
      ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate));
    if (storeId != null) {
      txQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final txList = await txQuery.get();

    final expenseQuery = select(balanceLogs)
      ..where((tbl) =>
          tbl.createdAt.isBetweenValues(startDate, endDate) &
          tbl.flowType.equals('out'));
    if (storeId != null) {
      expenseQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final expenseLogs = await expenseQuery.get();

    if (interval == 'yearly') {
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
      ];
      final monthProfits = List<int>.filled(12, 0);

      for (final tx in txList) {
        final m = tx.createdAt.month - 1;
        if (m >= 0 && m < 12) {
          monthProfits[m] += tx.totalProfit;
        }
      }

      for (final exp in expenseLogs) {
        final m = exp.createdAt.month - 1;
        if (m >= 0 && m < 12) {
          monthProfits[m] -= exp.amount;
        }
      }

      int maxProfit = monthProfits.fold(0, (max, val) => val > max ? val : max);
      if (maxProfit <= 0) maxProfit = 1;

      return List.generate(12, (i) {
        final val = monthProfits[i];
        final pct = val > 0 ? (val / maxProfit).clamp(0.05, 1.0) : 0.05;
        return ChartDataPoint(
          label: months[i],
          value: val,
          percentage: pct,
        );
      });
    } else if (interval == 'monthly') {
      // 4-5 Weeks
      const weekLabels = ['Mg 1', 'Mg 2', 'Mg 3', 'Mg 4', 'Mg 5'];
      final weekProfits = List<int>.filled(5, 0);

      for (final tx in txList) {
        final weekIdx = ((tx.createdAt.day - 1) ~/ 7).clamp(0, 4);
        weekProfits[weekIdx] += tx.totalProfit;
      }

      for (final exp in expenseLogs) {
        final weekIdx = ((exp.createdAt.day - 1) ~/ 7).clamp(0, 4);
        weekProfits[weekIdx] -= exp.amount;
      }

      int maxProfit = weekProfits.fold(0, (max, val) => val > max ? val : max);
      if (maxProfit <= 0) maxProfit = 1;

      return List.generate(5, (i) {
        final val = weekProfits[i];
        final pct = val > 0 ? (val / maxProfit).clamp(0.05, 1.0) : 0.05;
        return ChartDataPoint(
          label: weekLabels[i],
          value: val,
          percentage: pct,
        );
      });
    } else {
      // Weekly: 7 days
      final dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
      final dailyProfits = List<int>.filled(7, 0);
      final daysList = <ChartDataPoint>[];

      // Calculate for each of the last 7 days ending at endDate
      for (int i = 6; i >= 0; i--) {
        final targetDate = endDate.subtract(Duration(days: i));
        final dayStart = DateTime(targetDate.year, targetDate.month, targetDate.day, 0, 0, 0);
        final dayEnd = DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59);

        int dayProfit = 0;
        for (final tx in txList) {
          if (tx.createdAt.isAfter(dayStart) && tx.createdAt.isBefore(dayEnd)) {
            dayProfit += tx.totalProfit;
          }
        }
        for (final exp in expenseLogs) {
          if (exp.createdAt.isAfter(dayStart) && exp.createdAt.isBefore(dayEnd)) {
            dayProfit -= exp.amount;
          }
        }
        dailyProfits[6 - i] = dayProfit;
      }

      int maxProfit = dailyProfits.fold(0, (max, val) => val > max ? val : max);
      if (maxProfit <= 0) maxProfit = 1;

      for (int i = 6; i >= 0; i--) {
        final targetDate = endDate.subtract(Duration(days: i));
        final weekdayIndex = (targetDate.weekday - 1) % 7;
        final val = dailyProfits[6 - i];
        final pct = val > 0 ? (val / maxProfit).clamp(0.05, 1.0) : 0.05;

        daysList.add(ChartDataPoint(
          label: dayNames[weekdayIndex],
          value: val,
          percentage: pct,
          date: targetDate,
        ));
      }

      return daysList;
    }
  }

  /// Calculates stock movement: total stock in (restocks) vs total stock sold (transaction items)
  Future<StockMovementSummary> getStockMovement({
    required DateTime startDate,
    required DateTime endDate,
    int? storeId,
  }) async {
    final restockList = await (select(restocks)
          ..where((tbl) => tbl.restockDate.isBetweenValues(startDate, endDate)))
        .get();

    int totalStockIn = 0;
    int totalRestockCost = 0;
    for (final r in restockList) {
      totalStockIn += r.quantityAdded;
      totalRestockCost += r.totalPurchaseCost;
    }

    final txQuery = select(transactions)
      ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate));
    if (storeId != null) {
      txQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final txList = await txQuery.get();

    final txIds = txList.map((t) => t.id).toList();

    int totalStockSold = 0;
    if (txIds.isNotEmpty) {
      final items = await (select(transactionItems)
            ..where((tbl) => tbl.transactionId.isIn(txIds) & tbl.itemType.equals('product')))
          .get();

      for (final item in items) {
        totalStockSold += item.quantity;
      }
    }

    double turnoverRate = 0.0;
    final totalUnits = totalStockIn + totalStockSold;
    if (totalUnits > 0) {
      turnoverRate = (totalStockSold / totalUnits) * 100.0;
    }

    return StockMovementSummary(
      totalStockIn: totalStockIn,
      totalStockSold: totalStockSold,
      turnoverRate: turnoverRate,
      totalRestockCost: totalRestockCost,
    );
  }

  /// Calculates goods vs services revenue mix and spline trend data
  Future<RevenueMixSummary> getRevenueMix({
    required DateTime startDate,
    required DateTime endDate,
    required String interval,
    int? storeId,
  }) async {
    final txQuery = select(transactions)
      ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate));
    if (storeId != null) {
      txQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final txList = await txQuery.get();

    final txIds = txList.map((t) => t.id).toList();

    int productRevenue = 0;
    int serviceRevenue = 0;
    final List<ChartDataPoint> trendPoints = [];

    if (txIds.isNotEmpty) {
      final items = await (select(transactionItems)
            ..where((tbl) => tbl.transactionId.isIn(txIds)))
          .get();

      for (final item in items) {
        if (item.itemType == 'product') {
          productRevenue += item.subtotalPrice;
        } else if (item.itemType == 'service') {
          serviceRevenue += item.subtotalPrice;
        }
      }
    }

    final totalRevenue = productRevenue + serviceRevenue;
    final productRatio = totalRevenue > 0 ? (productRevenue / totalRevenue) : 0.5;
    final serviceRatio = totalRevenue > 0 ? (serviceRevenue / totalRevenue) : 0.5;

    // Trend points for Spline Area Chart
    if (interval == 'yearly') {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      final monthProd = List<int>.filled(12, 0);
      final monthServ = List<int>.filled(12, 0);

      for (final tx in txList) {
        final m = tx.createdAt.month - 1;
        if (m >= 0 && m < 12) {
          final txItems = await (select(transactionItems)..where((tbl) => tbl.transactionId.equals(tx.id))).get();
          for (final itm in txItems) {
            if (itm.itemType == 'product') {
              monthProd[m] += itm.subtotalPrice;
            } else {
              monthServ[m] += itm.subtotalPrice;
            }
          }
        }
      }

      int maxVal = 0;
      for (int i = 0; i < 12; i++) {
        final tot = monthProd[i] + monthServ[i];
        if (tot > maxVal) maxVal = tot;
      }
      if (maxVal <= 0) maxVal = 1;

      for (int i = 0; i < 12; i++) {
        final tot = monthProd[i] + monthServ[i];
        trendPoints.add(ChartDataPoint(
          label: months[i],
          value: tot,
          secondaryValue: monthServ[i],
          percentage: (tot / maxVal).clamp(0.0, 1.0),
        ));
      }
    } else {
      // 7 Days
      final dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
      final dayTotals = List<int>.filled(7, 0);

      for (int i = 6; i >= 0; i--) {
        final targetDate = endDate.subtract(Duration(days: i));
        final dayStart = DateTime(targetDate.year, targetDate.month, targetDate.day, 0, 0, 0);
        final dayEnd = DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59);

        int dayTot = 0;
        for (final tx in txList) {
          if (tx.createdAt.isAfter(dayStart) && tx.createdAt.isBefore(dayEnd)) {
            dayTot += tx.totalAmount;
          }
        }
        dayTotals[6 - i] = dayTot;
      }

      int maxVal = dayTotals.fold(0, (max, val) => val > max ? val : max);
      if (maxVal <= 0) maxVal = 1;

      for (int i = 6; i >= 0; i--) {
        final targetDate = endDate.subtract(Duration(days: i));
        final weekdayIndex = (targetDate.weekday - 1) % 7;
        final val = dayTotals[6 - i];

        trendPoints.add(ChartDataPoint(
          label: dayNames[weekdayIndex],
          value: val,
          percentage: (val / maxVal).clamp(0.0, 1.0),
          date: targetDate,
        ));
      }
    }

    return RevenueMixSummary(
      productRevenue: productRevenue,
      serviceRevenue: serviceRevenue,
      totalRevenue: totalRevenue,
      productRatio: productRatio,
      serviceRatio: serviceRatio,
      totalTransactionsCount: txList.length,
      trendPoints: trendPoints,
    );
  }

  /// Calculates top summary metrics and growth vs previous period
  Future<AnalyticsSummary> getOverallSummary({
    required DateTime startDate,
    required DateTime endDate,
    DateTime? previousStartDate,
    DateTime? previousEndDate,
    int? storeId,
  }) async {
    final curTxQuery = select(transactions)
      ..where((tbl) => tbl.createdAt.isBetweenValues(startDate, endDate));
    if (storeId != null) {
      curTxQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final currentTx = await curTxQuery.get();

    final curExpQuery = select(balanceLogs)
      ..where((tbl) =>
          tbl.createdAt.isBetweenValues(startDate, endDate) &
          tbl.flowType.equals('out'));
    if (storeId != null) {
      curExpQuery.where((tbl) => tbl.storeId.equals(storeId));
    }
    final currentExpenses = await curExpQuery.get();

    int grossRevenue = 0;
    int grossProfit = 0;
    for (final tx in currentTx) {
      grossRevenue += tx.totalAmount;
      grossProfit += tx.totalProfit;
    }

    int operationalExpense = 0;
    for (final exp in currentExpenses) {
      operationalExpense += exp.amount;
    }

    final netProfit = grossProfit - operationalExpense;

    // Previous period for growth comparison
    double growth = 0.0;
    if (previousStartDate != null && previousEndDate != null) {
      final prevTxQuery = select(transactions)
        ..where((tbl) => tbl.createdAt.isBetweenValues(previousStartDate, previousEndDate));
      if (storeId != null) {
        prevTxQuery.where((tbl) => tbl.storeId.equals(storeId));
      }
      final prevTx = await prevTxQuery.get();

      final prevExpQuery = select(balanceLogs)
        ..where((tbl) =>
            tbl.createdAt.isBetweenValues(previousStartDate, previousEndDate) &
            tbl.flowType.equals('out'));
      if (storeId != null) {
        prevExpQuery.where((tbl) => tbl.storeId.equals(storeId));
      }
      final prevExpenses = await prevExpQuery.get();

      int prevGrossProfit = 0;
      for (final tx in prevTx) {
        prevGrossProfit += tx.totalProfit;
      }
      int prevOperationalExpense = 0;
      for (final exp in prevExpenses) {
        prevOperationalExpense += exp.amount;
      }
      final prevNetProfit = prevGrossProfit - prevOperationalExpense;

      if (prevNetProfit > 0) {
        growth = ((netProfit - prevNetProfit) / prevNetProfit) * 100.0;
      } else if (netProfit > 0) {
        growth = 100.0;
      }
    }

    return AnalyticsSummary(
      netProfit: netProfit,
      grossProfit: grossProfit,
      grossRevenue: grossRevenue,
      operationalExpense: operationalExpense,
      profitGrowthPercentage: growth,
      totalSalesCount: currentTx.length,
    );
  }
}
