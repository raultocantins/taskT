import 'package:mobx/mobx.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/domain/usecases/delete_task_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/get_tasks_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/save_task_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/update_task_usecase.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';
import 'package:taskt/src/shared/utils/extensions/date_extension.dart';
import 'package:collection/collection.dart';
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
  DateTime? _dateSelected;

  @observable
  bool? isLoading = false;

  @observable
  Tag tag = Tag.all;

  @observable
  List<TaskEntity> _tasks = [];

  String get dateFormated => _dateSelected != null
      ? _dateSelected?.formatDate() ?? ''
      : 'Showing all tasks';

  Map<DateTime, List<TaskEntity>> get groupByDay {
    _tasks.sort((a, b) => b.date.compareTo(a.date));
    Map<DateTime, List<TaskEntity>> itemsByDay = groupBy(
      _tasks,
      (TaskEntity item) =>
          DateTime(item.date.year, item.date.month, item.date.day),
    );
    itemsByDay.forEach((day, items) {
      items.sort((a, b) => b.date.compareTo(a.date));
    });
    return itemsByDay;
  }

  @action
  changeDate(DateTime? value) {
    _dateSelected = value;
    getTask();
  }

  @action
  changeTag(Tag value) {
    tag = value;
    changeDate(null);
    getTask();
  }

  @action
  changeTasks(List<TaskEntity> value) {
    _tasks = value;
  }

  @action
  changeIsLoading(bool value) {
    isLoading = false;
  }

  void getTask() async {
    changeIsLoading(true);
    var result = await _getTasksUsecase(date: _dateSelected, tag: tag);
    result.fold(
      (l) => null,
      (r) {
        changeTasks(r);
      },
    );
    changeIsLoading(false);
  }

  void createTask(TaskEntity task) async {
    changeIsLoading(true);
    var result = await _saveTaskUsecase(task);
    result.fold(
      (l) => null,
      (r) {
        if (tag == Tag.all && _dateSelected == null) {
          changeTasks([..._tasks, task]);
        } else if (_dateSelected == null && task.tag == tag) {
          changeTasks([..._tasks, task]);
        }
        if (_dateSelected != null &&
            r.date.day == _dateSelected?.day &&
            r.tag == tag) {
          changeTasks([..._tasks, task]);
        }
      },
    );
    changeIsLoading(false);
  }

  void deleteTask(TaskEntity task) async {
    changeIsLoading(true);
    var result = await _deleteTaskUsecase(task);
    result.fold(
      (l) => null,
      (_) {
        List<TaskEntity> updatedList = _tasks;
        updatedList.removeWhere((element) => element.id == task.id);
        changeTasks([...updatedList]);
      },
    );
    changeIsLoading(false);
  }

  void updateTask(TaskEntity task) async {
    changeIsLoading(true);
    var result = await _updateTaskUsecase(task);
    result.fold(
      (l) => null,
      (updatedTask) {
        List<TaskEntity> updatedList = _tasks;
        if (tag == Tag.all) {
          for (int i = 0; i < updatedList.length; i++) {
            if (updatedList[i].id == updatedTask.id) {
              updatedList[i] = updatedTask;
              break;
            }
          }
          changeTasks([...updatedList]);
        } else if (updatedTask.tag == tag) {
          for (int i = 0; i < updatedList.length; i++) {
            if (updatedList[i].id == updatedTask.id) {
              updatedList[i] = updatedTask;
              break;
            }
          }
          changeTasks([...updatedList]);
        } else {
          updatedList.removeWhere((element) => element.id == task.id);
          changeTasks([...updatedList]);
        }
      },
    );
    changeIsLoading(false);
  }

  dispose() {
    isLoading = false;
  }
}
