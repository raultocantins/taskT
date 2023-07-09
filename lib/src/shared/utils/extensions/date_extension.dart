import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension DateFormated on DateTime {
  String formatDate() {
    initializeDateFormatting();
    return DateFormat("dd/MM/yyyy", "pt_BR").format(this);
  }

  String formatDateToDatabase() {
    initializeDateFormatting();
    return DateFormat("yyyy-MM-dd", "pt_BR").format(this);
  }

  String formatDayName() {
    initializeDateFormatting();
    return DateFormat("EEEE", "pt_BR").format(this);
  }
}
