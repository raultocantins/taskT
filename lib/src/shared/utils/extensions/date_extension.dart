import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension DateFormated on DateTime {
  String formatDate() {
    initializeDateFormatting();
    return DateFormat('dd MMM yyyy. EEEE', 'pt_BR').format(this);
  }

  String formatDateDefault() {
    initializeDateFormatting();

    if (day == DateTime.now().toLocal().day) {
      return 'Hoje';
    } else if (day ==
        DateTime.now().toLocal().add(const Duration(days: 1)).day) {
      return 'Amanhã';
    } else if (day ==
        DateTime.now().toLocal().subtract((const Duration(days: 1))).day) {
      return 'Ontem';
    } else {
      return DateFormat('dd/MM/yyyy', 'pt_BR').format(this);
    }
  }

  String formatDateToHours() {
    initializeDateFormatting();
    return DateFormat('HH:mm', 'pt_BR').format(this);
  }
}
