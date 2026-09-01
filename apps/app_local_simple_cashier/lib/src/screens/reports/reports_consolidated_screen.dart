import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/accounting_store.dart';
import '../../stores/balance_store.dart';
import '../../stores/auth_store.dart';
import '../transactions/transaction_list_screen.dart';
import '../balance/balance_screen.dart';
import '../widgets/app_end_drawer.dart';

class ReportsConsolidatedScreen extends StatefulWidget {
  final VoidCallback? onOpenEndDrawer;

  const ReportsConsolidatedScreen({
    super.key,
    this.onOpenEndDrawer,
  });

  @override
  State<ReportsConsolidatedScreen> createState() => _ReportsConsolidatedScreenState();
}

class _ReportsConsolidatedScreenState extends State<ReportsConsolidatedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _accountingStore = getIt<AccountingStore>();
  final _balanceStore = getIt<BalanceStore>();
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _accountingStore.loadLedgers();
    _balanceStore.loadBalances();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleCloseMonth() async {
    final now = DateTime.now();
    final period = DateFormatter.formatPeriod(now);

    ConfirmationDialog.show(
      context,
      title: 'Tutup Buku $period?',
      message:
          'Proses ini akan mengunci seluruh pendapatan & beban periode $period ke arsip pembukuan permanen.',
      onConfirm: () async {
        final success = await _accountingStore.closeMonthlyLedger(
          period: period,
          initialCash: _accountingStore.currentCash,
          initialDigital: _accountingStore.currentDigital,
          initialStockValue: _accountingStore.currentStockValue,
          closedByUserId: _authStore.currentUser?.id ?? 1,
        );

        if (!mounted) return;

        if (success) {
          AppNotification.showSuccess(
            context,
            'Tutup buku periode $period berhasil disimpan!',
          );
        } else {
          AppNotification.showError(
            context,
            _accountingStore.errorMessage ?? 'Gagal tutup buku',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      endDrawer: const AppEndDrawer(),
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Laporan & Keuangan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Pembukuan, riwayat transaksi & arus kas',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Segarkan Data',
            onPressed: () {
              _accountingStore.loadLedgers();
              _balanceStore.loadBalances();
            },
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryAccent(context),
          labelColor: AppColors.primaryAccent(context),
          unselectedLabelColor: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
          tabs: const [
            Tab(icon: Icon(Icons.auto_graph_rounded, size: 18), text: 'Pembukuan'),
            Tab(icon: Icon(Icons.receipt_long_rounded, size: 18), text: 'Transaksi'),
            Tab(icon: Icon(Icons.account_balance_wallet_rounded, size: 18), text: 'Arus Kas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAccountingTab(),
          const TransactionListScreen(),
          const BalanceScreen(),
        ],
      ),
    );
  }

  Widget _buildAccountingTab() {
    if (!_authStore.isOwner) {
      return const EmptyStateView(
        title: 'Akses Pembukuan Terkunci',
        message: 'Hanya akun Pemilik Toko (Owner) yang berhak melihat pembukuan laba rugi, nilai aset stok, dan melakukan tutup buku bulanan.',
        icon: Icons.lock_outline_rounded,
      );
    }

    final currentPeriod = DateFormatter.formatPeriod(DateTime.now());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Observer(
      builder: (_) {
        if (_accountingStore.isLoading && _accountingStore.monthlyLedgers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          children: [
            // Live Auto-Rekap Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.25),
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
                      Expanded(
                        child: Text(
                          'Periode Berjalan: $currentPeriod',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'LIVE REKAP',
                          style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total Omzet Penjualan', style: TextStyle(color: Colors.white70, fontSize: 10.5)),
                            CurrencyText(
                              amount: _accountingStore.currentTotalIncome,
                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Estimasi Laba Bersih', style: TextStyle(color: Colors.white70, fontSize: 10.5)),
                            CurrencyText(
                              amount: _accountingStore.currentNetProfit,
                              style: const TextStyle(color: AppColors.secondaryContainer, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Tutup Buku Periode Ini',
                    variant: AppButtonVariant.secondary,
                    width: double.infinity,
                    height: 38,
                    icon: Icons.lock_clock_outlined,
                    onPressed: _handleCloseMonth,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 2-Column Stats
            Row(
              children: [
                Expanded(
                  child: StatSummaryCard(
                    title: 'Omzet Barang',
                    amount: _accountingStore.currentIncomeGoods,
                    icon: Icons.inventory_2_outlined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatSummaryCard(
                    title: 'Omzet Jasa',
                    amount: _accountingStore.currentIncomeServices,
                    icon: Icons.build_circle_outlined,
                    iconColor: const Color(0xFF0284C7),
                    backgroundColor: const Color(0xFFE0F2FE),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: StatSummaryCard(
                    title: 'Total Beban Biaya',
                    amount: _accountingStore.currentTotalExpense,
                    icon: Icons.trending_down_outlined,
                    iconColor: AppColors.error,
                    backgroundColor: const Color(0xFFFEE2E2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatSummaryCard(
                    title: 'Nilai Aset Stok',
                    amount: _accountingStore.currentStockValue,
                    icon: Icons.warehouse_outlined,
                    iconColor: isDark ? const Color(0xFF60A5FA) : AppColors.primary,
                    backgroundColor: const Color(0xFFDBEAFE),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            Text(
              'Arsip Laporan Bulanan (PDF)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),

            if (_accountingStore.monthlyLedgers.isEmpty)
              const EmptyStateView(
                title: 'Belum Ada Arsip Buku',
                message: 'Tekan tombol "Tutup Buku Periode Ini" di atas untuk membuat dokumen arsip bulanan resmi',
                icon: Icons.picture_as_pdf_outlined,
              )
            else
              ..._accountingStore.monthlyLedgers.map((ledger) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF450A0A) : const Color(0xFFFEE2E8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.picture_as_pdf, color: isDark ? const Color(0xFFF87171) : AppColors.error, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Laporan ${ledger.periodMonthYear}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Laba: ${CurrencyFormatter.format(ledger.netProfit)}',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? const Color(0xFF34D399) : AppColors.secondaryDark,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.share_outlined, color: isDark ? const Color(0xFF60A5FA) : AppColors.primary, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                        onPressed: () {
                          _accountingStore.exportAndShareMonthlyReportPdf(
                            ledger: ledger,
                            generatedBy: _authStore.currentUser?.fullname ?? 'Owner',
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}
