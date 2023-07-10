// ignore: depend_on_referenced_packages
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:taskt/src/features/home/data/models/task_model.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';
import 'package:taskt/src/shared/utils/extensions/date_extension.dart';
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
        version: 1,
        onCreate: (db, version) async {
          await _createDb(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 1) {
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
    await db.execute('DROP TABLE If EXISTS $table');
    await db.execute(
      'CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDate TEXT, $columnHours TEXT, $columnDescription TEXT, $columnFinished INTEGER,  $columnTag TEXT,$columnPriority TEXT, $columnUpdated INTEGER)',
    );
    await db.execute(
      'CREATE INDEX TasksUpdated ON $table ($columnUpdated)',
    );
  }

  Future<TaskModel> saveTask(TaskEntity taskEntity) async {
    int newId = await db!.insert(table, TaskModel.toModel(taskEntity).toMap());
    return TaskModel(
      id: newId,
      date: taskEntity.date,
      hours: taskEntity.hours,
      description: taskEntity.description,
      finished: taskEntity.finished,
      priority: taskEntity.priority,
      tag: taskEntity.tag,
      title: taskEntity.title,
    );
  }

  Future<TaskModel> updateTask(TaskEntity taskEntity) async {
    await db!.update(table, TaskModel.toModel(taskEntity).toMap(),
        where: '$columnId = ?', whereArgs: <Object?>[taskEntity.id]);
    return TaskModel.toModel(taskEntity);
  }

  Future<void> deleteTask(int? id) async {
    await db!.delete(table, where: '$columnId = ?', whereArgs: <Object?>[id]);
  }

  Future<List<TaskModel>> getTasks(
      {required DateTime date, required Tag tag}) async {
    var list = await db!.query(
      table,
      columns: [
        columnDate,
        columnHours,
        columnTag,
        columnDescription,
        columnFinished,
        columnId,
        columnPriority,
        columnTag,
        columnTitle,
        columnUpdated
      ],
      orderBy: '$columnUpdated DESC',
      where: '$columnDate = ? AND $columnTag = ?',
      whereArgs: <Object?>[date.formatDateToDatabase(), tag.fromEnumToString()],
    );

    return list
        .map(
          (e) => TaskModel.fromObjectDb(e),
        )
        .toList();
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
            const Duration(milliseconds: 2500),
          );
          if (db == null) {
            await open();
          }
          return db;
        },
      );
}
