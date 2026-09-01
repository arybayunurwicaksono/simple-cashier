import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/analytics_store.dart';
import '../../stores/auth_store.dart';
import '../widgets/app_end_drawer.dart';
import 'analytics_filter_dialog.dart';

class AnalyticsScreen extends StatefulWidget {
  final VoidCallback? onOpenEndDrawer;

  const AnalyticsScreen({
    super.key,
    this.onOpenEndDrawer,
  });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final _analyticsStore = getIt<AnalyticsStore>();
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _analyticsStore.loadAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      endDrawer: const AppEndDrawer(),
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analisis Bisnis',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Observer(
              builder: (_) => Text(
                'Periode: ${_analyticsStore.periodTitle} (${_analyticsStore.dateRangeSubtext})',
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Segarkan Data',
            onPressed: () => _analyticsStore.loadAnalytics(),
          ),
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu_rounded),
              tooltip: 'Buka Menu',
              onPressed: () {
                if (widget.onOpenEndDrawer != null) {
                  widget.onOpenEndDrawer!();
                } else {
                  Scaffold.of(ctx).openEndDrawer();
                }
              },
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_analyticsStore.isLoading && _analyticsStore.overallSummary == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final summary = _analyticsStore.overallSummary;
          final stock = _analyticsStore.stockMovement;
          final revMix = _analyticsStore.revenueMix;

          return RefreshIndicator(
            onRefresh: () => _analyticsStore.loadAnalytics(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Time Filter Chip Bar with Left Filter Dialog Icon
                  TimeFilterChipBar(
                    selectedFilter: _analyticsStore.timeFilter,
                    onFilterChanged: (filter) => _analyticsStore.setTimeFilter(filter),
                    onFilterTap: () => AnalyticsFilterDialog.show(context, _analyticsStore),
                  ),

                  const SizedBox(height: 14),

                  // 2. Hero Executive Summary Banner
                  _buildExecutiveSummaryBanner(context, summary, isDark),

                  const SizedBox(height: 16),

                  // 3. Chart 1: Capsule Bar Chart (Laba Bersih & Keuntungan)
                  CapsuleBarChart(
                    title: 'Statistik Keuntungan (Laba Bersih)',
                    subtitle: 'Total laba bersih setelah beban operasional',
                    badgeLabel: _analyticsStore.periodTitle,
                    dataPoints: _analyticsStore.profitTrend,
                  ),

                  const SizedBox(height: 16),

                  // 4. Chart 2: Donut Ring Chart (Stok Masuk vs Terjual)
                  if (stock != null)
                    CircularDonutChart(
                      title: 'Perputaran Stok Barang',
                      subtitle: _analyticsStore.dateRangeSubtext,
                      totalSold: stock.totalStockSold,
                      totalIncoming: stock.totalStockIn,
                      percentage: stock.turnoverRate,
                      primaryColor: AppColors.accentBlue,
                      secondaryColor: AppColors.accentOrange,
                    ),

                  const SizedBox(height: 16),

                  // 5. Chart 3: Spline Area Chart (Omset Uang Masuk: Produk vs Jasa)
                  if (revMix != null)
                    SplineAreaChart(
                      title: 'Omset Penjualan (Uang Masuk)',
                      subtitle: 'Komparasi sumber pendapatan Produk vs Jasa',
                      totalRevenue: revMix.totalRevenue,
                      productRevenue: revMix.productRevenue,
                      serviceRevenue: revMix.serviceRevenue,
                      growthPercentage: summary?.profitGrowthPercentage ?? 0.0,
                      trendPoints: revMix.trendPoints,
                    ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExecutiveSummaryBanner(
    BuildContext context,
    AnalyticsSummary? summary,
    bool isDark,
  ) {
    final netProfit = summary?.netProfit ?? 0;
    final grossRevenue = summary?.grossRevenue ?? 0;
    final growth = summary?.profitGrowthPercentage ?? 0.0;
    final totalSales = summary?.totalSalesCount ?? 0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.primaryContainerDark,
                  AppColors.backgroundDark,
                  AppColors.surfaceDark,
                ]
              : [
                  AppColors.primary,
                  const Color(0xFF2563EB),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: isDark ? 0.45 : 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row inside banner
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.auto_graph_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Performa Keuangan Toko',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: growth >= 0
                      ? AppColors.accentGreen.withValues(alpha: 0.25)
                      : AppColors.accentRed.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: growth >= 0 ? AppColors.accentGreenLight : AppColors.accentRedLight,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      growth >= 0 ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      size: 13,
                      color: growth >= 0 ? AppColors.accentGreenLight : AppColors.accentRedLight,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${growth >= 0 ? "+" : ""}${growth.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: growth >= 0 ? AppColors.accentGreenLight : AppColors.accentRedLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Main Metric Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Laba Bersih',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        CurrencyFormatter.format(netProfit),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 38,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Omset Masuk',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        CurrencyFormatter.format(grossRevenue),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF93C5FD),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: Colors.white.withValues(alpha: 0.15), height: 1),
          const SizedBox(height: 10),

          // Bottom Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Total: $totalSales penjualan',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Kasir: ${_authStore.currentUser?.fullname ?? "Owner"}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBAE6FD),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
