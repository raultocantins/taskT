// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TasksController on _TasksControllerBase, Store {
  late final _$_dateSelectedAtom =
      Atom(name: '_TasksControllerBase._dateSelected', context: context);

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
      Atom(name: '_TasksControllerBase.isLoading', context: context);

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

  late final _$tagIdAtom =
      Atom(name: '_TasksControllerBase.tagId', context: context);

  @override
  int? get tagId {
    _$tagIdAtom.reportRead();
    return super.tagId;
  }

  @override
  set tagId(int? value) {
    _$tagIdAtom.reportWrite(value, super.tagId, () {
      super.tagId = value;
    });
  }

  late final _$doneAtom =
      Atom(name: '_TasksControllerBase.done', context: context);

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
      Atom(name: '_TasksControllerBase._tasks', context: context);

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

  late final _$_TasksControllerBaseActionController =
      ActionController(name: '_TasksControllerBase', context: context);

  @override
  void changeDate(DateTime? value) {
    final _$actionInfo = _$_TasksControllerBaseActionController.startAction(
        name: '_TasksControllerBase.changeDate');
    try {
      return super.changeDate(value);
    } finally {
      _$_TasksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTag(int? value) {
    final _$actionInfo = _$_TasksControllerBaseActionController.startAction(
        name: '_TasksControllerBase.changeTag');
    try {
      return super.changeTag(value);
    } finally {
      _$_TasksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDone(bool value) {
    final _$actionInfo = _$_TasksControllerBaseActionController.startAction(
        name: '_TasksControllerBase.changeDone');
    try {
      return super.changeDone(value);
    } finally {
      _$_TasksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTasks(List<TaskEntity> value) {
    final _$actionInfo = _$_TasksControllerBaseActionController.startAction(
        name: '_TasksControllerBase.changeTasks');
    try {
      return super.changeTasks(value);
    } finally {
      _$_TasksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsLoading(bool value) {
    final _$actionInfo = _$_TasksControllerBaseActionController.startAction(
        name: '_TasksControllerBase.changeIsLoading');
    try {
      return super.changeIsLoading(value);
    } finally {
      _$_TasksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tagId: ${tagId},
done: ${done}
    ''';
  }
}
