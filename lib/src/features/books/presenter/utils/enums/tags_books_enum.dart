import 'package:flutter/material.dart';

enum TagBook { all, fantasy, action }

extension TagsBookExtensions on TagBook {
  String label(BuildContext context) {
    switch (this) {
      case TagBook.all:
        return 'Todos';
      case TagBook.fantasy:
        return 'Fantasia';
      case TagBook.action:
        return 'Ação e aventura';

      default:
        return 'Todos';
    }
  }

  static TagBook fromStringToEnum(String text) {
    switch (text) {
      case 'all':
        return TagBook.all;
      case 'fantasy':
        return TagBook.fantasy;
      case 'action':
        return TagBook.action;

      default:
        return TagBook.all;
    }
  }

  String fromEnumToString() {
    switch (this) {
      case TagBook.all:
        return 'all';
      case TagBook.fantasy:
        return 'fantasy';
      case TagBook.action:
        return 'action';

      default:
        return 'all';
    }
  }
}
