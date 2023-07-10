import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateBottomSheet extends StatefulWidget {
  final Function(DateTime) callback;
  const DateBottomSheet({super.key, required this.callback});

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            titleTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            formatButtonDecoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(color: Colors.white),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold)),
          calendarStyle: const CalendarStyle(
            defaultTextStyle: TextStyle(color: Colors.white),
            outsideTextStyle: TextStyle(color: Colors.white),
            withinRangeTextStyle: TextStyle(color: Colors.white),
            weekendTextStyle: TextStyle(color: Colors.white),
            todayTextStyle: TextStyle(color: Colors.white),
            disabledTextStyle: TextStyle(color: Colors.white),
            holidayTextStyle: TextStyle(color: Colors.white),
            rangeEndTextStyle: TextStyle(color: Colors.white),
            rangeStartTextStyle: TextStyle(color: Colors.white),
            selectedTextStyle: TextStyle(color: Colors.white),
            weekNumberTextStyle: TextStyle(color: Colors.white),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            widget.callback(selectedDay);
            Navigator.of(context).pop();
          },
          focusedDay: date,
          currentDay: date,
          firstDay: DateTime.now().subtract(const Duration(days: 6000)),
          lastDay: DateTime.now().add(const Duration(days: 6000)),
        ),
      ),
    );
  }
}
