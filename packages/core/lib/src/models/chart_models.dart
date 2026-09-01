class ChartDataPoint {
  final String label;
  final int value;
  final int secondaryValue;
  final double percentage;
  final DateTime? date;

  const ChartDataPoint({
    required this.label,
    required this.value,
    this.secondaryValue = 0,
    this.percentage = 0.0,
    this.date,
  });
}

class StockMovementSummary {
  final int totalStockIn;
  final int totalStockSold;
  final double turnoverRate;
  final int totalRestockCost;

  const StockMovementSummary({
    required this.totalStockIn,
    required this.totalStockSold,
    required this.turnoverRate,
    required this.totalRestockCost,
  });
}

class RevenueMixSummary {
  final int productRevenue;
  final int serviceRevenue;
  final int totalRevenue;
  final double productRatio;
  final double serviceRatio;
  final int totalTransactionsCount;
  final List<ChartDataPoint> trendPoints;

  const RevenueMixSummary({
    required this.productRevenue,
    required this.serviceRevenue,
    required this.totalRevenue,
    required this.productRatio,
    required this.serviceRatio,
    required this.totalTransactionsCount,
    required this.trendPoints,
  });
}

class AnalyticsSummary {
  final int netProfit;
  final int grossProfit;
  final int grossRevenue;
  final int operationalExpense;
  final double profitGrowthPercentage;
  final int totalSalesCount;

  const AnalyticsSummary({
    required this.netProfit,
    required this.grossProfit,
    required this.grossRevenue,
    required this.operationalExpense,
    required this.profitGrowthPercentage,
    required this.totalSalesCount,
  });
}
