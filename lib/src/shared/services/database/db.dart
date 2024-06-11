// ignore: depend_on_referenced_packages
// ignore_for_file: lines_longer_than_80_chars
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import './db_constant.dart';

class DataBaseCustom {
  final DatabaseFactory dbFactory;
  Database? db;
  DataBaseCustom(this.dbFactory);
  final lock = Lock(reentrant: true);

  Future openPath(String path) async {
    db = await dbFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: kVersion2,
        onCreate: (db, version) async {
          await _createDb(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < kVersion2) {
            await _createDb(db);
          }
        },
      ),
    );
  }

  Future open() async {
    await openPath(await fixPath(dbName));
  }

  Future<String> fixPath(String path) async => path;

  Future _createDb(Database db) async {
    await db.execute('DROP TABLE If EXISTS $tagstable');
    await db.execute('DROP TABLE If EXISTS $tasktable');
    await db.execute(
      'CREATE TABLE $tagstable($tagscolumnId INTEGER PRIMARY KEY, $tagscolumnLabel TEXT, $tagscolumnType TEXT)',
    );
    await db.execute(
      'CREATE TABLE $tasktable($taskcolumnId INTEGER PRIMARY KEY, $taskcolumnTitle TEXT, $taskcolumnDate INTEGER, $taskcolumnDescription TEXT, $taskcolumnFinished INTEGER,  $taskcolumnTagId INTEGER, $taskcolumnPriority TEXT, $taskcolumnUpdated INTEGER)',
    );
    await db.execute(
      'CREATE INDEX TasksUpdated ON $tasktable ($taskcolumnUpdated)',
    );
  }

  Future<TaskModel> saveTask(TaskEntity taskEntity) async {
    int newId =
        await db!.insert(tasktable, TaskModel.toModel(taskEntity).toMap());
    return TaskModel(
      id: newId,
      date: taskEntity.date,
      description: taskEntity.description,
      finished: taskEntity.finished,
      priority: taskEntity.priority,
      tagId: taskEntity.tagId,
      title: taskEntity.title,
    );
  }

  Future<TaskModel> updateTask(TaskEntity taskEntity) async {
    await db!.update(
      tasktable,
      TaskModel.toModel(taskEntity).toMap(),
      where: '$taskcolumnId = ?',
      whereArgs: <Object?>[taskEntity.id],
    );
    return TaskModel.toModel(taskEntity);
  }

  Future<void> deleteTask(int? id) async {
    await db!.delete(
      tasktable,
      where: '$taskcolumnId = ?',
      whereArgs: <Object?>[id],
    );
  }

  Future<List<TaskModel>> getTasks(
      {DateTime? date, int? tagId, bool? done}) async {
    List<Map<String, Object?>>? list;
    String query = 'SELECT * FROM $tasktable WHERE 1=1';

    if (date != null) {
      int startOfDay =
          DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      int endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
          .millisecondsSinceEpoch;
      query += ' AND $taskcolumnDate BETWEEN $startOfDay AND $endOfDay';
    }
    if (tagId != null) {
      query += ' AND $taskcolumnTagId = $tagId';
    }
    if (done != null) {
      query += ' AND $taskcolumnFinished = ${done ? 1 : 0}';
    }

    list = await db?.rawQuery(query);
    return list
            ?.map(
              (e) => TaskModel.fromObjectDb(e),
            )
            .toList() ??
        [];
  }

  Future close() async {
    await db!.close();
  }

  Future deleteDb() async {
    await dbFactory.deleteDatabase(
      await fixPath(dbName),
    );
  }

  Future<Database?> get ready async => db ??= await lock.synchronized(
        () async {
          await Future.delayed(
            const Duration(milliseconds: 1500),
          );
          if (db == null) {
            await open();
          }
          return db;
        },
      );
}
