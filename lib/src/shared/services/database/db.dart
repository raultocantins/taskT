// ignore: depend_on_referenced_packages
import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';
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
        version: kVersion,
        onCreate: (db, version) async {
          await _createDb(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < kVersion) {
            // await _createDb(db); Criar um novo método para upgrade
            // ao usar o mesmo método _createDb ele removerá os dados do usuário
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
    //Verifica se existe as tabelas, e apaga caso exista
    await db.execute('DROP TABLE If EXISTS $tagstable');
    await db.execute('DROP TABLE If EXISTS $tasktable');
    //Criação das tabelas
    await db.execute(
      'CREATE TABLE $tagstable($tagscolumnId INTEGER PRIMARY KEY, $tagscolumnLabel TEXT, $tagscolumnType TEXT)',
    );
    await db.execute(
      'CREATE TABLE $tasktable($taskcolumnId INTEGER PRIMARY KEY, $taskcolumnTitle TEXT, $taskcolumnDate INTEGER, $taskcolumnDescription TEXT, $taskcolumnFinished INTEGER,  $taskcolumnTagId INTEGER, $taskcolumnPriority TEXT, $taskcolumnUpdated INTEGER)',
    );
    // Adiciona um index na tabela tasks
    await db.execute(
      'CREATE INDEX TasksUpdated ON $tasktable ($taskcolumnUpdated)',
    );
    // Insere três itens na tabela tags recém-criada
    await db.rawInsert(
      'INSERT INTO $tagstable($tagscolumnId, $tagscolumnLabel, $tagscolumnType) VALUES(?, ?, ?)',
      [1, 'Trabalho', 'task'],
    );
    await db.rawInsert(
      'INSERT INTO $tagstable($tagscolumnId, $tagscolumnLabel, $tagscolumnType) VALUES(?, ?, ?)',
      [2, 'Pessoal', 'task'],
    );
    await db.rawInsert(
      'INSERT INTO $tagstable($tagscolumnId, $tagscolumnLabel, $tagscolumnType) VALUES(?, ?, ?)',
      [3, 'Casa', 'task'],
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

  Future<List<TagModel>> getTags(TagType type) async {
    String sql = 'SELECT * FROM $tagstable WHERE $tagscolumnType = ?';
    final list = await db?.rawQuery(sql, ['task']);
    return list
            ?.map(
              (e) => TagModel.fromObjectDb(e),
            )
            .toList() ??
        [];
  }

  Future<int> getCountTasksPending() async {
    String sql =
        'SELECT COUNT(*) FROM $tasktable WHERE $taskcolumnFinished = ?';
    final result = await db?.rawQuery(sql, [0]);
    int count = 0;
    if (result != null && result.isNotEmpty) {
      count = result.first.values.first as int;
    }
    return count;
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
