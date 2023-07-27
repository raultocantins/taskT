// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StateController on _StateControllerBase, Store {
  late final _$_dateSelectedAtom =
      Atom(name: '_StateControllerBase._dateSelected', context: context);

  @override
  DateTime? get _dateSelected {
    _$_dateSelectedAtom.reportRead();
    return super._dateSelected;
  }

  @override
  set _dateSelected(DateTime? value) {
    _$_dateSelectedAtom.reportWrite(value, super._dateSelected, () {
      super._dateSelected = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_StateControllerBase.isLoading', context: context);

  @override
  bool? get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool? value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$tagAtom =
      Atom(name: '_StateControllerBase.tag', context: context);

  @override
  Tag get tag {
    _$tagAtom.reportRead();
    return super.tag;
  }

  @override
  set tag(Tag value) {
    _$tagAtom.reportWrite(value, super.tag, () {
      super.tag = value;
    });
  }

  late final _$doneAtom =
      Atom(name: '_StateControllerBase.done', context: context);

  @override
  bool get done {
    _$doneAtom.reportRead();
    return super.done;
  }

  @override
  set done(bool value) {
    _$doneAtom.reportWrite(value, super.done, () {
      super.done = value;
    });
  }

  late final _$_tasksAtom =
      Atom(name: '_StateControllerBase._tasks', context: context);

  @override
  List<TaskEntity> get _tasks {
    _$_tasksAtom.reportRead();
    return super._tasks;
  }

  @override
  set _tasks(List<TaskEntity> value) {
    _$_tasksAtom.reportWrite(value, super._tasks, () {
      super._tasks = value;
    });
  }

  late final _$_StateControllerBaseActionController =
      ActionController(name: '_StateControllerBase', context: context);

  @override
  void changeDate(DateTime? value) {
    final _$actionInfo = _$_StateControllerBaseActionController.startAction(
        name: '_StateControllerBase.changeDate');
    try {
      return super.changeDate(value);
    } finally {
      _$_StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTag(Tag value) {
    final _$actionInfo = _$_StateControllerBaseActionController.startAction(
        name: '_StateControllerBase.changeTag');
    try {
      return super.changeTag(value);
    } finally {
      _$_StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDone(bool value) {
    final _$actionInfo = _$_StateControllerBaseActionController.startAction(
        name: '_StateControllerBase.changeDone');
    try {
      return super.changeDone(value);
    } finally {
      _$_StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTasks(List<TaskEntity> value) {
    final _$actionInfo = _$_StateControllerBaseActionController.startAction(
        name: '_StateControllerBase.changeTasks');
    try {
      return super.changeTasks(value);
    } finally {
      _$_StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsLoading(bool value) {
    final _$actionInfo = _$_StateControllerBaseActionController.startAction(
        name: '_StateControllerBase.changeIsLoading');
    try {
      return super.changeIsLoading(value);
    } finally {
      _$_StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tag: ${tag},
done: ${done}
    ''';
  }
}
