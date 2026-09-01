import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/balance_store.dart';
import 'balance_log_dialog.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final _balanceStore = getIt<BalanceStore>();

  @override
  void initState() {
    super.initState();
    _balanceStore.loadBalances();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arus Kas & Saldo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _balanceStore.loadBalances(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Catat Kas'),
        onPressed: () {
          BalanceLogDialog.show(context, onSuccess: () => _balanceStore.loadBalances());
        },
      ),
      body: Observer(
        builder: (_) {
          if (_balanceStore.isLoading && _balanceStore.balanceLogs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 80),
            children: [
              // Summary Row Cards
              Row(
                children: [
                  Expanded(
                    child: StatSummaryCard(
                      title: 'Saldo Tunai',
                      amount: _balanceStore.cashBalance,
                      icon: Icons.payments_outlined,
                      iconColor: isDark ? const Color(0xFF34D399) : AppColors.secondaryDark,
                      backgroundColor: const Color(0xFFD1FAE5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatSummaryCard(
                      title: 'Saldo Digital/QRIS',
                      amount: _balanceStore.digitalBalance,
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: isDark ? const Color(0xFF60A5FA) : AppColors.primary,
                      backgroundColor: const Color(0xFFDBEAFE),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Total Combined Card
              StatSummaryCard(
                title: 'Total Seluruh Saldo Kas',
                amount: _balanceStore.totalBalance,
                icon: Icons.savings_outlined,
                iconColor: isDark ? const Color(0xFF38BDF8) : AppColors.primaryLight,
                backgroundColor: const Color(0xFFE0F2FE),
              ),
              const SizedBox(height: 18),

              Text(
                'Riwayat Pemasukan & Pengeluaran',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),

              if (_balanceStore.balanceLogs.isEmpty)
                const EmptyStateView(
                  title: 'Belum Ada Catatan Kas',
                  message: 'Tekan tombol di bawah untuk mencatat modal, operasional, atau penarikan',
                  icon: Icons.account_balance_outlined,
                )
              else
                ..._balanceStore.balanceLogs.map((log) {
                  final isIn = log.flowType == 'in';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isIn
                                ? (isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7))
                                : (isDark ? const Color(0xFF450A0A) : const Color(0xFFFEE2E2)),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isIn ? Icons.arrow_downward : Icons.arrow_upward,
                            color: isIn ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                log.notes ?? log.category.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${DateFormatter.formatFull(log.createdAt)} • ${log.paymentType.toUpperCase()}',
                                style: TextStyle(fontSize: 10, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        CurrencyText(
                          amount: log.amount,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isIn ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                          ),
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
