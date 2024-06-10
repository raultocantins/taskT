import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateBottomSheet extends StatefulWidget {
  final Function(DateTime) callback;
  const DateBottomSheet({
    required this.callback,
    super.key,
  });

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonTextStyle: TextStyle(fontWeight: FontWeight.bold),
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
            formatButtonDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            DateTime now = DateTime.now();
            widget.callback(DateTime(selectedDay.year, selectedDay.month,
                selectedDay.day, now.hour, now.minute));
            Navigator.of(context).pop();
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle),
          ),
          focusedDay: date,
          currentDay: date,
          firstDay: DateTime.now().subtract(const Duration(days: 6000)),
          lastDay: DateTime.now().add(const Duration(days: 6000)),
        ),
      ),
    );
  }
}
