import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateBottomSheet extends StatefulWidget {
  final Function(DateTime?) callback;
  final DateTime date;
  const DateBottomSheet({
    required this.callback,
    required this.date,
    super.key,
  });

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
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
            if (widget.date.year == selectedDay.year &&
                widget.date.month == selectedDay.month &&
                widget.date.day == selectedDay.day) {
              widget.callback(null);
            } else {
              widget.callback(DateTime(
                  selectedDay.year, selectedDay.month, selectedDay.day));
            }

            Navigator.of(context).pop();
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle),
          ),
          focusedDay: widget.date,
          currentDay: widget.date,
          firstDay: DateTime.now().subtract(const Duration(days: 6000)),
          lastDay: DateTime.now().add(const Duration(days: 6000)),
        ),
      ),
    );
  }
}
