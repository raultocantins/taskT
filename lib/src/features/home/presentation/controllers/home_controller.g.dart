// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoadingTasksAtom =
      Atom(name: '_HomeControllerBase.isLoadingTasks', context: context);

  @override
  bool get isLoadingTasks {
    _$isLoadingTasksAtom.reportRead();
    return super.isLoadingTasks;
  }

  @override
  set isLoadingTasks(bool value) {
    _$isLoadingTasksAtom.reportWrite(value, super.isLoadingTasks, () {
      super.isLoadingTasks = value;
    });
  }

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

  late final _$countBooksInprogressAtom =
      Atom(name: '_HomeControllerBase.countBooksInprogress', context: context);

  @override
  int get countBooksInprogress {
    _$countBooksInprogressAtom.reportRead();
    return super.countBooksInprogress;
  }

  @override
  set countBooksInprogress(int value) {
    _$countBooksInprogressAtom.reportWrite(value, super.countBooksInprogress,
        () {
      super.countBooksInprogress = value;
    });
  }

  late final _$tasksAtom =
      Atom(name: '_HomeControllerBase.tasks', context: context);

  @override
  List<TaskEntity> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<TaskEntity> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  void changeIsloading(bool value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeIsloading');
    try {
      return super.changeIsloading(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsloadingTasks(bool value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeIsloadingTasks');
    try {
      return super.changeIsloadingTasks(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void changeCountBooksInprogress(int value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeCountBooksInprogress');
    try {
      return super.changeCountBooksInprogress(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTasks(List<TaskEntity> value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeTasks');
    try {
      return super.changeTasks(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isLoadingTasks: ${isLoadingTasks},
countTasksPending: ${countTasksPending},
countBooksInprogress: ${countBooksInprogress},
tasks: ${tasks}
    ''';
  }
}
