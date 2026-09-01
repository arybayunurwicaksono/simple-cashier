import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'auth_interceptor.dart';
import '../security/secure_storage_service.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({SecureStorageService? secureStorage, String? baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (secureStorage != null) {
      dio.interceptors.add(AuthInterceptor(secureStorage));
    }
  }
}
