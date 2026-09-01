class ApiEndpoints {
  static const String baseUrl = 'https://api.simplecashier.dgc16.com/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';
  static const String profile = '/auth/profile';

  // Master Data
  static const String products = '/products';
  static const String services = '/services';
  static const String categories = '/categories';
  static const String storeProfile = '/store/profile';

  // POS & Transactions
  static const String transactions = '/transactions';
  static const String syncPush = '/sync/push';
  static const String syncPull = '/sync/pull';
}
