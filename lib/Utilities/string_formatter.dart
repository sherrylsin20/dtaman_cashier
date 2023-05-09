import 'package:intl/intl.dart';

String currencyWithSymbolFormatter(int price) {
  final currencyFormatter =
      NumberFormat.currency(decimalDigits: 0, symbol: 'Rp ', locale: 'ID');
  return (currencyFormatter.format(price.toDouble()));
}

String onlyNumbersCurrencyFormatter(int price) {
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  return (currencyFormatter.format(price.toDouble()));
}

int numberFormatter(String value) {
  String formattedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  return int.parse(formattedValue);
}
