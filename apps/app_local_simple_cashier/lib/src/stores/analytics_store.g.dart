// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnalyticsStore on _AnalyticsStore, Store {
  Computed<String>? _$periodTitleComputed;

  @override
  String get periodTitle =>
      (_$periodTitleComputed ??= Computed<String>(() => super.periodTitle,
              name: '_AnalyticsStore.periodTitle'))
          .value;
  Computed<String>? _$dateRangeSubtextComputed;

  @override
  String get dateRangeSubtext => (_$dateRangeSubtextComputed ??=
          Computed<String>(() => super.dateRangeSubtext,
              name: '_AnalyticsStore.dateRangeSubtext'))
      .value;

  late final _$timeFilterAtom =
      Atom(name: '_AnalyticsStore.timeFilter', context: context);

  @override
  String get timeFilter {
    _$timeFilterAtom.reportRead();
    return super.timeFilter;
  }

  @override
  set timeFilter(String value) {
    _$timeFilterAtom.reportWrite(value, super.timeFilter, () {
      super.timeFilter = value;
    });
  }

  late final _$selectedYearAtom =
      Atom(name: '_AnalyticsStore.selectedYear', context: context);

  @override
  int get selectedYear {
    _$selectedYearAtom.reportRead();
    return super.selectedYear;
  }

  @override
  set selectedYear(int value) {
    _$selectedYearAtom.reportWrite(value, super.selectedYear, () {
      super.selectedYear = value;
    });
  }

  late final _$selectedMonthAtom =
      Atom(name: '_AnalyticsStore.selectedMonth', context: context);

  @override
  int get selectedMonth {
    _$selectedMonthAtom.reportRead();
    return super.selectedMonth;
  }

  @override
  set selectedMonth(int value) {
    _$selectedMonthAtom.reportWrite(value, super.selectedMonth, () {
      super.selectedMonth = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AnalyticsStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AnalyticsStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$profitTrendAtom =
      Atom(name: '_AnalyticsStore.profitTrend', context: context);

  @override
  ObservableList<ChartDataPoint> get profitTrend {
    _$profitTrendAtom.reportRead();
    return super.profitTrend;
  }

  @override
  set profitTrend(ObservableList<ChartDataPoint> value) {
    _$profitTrendAtom.reportWrite(value, super.profitTrend, () {
      super.profitTrend = value;
    });
  }

  late final _$stockMovementAtom =
      Atom(name: '_AnalyticsStore.stockMovement', context: context);

  @override
  StockMovementSummary? get stockMovement {
    _$stockMovementAtom.reportRead();
    return super.stockMovement;
  }

  @override
  set stockMovement(StockMovementSummary? value) {
    _$stockMovementAtom.reportWrite(value, super.stockMovement, () {
      super.stockMovement = value;
    });
  }

  late final _$revenueMixAtom =
      Atom(name: '_AnalyticsStore.revenueMix', context: context);

  @override
  RevenueMixSummary? get revenueMix {
    _$revenueMixAtom.reportRead();
    return super.revenueMix;
  }

  @override
  set revenueMix(RevenueMixSummary? value) {
    _$revenueMixAtom.reportWrite(value, super.revenueMix, () {
      super.revenueMix = value;
    });
  }

  late final _$overallSummaryAtom =
      Atom(name: '_AnalyticsStore.overallSummary', context: context);

  @override
  AnalyticsSummary? get overallSummary {
    _$overallSummaryAtom.reportRead();
    return super.overallSummary;
  }

  @override
  set overallSummary(AnalyticsSummary? value) {
    _$overallSummaryAtom.reportWrite(value, super.overallSummary, () {
      super.overallSummary = value;
    });
  }

  late final _$setTimeFilterAsyncAction =
      AsyncAction('_AnalyticsStore.setTimeFilter', context: context);

  @override
  Future<void> setTimeFilter(String filter) {
    return _$setTimeFilterAsyncAction.run(() => super.setTimeFilter(filter));
  }

  late final _$setYearAsyncAction =
      AsyncAction('_AnalyticsStore.setYear', context: context);

  @override
  Future<void> setYear(int year) {
    return _$setYearAsyncAction.run(() => super.setYear(year));
  }

  late final _$nextPeriodAsyncAction =
      AsyncAction('_AnalyticsStore.nextPeriod', context: context);

  @override
  Future<void> nextPeriod() {
    return _$nextPeriodAsyncAction.run(() => super.nextPeriod());
  }

  late final _$previousPeriodAsyncAction =
      AsyncAction('_AnalyticsStore.previousPeriod', context: context);

  @override
  Future<void> previousPeriod() {
    return _$previousPeriodAsyncAction.run(() => super.previousPeriod());
  }

  late final _$loadAnalyticsAsyncAction =
      AsyncAction('_AnalyticsStore.loadAnalytics', context: context);

  @override
  Future<void> loadAnalytics() {
    return _$loadAnalyticsAsyncAction.run(() => super.loadAnalytics());
  }

  @override
  String toString() {
    return '''
timeFilter: ${timeFilter},
selectedYear: ${selectedYear},
selectedMonth: ${selectedMonth},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
profitTrend: ${profitTrend},
stockMovement: ${stockMovement},
revenueMix: ${revenueMix},
overallSummary: ${overallSummary},
periodTitle: ${periodTitle},
dateRangeSubtext: ${dateRangeSubtext}
    ''';
  }
}
