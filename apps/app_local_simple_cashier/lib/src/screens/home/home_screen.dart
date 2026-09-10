import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/accounting_store.dart';
import '../../stores/auth_store.dart';
import '../../stores/settings_store.dart';
import '../../stores/store_store.dart';
import '../catalog/product_form_screen.dart';
import '../balance/balance_log_dialog.dart';
import '../transactions/transaction_detail_screen.dart';

import '../widgets/app_end_drawer.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onStartNewTransaction;
  final ValueChanged<int> onNavigateTab;
  final VoidCallback? onOpenEndDrawer;

  const HomeScreen({
    super.key,
    required this.onStartNewTransaction,
    required this.onNavigateTab,
    this.onOpenEndDrawer,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _accountingStore = getIt<AccountingStore>();
  final _authStore = getIt<AuthStore>();
  final _settingsStore = getIt<SettingsStore>();
  final _analyticsDao = getIt<AnalyticsDao>();

  RevenueMixSummary? _weeklyRevenueMix;
  double _weeklyGrowthPercentage = 0.0;
  bool _isLoadingRevenue = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await Future.wait([
      _settingsStore.loadSettings(),
      _accountingStore.loadLedgers(),
      _loadWeeklyRevenue(),
    ]);
  }

  Future<void> _loadWeeklyRevenue() async {
    try {
      final now = DateTime.now();
      final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
      final startDate = DateTime(now.year, now.month, now.day, 0, 0, 0).subtract(const Duration(days: 6));
      final prevEndDate = startDate.subtract(const Duration(seconds: 1));
      final prevStartDate = prevEndDate.subtract(const Duration(days: 6));

      final results = await Future.wait([
        _analyticsDao.getRevenueMix(
          startDate: startDate,
          endDate: endDate,
          interval: 'weekly',
        ),
        _analyticsDao.getOverallSummary(
          startDate: startDate,
          endDate: endDate,
          previousStartDate: prevStartDate,
          previousEndDate: prevEndDate,
        ),
      ]);

      if (mounted) {
        setState(() {
          _weeklyRevenueMix = results[0] as RevenueMixSummary;
          _weeklyGrowthPercentage = (results[1] as AnalyticsSummary).profitGrowthPercentage;
          _isLoadingRevenue = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingRevenue = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final todayFormatted = DateFormatter.formatFull(DateTime.now());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      endDrawer: const AppEndDrawer(),
      appBar: AppBar(
        titleSpacing: 16,
        title: Observer(
          builder: (_) {
            final activeStore = getIt<StoreStore>().activeStore;
            final user = _authStore.currentUser;
            final store = _settingsStore.storeProfile;
            final storeName = activeStore?.storeName ??
                ((store != null && store.storeName.trim().isNotEmpty)
                    ? store.storeName.trim()
                    : 'Simple Cashier');
            final cashierName = (activeStore != null && activeStore.ownerName.trim().isNotEmpty)
                ? activeStore.ownerName.trim()
                : ((user != null && user.fullname.trim().isNotEmpty)
                    ? user.fullname.trim()
                    : 'Pemilik Toko');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  storeName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Kasir: $cashierName • $todayFormatted',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Segarkan Data',
            onPressed: _refreshData,
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
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              children: [
                // Ringkasan Hari Ini Title
                Row(
                  children: [
                    Icon(
                      _authStore.isOwner ? Icons.insights_rounded : Icons.point_of_sale_rounded,
                      size: 18,
                      color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _authStore.isOwner
                          ? 'Ringkasan Finansial Hari Ini'
                          : 'Ringkasan Operasional Kasir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // 2x2 Grid of Modern Gradient Cards (Role Gated)
                if (_authStore.isOwner) ...[
                  Row(
                    children: [
                      Expanded(
                        child: ModernStatGradientCard(
                          title: 'Penjualan Hari Ini',
                          amount: _accountingStore.todayTotalIncome,
                          icon: Icons.trending_up_rounded,
                          gradientColors: const [Color(0xFF059669), Color(0xFF10B981)],
                          subtitle: 'Omzet kotor hari ini',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ModernStatGradientCard(
                          title: 'Keuntungan Hari Ini',
                          amount: _accountingStore.todayNetProfit,
                          icon: Icons.monetization_on_rounded,
                          gradientColors: const [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                          subtitle: 'Estimasi laba bersih',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ModernStatGradientCard(
                          title: 'Saldo Kas Hari Ini',
                          amount: _accountingStore.todayTotalBalance,
                          icon: Icons.account_balance_wallet_rounded,
                          gradientColors: const [Color(0xFF4338CA), Color(0xFF6366F1)],
                          subtitle: 'Tunai + Digital QRIS',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ModernStatGradientCard(
                          title: 'Beban Hari Ini',
                          amount: _accountingStore.todayTotalExpense,
                          icon: Icons.trending_down_rounded,
                          gradientColors: const [Color(0xFFBE123C), Color(0xFFF43F5E)],
                          subtitle: 'Pengeluaran kas',
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Cashier Role View (Hides profit & expenses, shows operational stats)
                  Row(
                    children: [
                      Expanded(
                        child: ModernStatGradientCard(
                          title: 'Penjualan Hari Ini',
                          amount: _accountingStore.todayTotalIncome,
                          icon: Icons.trending_up_rounded,
                          gradientColors: const [Color(0xFF059669), Color(0xFF10B981)],
                          subtitle: 'Omzet penjualan hari ini',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ModernStatGradientCard(
                          title: 'Kas Tunai di Laci',
                          amount: _accountingStore.todayCashBalance,
                          icon: Icons.account_balance_wallet_rounded,
                          gradientColors: const [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                          subtitle: 'Saldo kas fisik',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => widget.onNavigateTab(3),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4338CA), Color(0xFF6366F1)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4338CA).withValues(alpha: 0.28),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Transaksi', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.22),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.receipt_long_rounded, size: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${_accountingStore.todayTransactionCount} Nota',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text('Berhasil diproses', style: TextStyle(fontSize: 10.5, color: Colors.white.withValues(alpha: 0.85))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD97706).withValues(alpha: 0.28),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Item Terjual', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.22),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.shopping_bag_rounded, size: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_accountingStore.todaySoldItemsCount} Item',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text('Total barang & jasa', style: TextStyle(fontSize: 10.5, color: Colors.white.withValues(alpha: 0.85))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 18),

                // Title: Grafik Penjualan Minggu Ini
                Row(
                  children: [
                    Icon(
                      Icons.auto_graph_rounded,
                      size: 18,
                      color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Grafik Penjualan Minggu ini',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // 7-day Sales Revenue Mix Chart
                if (_weeklyRevenueMix != null)
                  SplineAreaChart(
                    showHeader: false,
                    totalRevenue: _weeklyRevenueMix!.totalRevenue,
                    productRevenue: _weeklyRevenueMix!.productRevenue,
                    serviceRevenue: _weeklyRevenueMix!.serviceRevenue,
                    growthPercentage: _weeklyGrowthPercentage,
                    trendPoints: _weeklyRevenueMix!.trendPoints,
                  )
                else if (_isLoadingRevenue)
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.chartCard(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.chartBorder(context),
                        width: 1.2,
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  const SplineAreaChart(
                    showHeader: false,
                    totalRevenue: 0,
                    productRevenue: 0,
                    serviceRevenue: 0,
                    growthPercentage: 0.0,
                    trendPoints: [],
                  ),
                const SizedBox(height: 18),

                // Quick Action Shortcuts
                Text(
                  'Aksi Cepat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (_authStore.isOwner)
                      Expanded(
                        child: _buildQuickActionButton(
                          context: context,
                          icon: Icons.add_circle_outline_rounded,
                          label: 'Tambah Barang',
                          color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const ProductFormScreen()),
                            );
                          },
                        ),
                      )
                    else
                      Expanded(
                        child: _buildQuickActionButton(
                          context: context,
                          icon: Icons.point_of_sale_rounded,
                          label: 'Kasir POS',
                          color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
                          onTap: widget.onStartNewTransaction,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildQuickActionButton(
                        context: context,
                        icon: Icons.account_balance_rounded,
                        label: 'Catat Arus Kas',
                        color: const Color(0xFF10B981),
                        onTap: () {
                          BalanceLogDialog.show(context, onSuccess: () => _refreshData());
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildQuickActionButton(
                        context: context,
                        icon: _authStore.isOwner ? Icons.summarize_rounded : Icons.history_rounded,
                        label: _authStore.isOwner ? 'Buka Laporan' : 'Riwayat Nota',
                        color: const Color(0xFFF59E0B),
                        onTap: () => widget.onNavigateTab(3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Live Feed: Penjualan Terakhir / Transaksi Terbaru
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history_rounded, size: 18, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A)),
                        const SizedBox(width: 6),
                        Text(
                          'Penjualan Terakhir',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => widget.onNavigateTab(3), // Navigate to Laporan & Transaksi
                      child: const Text('Lihat Semua', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                if (_accountingStore.recentTransactions.isEmpty)
                  const EmptyStateView(
                    title: 'Belum Ada Transaksi Hari Ini',
                    message: 'Mulai transaksi kasir pertama Anda dengan menekan tombol Transaksi Baru',
                    icon: Icons.receipt_long_rounded,
                  )
                else
                  ..._accountingStore.recentTransactions.map((tx) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                      ),
                      child: ListTile(
                        dense: true,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TransactionDetailScreen(transactionId: tx.id),
                            ),
                          );
                        },
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF0F172A) : const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.receipt_rounded, color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A), size: 20),
                        ),
                        title: Text(
                          tx.invoiceNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                          ),
                        ),
                        subtitle: Text(
                          '${DateFormatter.formatFull(tx.createdAt)} • ${tx.paymentMethod.toUpperCase()}',
                          style: TextStyle(fontSize: 10.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                        ),
                        trailing: CurrencyText(
                          amount: tx.totalAmount,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E3A8A),
                          ),
                        ),
                      ),
                    );
                  }),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
