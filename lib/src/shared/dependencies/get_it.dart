import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/data/repositories/delete_book_repository.impl.dart';
import 'package:task_planner/src/features/books/data/repositories/get_books_repository.impl.dart';
import 'package:task_planner/src/features/books/data/repositories/save_book_repository.impl.dart';
import 'package:task_planner/src/features/books/data/repositories/update_book_repository.impl.dart';
import 'package:task_planner/src/features/books/domain/usecases/delete_book_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/get_books_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/save_book_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/update_book_usecase.dart';
import 'package:task_planner/src/features/books/external/delete_book_datasource.impl.dart';
import 'package:task_planner/src/features/books/external/get_books_datasource.impl.dart';
import 'package:task_planner/src/features/books/external/save_book_datasource.impl.dart';
import 'package:task_planner/src/features/books/external/update_book_datasource.impl.dart';
import 'package:task_planner/src/features/books/presenter/controllers/books_controller.dart';
import 'package:task_planner/src/features/home/data/repositories/get_count_books_inprogress_repository.impl.dart';
import 'package:task_planner/src/features/home/data/repositories/get_count_tasks_pending_repository.impl.dart';
import 'package:task_planner/src/features/home/domain/usecases/get_count_books_inprogress_usecase.dart';
import 'package:task_planner/src/features/home/domain/usecases/get_count_task_pending_usecase.dart';
import 'package:task_planner/src/features/home/external/get_count_books_inprogress_datasource.impl.dart';
import 'package:task_planner/src/features/home/external/get_count_tasks_pending_datasource.impl.dart';
import 'package:task_planner/src/features/home/presentation/controllers/home_controller.dart';
import 'package:task_planner/src/features/tasks/data/repositories/update_task_repository.impl.dart';
import 'package:task_planner/src/features/tasks/domain/usecases/update_task_usecase.dart';
import 'package:task_planner/src/features/tasks/external/update_task_datasource.impl.dart';
import 'package:task_planner/src/shared/controllers/tags_controller.dart';
import 'package:task_planner/src/shared/data/repositories/create_tag_repository.impl.dart';
import 'package:task_planner/src/shared/data/repositories/delete_tag_repository.impl.dart';
import 'package:task_planner/src/shared/data/repositories/get_tags_repository.impl.dart';
import 'package:task_planner/src/shared/domain/usecases/create_tag_usecase.dart';
import 'package:task_planner/src/shared/domain/usecases/delete_tag_usecase.dart';
import 'package:task_planner/src/shared/domain/usecases/get_tags_usecase.dart';
import 'package:task_planner/src/shared/external/create_tag_datasource.impl.dart';
import 'package:task_planner/src/shared/external/delete_tag_datasource.impl.dart';
import 'package:task_planner/src/shared/external/get_tags_datasource.impl.dart';
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
import 'package:task_planner/src/features/tasks/presentation/controllers/tasks_controller.dart';
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
    getIt.registerLazySingleton<TasksController>(
      () => TasksController(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    );
    getIt.registerLazySingleton<BooksController>(
      () => BooksController(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    );
    getIt.registerLazySingleton<TagsController>(
      () => TagsController(
        getIt(),
        getIt(),
        getIt(),
      ),
    );

    getIt.registerLazySingleton<HomeController>(
      () => HomeController(
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

    getIt.registerLazySingleton<SaveBookUsecase>(
      () => SaveBookUsecaseImpl(
        SaveBookRepositoryImpl(
          SaveBookDatasourceImpl(),
        ),
      ),
    );
    getIt.registerLazySingleton<GetBooksUsecase>(
      () => GetBooksUsecaseImpl(
        GetBooksRepositoryImpl(
          GetBooksDatasourceImpl(),
        ),
      ),
    );
    getIt.registerLazySingleton<DeleteBookUsecase>(
      () => DeleteBookUsecaseImpl(
        DeleteBookRepositoryImpl(
          DeleteBookDatasourceImpl(),
        ),
      ),
    );

    getIt.registerLazySingleton<UpdateBookUsecase>(
      () => UpdateBookUsecaseImpl(
        UpdateBookRepositoryImpl(
          UpdateBookDatasourceImpl(),
        ),
      ),
    );

    getIt.registerLazySingleton<GetTagsUsecase>(
      () => GetTagsUsecaseImpl(
        GetTagsRepositoryImpl(
          GetTagsDatasourceImpl(),
        ),
      ),
    );

    getIt.registerLazySingleton<GetCountTasksPendingUsecase>(
      () => GetCountTasksPendingUsecaseImpl(
        GetCountTasksPendingRepositoryImpl(
          GetCountTasksPendingDatasourceImpl(),
        ),
      ),
    );

    getIt.registerLazySingleton<DeleteTagUsecase>(
      () => DeleteTagUsecaseImpl(
        DeleteTagRepositoryImpl(
          DeleteTagDatasourceImpl(),
        ),
      ),
    );

    getIt.registerLazySingleton<CreateTagUsecase>(
      () => CreateTagUsecaseImpl(
        CreateTagRepositoryImpl(
          CreateTagDatasourceImpl(),
        ),
      ),
    );

    getIt.registerLazySingleton<GetCountBooksInprogressUsecase>(
      () => GetCountBooksInprogressUsecaseImpl(
        GetCountBooksInprogressRepositoryImpl(
          GetCountBooksInprogressDatasourceImpl(),
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
