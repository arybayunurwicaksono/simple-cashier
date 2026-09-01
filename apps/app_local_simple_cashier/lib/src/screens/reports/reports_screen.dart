import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/accounting_store.dart';
import '../../stores/auth_store.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _accountingStore = getIt<AccountingStore>();
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _accountingStore.loadLedgers();
  }

  Future<void> _handleCloseMonth() async {
    final period = DateFormatter.formatPeriod(DateTime.now());
    final userId = _authStore.currentUser?.id ?? 1;

    ConfirmationDialog.show(
      context,
      title: 'Tutup Buku Bulan Ini?',
      message: 'Semua rekapitulasi penjualan, jasa, pengeluaran, dan sisa aset stok akan dibukukan secara permanen untuk periode $period.',
      confirmText: 'Ya, Tutup Buku',
      onConfirm: () async {
        final success = await _accountingStore.closeMonthlyLedger(
          period: period,
          initialCash: _accountingStore.currentCash,
          initialDigital: _accountingStore.currentDigital,
          initialStockValue: _accountingStore.currentStockValue,
          closedByUserId: userId,
        );

        if (!mounted) return;

        if (success) {
          AppNotification.showSuccess(
            context,
            'Buku periode $period berhasil ditutup',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPeriod = DateFormatter.formatPeriod(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan & Pembukuan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _accountingStore.loadLedgers(),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_accountingStore.isLoading && _accountingStore.monthlyLedgers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            children: [
              // Realtime Current Month Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Periode: $currentPeriod',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'LIVE REKAP',
                            style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
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
                              const Text('Total Omzet Penjualan', style: TextStyle(color: Colors.white70, fontSize: 10)),
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
                              const Text('Estimasi Laba Bersih', style: TextStyle(color: Colors.white70, fontSize: 10)),
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

              // Detail Statistics Grid
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
                      iconColor: AppColors.primary,
                      backgroundColor: AppColors.primaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              const Text(
                'Arsip Laporan Bulanan (PDF)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 8),

              if (_accountingStore.monthlyLedgers.isEmpty)
                const EmptyStateView(
                  title: 'Belum Ada Arsip Buku',
                  message: 'Tekan tombol "Tutup Buku Periode Ini" di atas untuk membuat arsip laporan bulanan resmi',
                  icon: Icons.picture_as_pdf_outlined,
                )
              else
                ..._accountingStore.monthlyLedgers.map((ledger) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.picture_as_pdf, color: AppColors.error, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Laporan ${ledger.periodMonthYear}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Laba: ${CurrencyFormatter.format(ledger.netProfit)}',
                                style: const TextStyle(fontSize: 11, color: AppColors.secondaryDark, fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share_outlined, color: AppColors.primary, size: 20),
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
      ),
    );
  }
}
