class FormValidators {
  static String? required(String? value, [String message = 'Wajib diisi']) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? password(String? value, [int minLength = 6]) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi';
    }
    if (value.length < minLength) {
      return 'Password minimal $minLength karakter';
    }
    return null;
  }

  static String? positiveNumber(String? value, [String fieldName = 'Nilai']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName wajib diisi';
    }
    final number = int.tryParse(value.replaceAll(RegExp(r'[^\d]'), ''));
    if (number == null || number < 0) {
      return '$fieldName harus berupa angka positif';
    }
    return null;
  }
}
