import 'package:mobx/mobx.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/domain/usecases/delete_task_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/get_tasks_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/save_task_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/update_task_usecase.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';
import 'package:taskt/src/shared/utils/extensions/date_extension.dart';

part 'state_controller.g.dart';

// ignore: library_private_types_in_public_api
class StateController = _StateControllerBase with _$StateController;

abstract class _StateControllerBase with Store {
  final SaveTaskUsecase _saveTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;
  final GetTasksUsecase _getTasksUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  _StateControllerBase(this._saveTaskUsecase, this._getTasksUsecase,
      this._deleteTaskUsecase, this._updateTaskUsecase);

  @observable
  DateTime _dateSelected = DateTime.now().toLocal();

  @observable
  Tag tag = Tag.all;

  @observable
  List<TaskEntity> _tasks = [];

  String get dateFormated => _dateSelected.formatDate();
  String get dayFormated => _dateSelected.formatDayName();
  List<TaskEntity> get tasks {
    _tasks.sort((a, b) => b.date.compareTo(a.date));
    return _tasks;
  }

  @action
  changeDate(DateTime value) {
    _dateSelected = value;
    getTask();
  }

  @action
  changeTag(Tag value) {
    tag = value;
    getTask();
  }

  @action
  changeTasks(List<TaskEntity> value) {
    _tasks = value;
  }

  void getTask() async {
    var result = await _getTasksUsecase(date: _dateSelected, tag: tag);
    result.fold(
      (l) => null,
      (r) {
        changeTasks(r);
      },
    );
  }

  void createTask(TaskEntity task) async {
    var result = await _saveTaskUsecase(task);
    result.fold(
      (l) => null,
      (r) {
        if (verifyTask(task)) {
          changeTasks([...tasks, task]);
        }
      },
    );
  }

  void deleteTask(TaskEntity task) async {
    var result = await _deleteTaskUsecase(task);
    result.fold(
      (l) => null,
      (_) {
        if (verifyTask(task)) {
          List<TaskEntity> updatedList = tasks;
          updatedList.removeWhere((element) => element.id == task.id);
          changeTasks([...updatedList]);
        }
      },
    );
  }

  void updateTask(TaskEntity task) async {
    var result = await _updateTaskUsecase(task);
    result.fold(
      (l) => null,
      (updatedTask) {
        List<TaskEntity> updatedList = tasks;
        if (verifyTask(task)) {
          for (int i = 0; i < updatedList.length; i++) {
            if (updatedList[i].id == updatedTask.id) {
              updatedList[i] = updatedTask;
              break;
            }
          }
          changeTasks([...updatedList]);
        } else {
          updatedList.removeWhere((e) => e.id == updatedTask.id);
          changeTasks([...updatedList]);
        }
      },
    );
  }

  bool verifyTask(TaskEntity task) {
    return (task.date.day == _dateSelected.day && task.tag == tag)
        ? true
        : false;
  }
}
