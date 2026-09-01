// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'accounting_store.g.dart';

class AccountingStore = _AccountingStore with _$AccountingStore;

abstract class _AccountingStore with Store {
  final AccountingDao _accountingDao;
  final ProductDao _productDao;
  final BalanceDao _balanceDao;
  final StoreProfileDao _storeProfileDao;
  final TransactionDao _transactionDao;

  _AccountingStore({
    required AccountingDao accountingDao,
    required ProductDao productDao,
    required BalanceDao balanceDao,
    required StoreProfileDao storeProfileDao,
    required TransactionDao transactionDao,
  })  : _accountingDao = accountingDao,
        _productDao = productDao,
        _balanceDao = balanceDao,
        _storeProfileDao = storeProfileDao,
        _transactionDao = transactionDao;

  @observable
  ObservableList<MonthlyAccountingData> monthlyLedgers = ObservableList<MonthlyAccountingData>();

  @observable
  MonthlyAccountingData? currentPeriodLedger;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  // Realtime calculated preview for current period (Month)
  @observable
  int currentIncomeGoods = 0;

  @observable
  int currentIncomeServices = 0;

  @observable
  int currentTotalExpense = 0;

  @observable
  int currentNetProfit = 0;

  @observable
  int currentCash = 0;

  @observable
  int currentDigital = 0;

  @observable
  int currentStockValue = 0;

  // Today's metrics (Home Dashboard)
  @observable
  int todayTotalIncome = 0;

  @observable
  int todayNetProfit = 0;

  @observable
  int todayTotalExpense = 0;

  @observable
  int todayCashBalance = 0;

  @observable
  int todayDigitalBalance = 0;

  @observable
  int todayTransactionCount = 0;

  @observable
  int todaySoldItemsCount = 0;

  @observable
  ObservableList<TransactionData> recentTransactions = ObservableList<TransactionData>();

  @computed
  int get currentTotalIncome => currentIncomeGoods + currentIncomeServices;

  @computed
  int get todayTotalBalance => todayCashBalance + todayDigitalBalance;

  @action
  Future<void> loadTodayDashboardMetrics() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final agg = await _accountingDao.calculatePeriodAggregation(
        startDate: startOfDay,
        endDate: endOfDay,
      );

      todayTotalIncome = agg['totalIncome'] ?? 0;
      todayTotalExpense = agg['totalExpense'] ?? 0;
      todayNetProfit = agg['netProfit'] ?? 0;
      todayTransactionCount = agg['txCount'] ?? 0;
      todaySoldItemsCount = agg['itemCount'] ?? 0;

      todayCashBalance = await _balanceDao.getCashBalance();
      todayDigitalBalance = await _balanceDao.getDigitalBalance();

      final allTx = await _transactionDao.getAllTransactions();
      recentTransactions = ObservableList.of(allTx.take(5));
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> loadLedgers() async {
    isLoading = true;
    try {
      final list = await _accountingDao.getAllMonthlyLedgers();
      monthlyLedgers = ObservableList.of(list);

      final currentPeriod = DateFormatter.formatPeriod(DateTime.now());
      currentPeriodLedger = await _accountingDao.getLedgerByPeriod(currentPeriod);

      await calculateCurrentMonthLivePreview();
      await loadTodayDashboardMetrics();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> calculateCurrentMonthLivePreview() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final agg = await _accountingDao.calculatePeriodAggregation(
      startDate: startOfMonth,
      endDate: endOfMonth,
    );

    currentIncomeGoods = agg['incomeGoods'] ?? 0;
    currentIncomeServices = agg['incomeServices'] ?? 0;
    currentTotalExpense = agg['totalExpense'] ?? 0;
    currentNetProfit = agg['netProfit'] ?? 0;

    currentCash = await _balanceDao.getCashBalance();
    currentDigital = await _balanceDao.getDigitalBalance();
    currentStockValue = await _productDao.getTotalStockWorth();
  }

  @action
  Future<bool> closeMonthlyLedger({
    required String period,
    required int initialCash,
    required int initialDigital,
    required int initialStockValue,
    required int closedByUserId,
  }) async {
    isLoading = true;
    try {
      await calculateCurrentMonthLivePreview();

      await _accountingDao.insertOrUpdateLedger(
        MonthlyAccountingCompanion(
          periodMonthYear: Value(period),
          initialCash: Value(initialCash),
          initialDigital: Value(initialDigital),
          initialStockValue: Value(initialStockValue),
          incomeGoods: Value(currentIncomeGoods),
          incomeServices: Value(currentIncomeServices),
          totalExpense: Value(currentTotalExpense),
          netProfit: Value(currentNetProfit),
          finalCash: Value(currentCash),
          finalDigital: Value(currentDigital),
          finalStockValue: Value(currentStockValue),
          status: const Value('closed'),
          closedByUserId: Value(closedByUserId),
          closedAt: Value(DateTime.now()),
        ),
      );

      await loadLedgers();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> exportAndShareMonthlyReportPdf({
    required MonthlyAccountingData ledger,
    required String generatedBy,
  }) async {
    isLoading = true;
    try {
      final store = await _storeProfileDao.getStoreProfile();

      final pdfBytes = await PdfReportService.generateMonthlyReportPdf(
        storeName: store?.storeName ?? 'Simple Cashier Store',
        storeAddress: store?.address ?? '',
        storePhone: store?.phone ?? '',
        period: ledger.periodMonthYear,
        generatedBy: generatedBy,
        initialCash: ledger.initialCash,
        initialDigital: ledger.initialDigital,
        initialStockValue: ledger.initialStockValue,
        incomeGoods: ledger.incomeGoods,
        incomeServices: ledger.incomeServices,
        totalExpense: ledger.totalExpense,
        netProfit: ledger.netProfit,
        finalCash: ledger.finalCash,
        finalDigital: ledger.finalDigital,
        finalStockValue: ledger.finalStockValue,
      );

      await ShareService.sharePdfBytes(
        pdfBytes: pdfBytes,
        filename: 'Laporan_Keuangan_${ledger.periodMonthYear.replaceAll(' ', '_')}.pdf',
        subject: 'Laporan Keuangan ${ledger.periodMonthYear} - ${store?.storeName}',
      );
    } catch (e) {
      errorMessage = 'Gagal mengekspor PDF: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }
}
