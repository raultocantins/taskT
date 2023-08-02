import 'package:flutter/material.dart';

enum BookState { initial, paused, started, finished }

extension BookStateExtensions on BookState {
  String label(BuildContext context) {
    switch (this) {
      case BookState.initial:
        return 'Initial';
      case BookState.paused:
        return 'Paused';
      case BookState.started:
        return 'Started';
      case BookState.finished:
        return 'Finished';

      default:
        return 'Initial';
    }
  }

  static BookState fromStringToEnum(String text) {
    switch (text) {
      case 'initial':
        return BookState.initial;
      case 'paused':
        return BookState.paused;
      case 'started':
        return BookState.started;
      case 'finished':
        return BookState.finished;

      default:
        return BookState.initial;
    }
  }

  String fromEnumToString() {
    switch (this) {
      case BookState.initial:
        return 'initial';
      case BookState.paused:
        return 'paused';
      case BookState.started:
        return 'started';
      case BookState.finished:
        return 'finished';

      default:
        return 'initial';
    }
  }
}
