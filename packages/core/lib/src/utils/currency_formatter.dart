import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static final NumberFormat _compactRupiahFormat = NumberFormat.compactCurrency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 1,
  );

  /// Formats an integer amount to standard Indonesian Rupiah ("Rp 50.000")
  static String format(int? amount) {
    if (amount == null) return 'Rp 0';
    return _rupiahFormat.format(amount);
  }

  /// Formats a double amount to standard Indonesian Rupiah
  static String formatDouble(double? amount) {
    if (amount == null) return 'Rp 0';
    return _rupiahFormat.format(amount.round());
  }

  /// Formats large numbers compactly ("Rp 1,5 jt")
  static String formatCompact(int? amount) {
    if (amount == null) return 'Rp 0';
    return _compactRupiahFormat.format(amount);
  }

  /// Cleans raw text string to integer amount
  static int parse(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(cleaned) ?? 0;
  }
}
