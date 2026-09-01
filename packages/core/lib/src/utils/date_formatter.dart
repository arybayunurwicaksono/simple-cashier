import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _fullDateTimeFormat = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID');
  static final DateFormat _dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
  static final DateFormat _shortDateFormat = DateFormat('dd/MM/yyyy', 'id_ID');
  static final DateFormat _periodMonthYearFormat = DateFormat('MMMM yyyy', 'id_ID');
  static final DateFormat _invoiceDateFormat = DateFormat('yyyyMMdd-HHmmss');

  /// Formats DateTime to "27 Agustus 2026, 15:30"
  static String formatFull(DateTime? date) {
    if (date == null) return '-';
    return _fullDateTimeFormat.format(date);
  }

  /// Formats DateTime to "27 Agustus 2026"
  static String formatDate(DateTime? date) {
    if (date == null) return '-';
    return _dateFormat.format(date);
  }

  /// Formats DateTime to "27/08/2026"
  static String formatShort(DateTime? date) {
    if (date == null) return '-';
    return _shortDateFormat.format(date);
  }

  /// Formats DateTime to "Agustus 2026" for monthly accounting
  static String formatPeriod(DateTime? date) {
    if (date == null) return '-';
    return _periodMonthYearFormat.format(date);
  }

  /// Generates a unique timestamp suffix for invoices: "INV-20260827-153022"
  static String generateInvoiceNumber() {
    final now = DateTime.now();
    return 'INV-${_invoiceDateFormat.format(now)}';
  }
}
