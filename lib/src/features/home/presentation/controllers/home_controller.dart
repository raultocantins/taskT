import 'package:mobx/mobx.dart';
import 'package:task_planner/src/features/home/domain/usecases/get_count_books_inprogress_usecase.dart';
import 'package:task_planner/src/features/home/domain/usecases/get_count_task_pending_usecase.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/domain/usecases/get_tasks_usecase.dart';
part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GetCountTasksPendingUsecase _getCountTasksPendingUsecase;
  final GetCountBooksInprogressUsecase _getCountBooksInprogressUsecase;
  final GetTasksUsecase _getTasksUsecase;
  _HomeControllerBase(
    this._getCountTasksPendingUsecase,
    this._getCountBooksInprogressUsecase,
    this._getTasksUsecase,
  );

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingTasks = false;

  @observable
  int countTasksPending = 0;

  @observable
  int countBooksInprogress = 0;

  @observable
  List<TaskEntity> tasks = [];

  @action
  void changeIsloading(bool value) {
    isLoading = value;
  }

  @action
  void changeIsloadingTasks(bool value) {
    isLoadingTasks = value;
  }

  @action
  void changeCountTasksPending(int value) {
    countTasksPending = value;
  }

  @action
  void changeCountBooksInprogress(int value) {
    countBooksInprogress = value;
  }

  @action
  void changeTasks(List<TaskEntity> value) {
    tasks = value;
  }

  Future<void> getCountTasksPending() async {
    var result = await _getCountTasksPendingUsecase();
    result.fold(
      (l) => null,
      (r) {
        changeCountTasksPending(r);
      },
    );
  }

  Future<void> getCountBooksInprogress() async {
    var result = await _getCountBooksInprogressUsecase();
    result.fold(
      (l) => null,
      (r) {
        changeCountBooksInprogress(r);
      },
    );
  }

  Future<void> getTasks() async {
    changeIsloadingTasks(true);
    var result = await _getTasksUsecase();
    result.fold(
      (l) => null,
      (r) {
        changeTasks(r);
      },
    );
    changeIsloadingTasks(false);
  }

  Future<void> fakeSync() async {
    changeIsloading(true);
    await Future.delayed(const Duration(seconds: 2));
    changeIsloading(false);
  }
}
