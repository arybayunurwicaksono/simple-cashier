abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class PrinterFailure extends Failure {
  const PrinterFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
