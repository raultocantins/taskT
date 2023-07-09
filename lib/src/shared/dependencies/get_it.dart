import 'package:get_it/get_it.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:taskt/src/features/home/data/repositories/delete_task_repository.impl.dart';
import 'package:taskt/src/features/home/data/repositories/get_tasks_repository.impl.dart';
import 'package:taskt/src/features/home/data/repositories/save_task_repository.impl.dart';
import 'package:taskt/src/features/home/domain/usecases/delete_task_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/get_tasks_usecase.dart';
import 'package:taskt/src/features/home/domain/usecases/save_task_usecase.dart';
import 'package:taskt/src/features/home/external/delete_task_datasource.impl.dart';
import 'package:taskt/src/features/home/external/get_tasks_datasource.impl.dart';
import 'package:taskt/src/features/home/external/save_task_datasource.impl.dart';
import 'package:taskt/src/features/home/presenter/controllers/state_controller.dart';
import 'package:taskt/src/shared/database/db.dart';

class GetItSetup {
  static GetIt getIt = GetIt.instance;

  static void init() {
    database();
    initServices();
    initControllers();
  }

  static void initControllers() {
    getIt.registerLazySingleton<StateController>(
      () => StateController(
        getIt(),
        getIt(),
        getIt(),
      ),
    );
  }

  static void initServices() {
    getIt.registerLazySingleton<SaveTaskUsecase>(
      () => SaveTaskUsecaseImpl(
        SaveTaskRepositoryImpl(
          SaveTaskDatasourceImpl(),
        ),
      ),
    );
    getIt.registerLazySingleton<GetTasksUsecase>(
      () => GetTasksUsecaseImpl(
        GetTasksRepositoryImpl(
          GetTasksDatasourceImpl(),
        ),
      ),
    );
    getIt.registerLazySingleton<DeleteTaskUsecase>(
      () => DeleteTaskUsecaseImpl(
        DeleteTaskRepositoryImpl(
          DeleteTaskDatasourceImpl(),
        ),
      ),
    );
  }

  static void database() async {
    var packageName = 'com.task.todo.initial';
    var databaseFactory = getDatabaseFactory(packageName: packageName);
    getIt.registerLazySingleton<DataBaseCustom>(
      () => DataBaseCustom(databaseFactory),
    );
  }
}
