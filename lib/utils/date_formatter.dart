import 'package:intl/intl.dart';

class DateFormatter {

  static String formatDateDayOfWeek(DateTime date)
  {
    return DateFormat("E").format(date);
  }

  static String formatDateDay(DateTime date) {
    return DateFormat('dd').format(date);
  }

  static String formatDateMounth(DateTime date) {
    return DateFormat('MMM', ).format(date);
  }

  static String formatDateYear(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String formatDateDayMounthYear(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDateDayMounth(DateTime date) {
    return DateFormat('dd/MM').format(date);
  }
}