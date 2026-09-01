import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyText extends StatelessWidget {
  final int amount;
  final TextStyle? style;
  final bool compact;
  final bool scaleDown;
  final Alignment alignment;

  const CurrencyText({
    super.key,
    required this.amount,
    this.style,
    this.compact = false,
    this.scaleDown = true,
    this.alignment = Alignment.centerLeft,
  });

  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static final NumberFormat _compactFormatter = NumberFormat.compactCurrency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 1,
  );

  @override
  Widget build(BuildContext context) {
    final text = compact ? _compactFormatter.format(amount) : _formatter.format(amount);
    final textWidget = Text(
      text,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    if (scaleDown) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        alignment: alignment,
        child: textWidget,
      );
    }

    return textWidget;
  }
}
