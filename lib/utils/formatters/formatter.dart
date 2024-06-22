import 'package:intl/intl.dart';

class OneFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en-US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
  }

  
}
