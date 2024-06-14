// ignore: depend_on_referenced_packages
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/book_state_enum.dart';
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
        onConfigure: (Database db) async {
          // Habilitar suporte a chaves estrangeiras
          await db.execute('PRAGMA foreign_keys = ON');
        },
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
    // Verifica se existem as tabelas, e apaga caso existam
    await db.execute('DROP TABLE IF EXISTS $tasktable');
    await db.execute('DROP TABLE IF EXISTS $tagstable');

    // Criação das tabelas
    await db.execute(
      'CREATE TABLE $tagstable('
      '$tagscolumnId INTEGER PRIMARY KEY, '
      '$tagscolumnLabel TEXT, '
      '$tagscolumnType TEXT)',
    );

    await db.execute(
      'CREATE TABLE $tasktable('
      '$taskcolumnId INTEGER PRIMARY KEY, '
      '$taskcolumnTitle TEXT, '
      '$taskcolumnDate INTEGER, '
      '$taskcolumnDescription TEXT, '
      '$taskcolumnFinished INTEGER, '
      '$taskcolumnTagId INTEGER, '
      '$taskcolumnPriority TEXT, '
      '$taskcolumnUpdated INTEGER, '
      'FOREIGN KEY($taskcolumnTagId) REFERENCES $tagstable($tagscolumnId) ON DELETE CASCADE)',
    );

    await db.execute(
      'CREATE TABLE $bookstable('
      '$bookscolumnId INTEGER PRIMARY KEY, '
      '$bookscolumnTitle TEXT, '
      '$bookscolumnAuthor TEXT, '
      '$bookscolumnStar INTEGER, '
      '$bookscolumnCurrentpage INTEGER, '
      '$bookscolumnFinalpage INTEGER, '
      '$bookscolumnBookstate TEXT, '
      '$bookscolumnTagId INTEGER, '
      'FOREIGN KEY($bookscolumnTagId) REFERENCES $tagstable($tagscolumnId) ON DELETE CASCADE)',
    );

    // Adiciona um índice na tabela tasks
    await db.execute(
      'CREATE INDEX TasksUpdated ON $tasktable ($taskcolumnUpdated)',
    );

    // Insere itens na tabela tags recém-criada
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
      [3, 'Ficção', 'book'],
    );
    await db.rawInsert(
      'INSERT INTO $tagstable($tagscolumnId, $tagscolumnLabel, $tagscolumnType) VALUES(?, ?, ?)',
      [4, 'Ciência e Tecnologia', 'book'],
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

  Future<BookModel> saveBook(BookEntity bookEntity) async {
    int newId =
        await db!.insert(bookstable, BookModel.toModel(bookEntity).toMap());
    return BookModel(
      id: newId,
      tagId: bookEntity.tagId,
      title: bookEntity.title,
      author: bookEntity.author,
      bookState: bookEntity.bookState,
      currentPage: bookEntity.currentPage,
      finalPage: bookEntity.finalPage,
      star: bookEntity.star,
    );
  }

  Future<TagModel> saveTag({
    required String label,
    required TagType type,
  }) async {
    int newId = await db!.insert(tagstable, {
      'label': label,
      'type': type.name,
    });
    return TagModel(newId, label, type: type);
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

  Future<BookModel> updateBook(BookEntity bookEntity) async {
    await db!.update(
      bookstable,
      BookModel.toModel(bookEntity).toMap(),
      where: '$bookscolumnId = ?',
      whereArgs: <Object?>[bookEntity.id],
    );
    return BookModel.toModel(bookEntity);
  }

  Future<void> deleteTask(int? id) async {
    await db!.delete(
      tasktable,
      where: '$taskcolumnId = ?',
      whereArgs: <Object?>[id],
    );
  }

  Future<void> deleteBook(int? id) async {
    await db!.delete(
      bookstable,
      where: '$bookscolumnId = ?',
      whereArgs: <Object?>[id],
    );
  }

  Future<void> deleteTag(int? id) async {
    await db!.delete(
      tagstable,
      where: '$tagscolumnId = ?',
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

  Future<List<BookModel>> getBooks({int? tagId}) async {
    List<Map<String, Object?>>? list;
    String query = 'SELECT * FROM $bookstable WHERE 1=1';
    if (tagId != null) {
      query += ' AND $bookscolumnTagId = $tagId';
    }

    list = await db?.rawQuery(query);
    return list
            ?.map(
              (e) => BookModel.fromObjectDb(e),
            )
            .toList() ??
        [];
  }

  Future<List<TagModel>> getTags(TagType type) async {
    String sql = 'SELECT * FROM $tagstable WHERE $tagscolumnType = ?';
    final list = await db?.rawQuery(sql, [type.name]);
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

  Future<int> getCountBooksInProgress() async {
    String sql =
        'SELECT COUNT(*) FROM $bookstable WHERE $bookscolumnBookstate = ?';
    final result = await db?.rawQuery(sql, [BookState.started.name]);
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
          if (db == null) {
            await open();
          }
          return db;
        },
      );
}
