import '../app_database.dart';

class TransactionWithItems {
  final TransactionData transaction;
  final List<TransactionItemData> items;
  final UserData? user;

  TransactionWithItems({
    required this.transaction,
    required this.items,
    this.user,
  });
}
