// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:task_planner/generated/l10n.dart';

extension DateFormated on DateTime {
  String formatDate() {
    initializeDateFormatting();
    return DateFormat('dd MMM yyyy. EEEE', 'pt_BR').format(this);
  }

  String formatDateDefault(BuildContext context) {
    initializeDateFormatting();

    if (day == DateTime.now().toLocal().day) {
      return S.of(context).today;
    } else if (day ==
        DateTime.now().toLocal().add(const Duration(days: 1)).day) {
      return S.of(context).tomorrow;
    } else if (day ==
        DateTime.now().toLocal().subtract(const Duration(days: 1)).day) {
      return S.of(context).yesterday;
    } else {
      return DateFormat('dd/MM/yyyy', 'pt_BR').format(this);
    }
  }

  String formatDateToHours() {
    initializeDateFormatting();
    return DateFormat('HH:mm', 'pt_BR').format(this);
  }
}
