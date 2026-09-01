// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import 'package:database/database.dart';

part 'balance_store.g.dart';

class BalanceStore = _BalanceStore with _$BalanceStore;

abstract class _BalanceStore with Store {
  final BalanceDao _balanceDao;

  _BalanceStore({
    required BalanceDao balanceDao,
  }) : _balanceDao = balanceDao;

  @observable
  ObservableList<BalanceLogData> balanceLogs = ObservableList<BalanceLogData>();

  @observable
  int cashBalance = 0;

  @observable
  int digitalBalance = 0;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  int get totalBalance => cashBalance + digitalBalance;

  @action
  Future<void> loadBalances() async {
    isLoading = true;
    try {
      final logs = await _balanceDao.getAllBalanceLogs();
      balanceLogs = ObservableList.of(logs);
      cashBalance = await _balanceDao.getCashBalance();
      digitalBalance = await _balanceDao.getDigitalBalance();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> addBalanceLog({
    required int amount,
    required String flowType, // 'in' | 'out'
    required String category, // 'capital' | 'operational' | 'withdrawal' | 'other'
    required String paymentType, // 'cash' | 'digital'
    required int userId,
    String? notes,
  }) async {
    isLoading = true;
    try {
      await _balanceDao.insertBalanceLog(
        BalanceLogsCompanion(
          amount: Value(amount),
          flowType: Value(flowType),
          category: Value(category),
          paymentType: Value(paymentType),
          userId: Value(userId),
          notes: Value(notes),
        ),
      );
      await loadBalances();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }
}
