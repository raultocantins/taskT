// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$countTasksPendingAtom =
      Atom(name: '_HomeControllerBase.countTasksPending', context: context);

  @override
  int get countTasksPending {
    _$countTasksPendingAtom.reportRead();
    return super.countTasksPending;
  }

  @override
  set countTasksPending(int value) {
    _$countTasksPendingAtom.reportWrite(value, super.countTasksPending, () {
      super.countTasksPending = value;
    });
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  void changeCountTasksPending(int value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeCountTasksPending');
    try {
      return super.changeCountTasksPending(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
countTasksPending: ${countTasksPending}
    ''';
  }
}
