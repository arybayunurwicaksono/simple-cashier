import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PasswordHasher {
  /// Generates a random secure salt string
  static String generateSalt([int length = 16]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64UrlEncode(values);
  }

  /// Hashes a plain password with a provided salt using SHA-256
  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode('$password::$salt');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verifies if a given plain password matches the stored hash and salt
  static bool verifyPassword(String inputPassword, String storedHash, String storedSalt) {
    final calculatedHash = hashPassword(inputPassword, storedSalt);
    return calculatedHash == storedHash;
  }

  /// Hashes a numeric PIN with salt
  static String hashPin(String pin, String salt) => hashPassword(pin, salt);

  /// Verifies if a given PIN matches stored hash and salt
  static bool verifyPin(String inputPin, String storedHash, String storedSalt) =>
      verifyPassword(inputPin, storedHash, storedSalt);

  /// Normalizes a security answer (lowercase and trimmed)
  static String normalizeSecurityAnswer(String answer) => answer.trim().toLowerCase();

  /// Hashes a normalized security answer with salt
  static String hashSecurityAnswer(String answer, String salt) =>
      hashPassword(normalizeSecurityAnswer(answer), salt);

  /// Verifies if a security answer matches stored hash and salt
  static bool verifySecurityAnswer(String inputAnswer, String storedHash, String storedSalt) =>
      verifyPassword(normalizeSecurityAnswer(inputAnswer), storedHash, storedSalt);
}
