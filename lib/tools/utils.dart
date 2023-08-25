// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => '${price.toStringAsFixed(2)} DT';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
