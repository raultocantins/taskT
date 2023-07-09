import 'package:flutter/material.dart';

enum Priority { none, low, medium, high }

extension PriorityExtensions on Priority {
  Color getColor() {
    switch (this) {
      case Priority.high:
        return Colors.red;

      case Priority.medium:
        return Colors.amber;

      case Priority.low:
        return Colors.blue;

      default:
        return Colors.blue;
    }
  }

  static Priority fromStringToEnum(String text) {
    switch (text) {
      case 'high':
        return Priority.high;

      case 'medium':
        return Priority.medium;

      case 'low':
        return Priority.low;

      default:
        return Priority.none;
    }
  }

  String fromEnumToString() {
    switch (this) {
      case Priority.high:
        return 'high';

      case Priority.medium:
        return 'medium';

      case Priority.low:
        return 'low';

      default:
        return 'none';
    }
  }
}
