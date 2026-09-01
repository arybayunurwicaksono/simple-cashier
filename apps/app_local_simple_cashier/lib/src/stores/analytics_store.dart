// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'analytics_store.g.dart';

class AnalyticsStore = _AnalyticsStore with _$AnalyticsStore;

abstract class _AnalyticsStore with Store {
  final AnalyticsDao _analyticsDao;

  _AnalyticsStore(this._analyticsDao);

  @observable
  String timeFilter = 'yearly'; // 'yearly' | 'monthly' | 'weekly'

  @observable
  int selectedYear = DateTime.now().year;

  @observable
  int selectedMonth = DateTime.now().month;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  ObservableList<ChartDataPoint> profitTrend = ObservableList<ChartDataPoint>();

  @observable
  StockMovementSummary? stockMovement;

  @observable
  RevenueMixSummary? revenueMix;

  @observable
  AnalyticsSummary? overallSummary;

  @computed
  String get periodTitle {
    if (timeFilter == 'yearly') {
      return 'Tahun $selectedYear';
    } else if (timeFilter == 'monthly') {
      const monthNames = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];
      final mName = (selectedMonth >= 1 && selectedMonth <= 12)
          ? monthNames[selectedMonth - 1]
          : 'Bulan';
      return '$mName $selectedYear';
    } else {
      return '7 Hari Terakhir';
    }
  }

  @computed
  String get dateRangeSubtext {
    if (timeFilter == 'yearly') {
      return '01 Jan - 31 Des $selectedYear';
    } else if (timeFilter == 'monthly') {
      final lastDay = DateTime(selectedYear, selectedMonth + 1, 0).day;
      const shortMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      final m = shortMonths[selectedMonth - 1];
      return '01 - $lastDay $m $selectedYear';
    } else {
      final end = DateTime.now();
      final start = end.subtract(const Duration(days: 6));
      return '${start.day}/${start.month} - ${end.day}/${end.month}/${end.year}';
    }
  }

  @action
  Future<void> setTimeFilter(String filter) async {
    if (timeFilter != filter) {
      timeFilter = filter;
      await loadAnalytics();
    }
  }

  @action
  Future<void> setYear(int year) async {
    selectedYear = year;
    await loadAnalytics();
  }

  @action
  Future<void> nextPeriod() async {
    if (timeFilter == 'yearly') {
      selectedYear++;
    } else if (timeFilter == 'monthly') {
      if (selectedMonth == 12) {
        selectedMonth = 1;
        selectedYear++;
      } else {
        selectedMonth++;
      }
    }
    await loadAnalytics();
  }

  @action
  Future<void> previousPeriod() async {
    if (timeFilter == 'yearly') {
      selectedYear--;
    } else if (timeFilter == 'monthly') {
      if (selectedMonth == 1) {
        selectedMonth = 12;
        selectedYear--;
      } else {
        selectedMonth--;
      }
    }
    await loadAnalytics();
  }

  @action
  Future<void> loadAnalytics() async {
    isLoading = true;
    errorMessage = null;

    try {
      DateTime startDate;
      DateTime endDate;
      DateTime? prevStartDate;
      DateTime? prevEndDate;

      if (timeFilter == 'yearly') {
        startDate = DateTime(selectedYear, 1, 1, 0, 0, 0);
        endDate = DateTime(selectedYear, 12, 31, 23, 59, 59);
        prevStartDate = DateTime(selectedYear - 1, 1, 1, 0, 0, 0);
        prevEndDate = DateTime(selectedYear - 1, 12, 31, 23, 59, 59);
      } else if (timeFilter == 'monthly') {
        startDate = DateTime(selectedYear, selectedMonth, 1, 0, 0, 0);
        final lastDay = DateTime(selectedYear, selectedMonth + 1, 0).day;
        endDate = DateTime(selectedYear, selectedMonth, lastDay, 23, 59, 59);

        // Previous month
        final prevM = selectedMonth == 1 ? 12 : selectedMonth - 1;
        final prevY = selectedMonth == 1 ? selectedYear - 1 : selectedYear;
        prevStartDate = DateTime(prevY, prevM, 1, 0, 0, 0);
        final prevLastDay = DateTime(prevY, prevM + 1, 0).day;
        prevEndDate = DateTime(prevY, prevM, prevLastDay, 23, 59, 59);
      } else {
        // Weekly (7 days)
        final now = DateTime.now();
        endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
        startDate = DateTime(now.year, now.month, now.day, 0, 0, 0).subtract(const Duration(days: 6));

        prevEndDate = startDate.subtract(const Duration(seconds: 1));
        prevStartDate = prevEndDate.subtract(const Duration(days: 6));
      }

      // Parallel data fetching
      final results = await Future.wait([
        _analyticsDao.getProfitTrend(
          startDate: startDate,
          endDate: endDate,
          interval: timeFilter,
        ),
        _analyticsDao.getStockMovement(
          startDate: startDate,
          endDate: endDate,
        ),
        _analyticsDao.getRevenueMix(
          startDate: startDate,
          endDate: endDate,
          interval: timeFilter,
        ),
        _analyticsDao.getOverallSummary(
          startDate: startDate,
          endDate: endDate,
          previousStartDate: prevStartDate,
          previousEndDate: prevEndDate,
        ),
      ]);

      profitTrend = ObservableList.of(results[0] as List<ChartDataPoint>);
      stockMovement = results[1] as StockMovementSummary;
      revenueMix = results[2] as RevenueMixSummary;
      overallSummary = results[3] as AnalyticsSummary;
    } catch (e) {
      errorMessage = 'Gagal memuat analitik: $e';
    } finally {
      isLoading = false;
    }
  }
}
