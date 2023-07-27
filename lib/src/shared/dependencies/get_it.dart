import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/tasks/data/repositories/update_task_repository.impl.dart';
import 'package:task_planner/src/features/tasks/domain/usecases/update_task_usecase.dart';
import 'package:task_planner/src/features/tasks/external/update_task_datasource.impl.dart';
import 'package:task_planner/src/shared/services/notification/push_notification.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:task_planner/src/features/tasks/data/repositories/delete_task_repository.impl.dart';
import 'package:task_planner/src/features/tasks/data/repositories/get_tasks_repository.impl.dart';
import 'package:task_planner/src/features/tasks/data/repositories/save_task_repository.impl.dart';
import 'package:task_planner/src/features/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:task_planner/src/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:task_planner/src/features/tasks/domain/usecases/save_task_usecase.dart';
import 'package:task_planner/src/features/tasks/external/delete_task_datasource.impl.dart';
import 'package:task_planner/src/features/tasks/external/get_tasks_datasource.impl.dart';
import 'package:task_planner/src/features/tasks/external/save_task_datasource.impl.dart';
import 'package:task_planner/src/features/tasks/presenter/controllers/state_controller.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class GetItSetup {
  static GetIt getIt = GetIt.instance;

  static void init() {
    database();
    pushNotification();
    initServices();
    initControllers();
  }

  static void initControllers() {
    getIt.registerLazySingleton<StateController>(
      () => StateController(
        getIt(),
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

    getIt.registerLazySingleton<UpdateTaskUsecase>(
      () => UpdateTaskUsecaseImpl(
        UpdateTaskRepositoryImpl(
          UpdateTaskDatasourceImpl(),
        ),
      ),
    );
  }

  static Future<void> database() async {
    var packageName = 'com.task_planner.todo';
    var databaseFactory = getDatabaseFactory(packageName: packageName);
    getIt.registerLazySingleton<DataBaseCustom>(
      () => DataBaseCustom(databaseFactory),
    );
  }

  static Future<void> pushNotification() async {
    getIt.registerLazySingleton<PushNotification>(
      () => PushNotification(
        flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
      ),
    );
    GetIt.I.get<PushNotification>().init();
  }
}
