class AppException implements Exception {
  final String message;
  final dynamic details;

  AppException(this.message, [this.details]);

  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(super.message, [super.details]);
}

class DatabaseException extends AppException {
  DatabaseException(super.message, [super.details]);
}

class PrinterException extends AppException {
  PrinterException(super.message, [super.details]);
}

class StorageException extends AppException {
  StorageException(super.message, [super.details]);
}
