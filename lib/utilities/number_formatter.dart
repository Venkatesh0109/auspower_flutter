import 'package:intl/intl.dart';

class NumberFormatter {
  String count(String value) {
    try {
      String num =
          NumberFormat.compact(locale: 'en_US').format(int.parse(value));
      return num;
    } on Exception {
      return value;
    }
  }
}
