import '../app_database.dart';

class RestockWithProduct {
  final RestockData restock;
  final ProductData? product;
  final UserData? user;

  RestockWithProduct({
    required this.restock,
    this.product,
    this.user,
  });
}
