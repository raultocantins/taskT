// ignore: depend_on_referenced_packages
// ignore_for_file: lines_longer_than_80_chars

import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/tags_enum.dart';
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
    await db.execute('DROP TABLE If EXISTS $tasktable');
    await db.execute('DROP TABLE If EXISTS $booktable');
    await db.execute(
      'CREATE TABLE $tasktable($taskcolumnId INTEGER PRIMARY KEY, $taskcolumnTitle TEXT, $taskcolumnDate TEXT, $taskcolumnHours TEXT, $taskcolumnDescription TEXT, $taskcolumnFinished INTEGER,  $taskcolumnTag TEXT, $taskcolumnRecurrence TEXT, $taskcolumnPriority TEXT, $taskcolumnUpdated INTEGER)',
    );
    await db.execute(
      'CREATE TABLE $booktable($bookcolumnId INTEGER PRIMARY KEY, $bookcolumnTitle TEXT, $bookcolumnAuthor TEXT, $bookcolumnStar INTEGER, $bookcolumnCurrentPage INTEGER, $bookcolumnFinalPage INTEGER, $bookcolumnBookState TEXT, $bookcolumnTagBook TEXT, $bookcolumnUpdated INTEGER)',
    );
    await db.execute(
      'CREATE INDEX TasksUpdated ON $tasktable ($taskcolumnUpdated)',
    );
    await db.execute(
      'CREATE INDEX BooksUpdated ON $booktable ($bookcolumnUpdated)',
    );
  }

  Future<TaskModel> saveTask(TaskEntity taskEntity) async {
    int newId =
        await db!.insert(tasktable, TaskModel.toModel(taskEntity).toMap());
    return TaskModel(
      id: newId,
      date: taskEntity.date,
      hours: taskEntity.hours,
      description: taskEntity.description,
      finished: taskEntity.finished,
      priority: taskEntity.priority,
      tag: taskEntity.tag,
      recurrence: taskEntity.recurrence,
      title: taskEntity.title,
    );
  }

  Future<BookModel> saveBook(BookEntity bookEntity) async {
    int newId =
        await db!.insert(booktable, BookModel.toModel(bookEntity).toMap());
    return BookModel(
        id: newId,
        author: bookEntity.author,
        bookState: bookEntity.bookState,
        currentPage: bookEntity.currentPage,
        finalPage: bookEntity.finalPage,
        star: bookEntity.star,
        tagBook: bookEntity.tagBook,
        title: bookEntity.title);
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
      booktable,
      BookModel.toModel(bookEntity).toMap(),
      where: '$bookcolumnId = ?',
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
      booktable,
      where: '$bookcolumnId = ?',
      whereArgs: <Object?>[id],
    );
  }

  Future<List<TaskModel>> getTasks(
      {DateTime? date, Tag? tag, bool? done}) async {
    List<Map<String, Object?>> list;
    if (tag == Tag.all && date == null) {
      list = await db!.query(
        tasktable,
        columns: [
          taskcolumnDate,
          taskcolumnHours,
          taskcolumnTag,
          taskcolumnRecurrence,
          taskcolumnDescription,
          taskcolumnFinished,
          taskcolumnId,
          taskcolumnPriority,
          taskcolumnTag,
          taskcolumnTitle,
          taskcolumnUpdated
        ],
        orderBy: '$taskcolumnUpdated DESC',
        where: '$taskcolumnFinished = ?',
        whereArgs: <Object?>[(done ?? false) ? 1 : 0],
      );
    } else {
      if (date == null) {
        list = await db!.query(
          tasktable,
          columns: [
            taskcolumnDate,
            taskcolumnHours,
            taskcolumnTag,
            taskcolumnRecurrence,
            taskcolumnDescription,
            taskcolumnFinished,
            taskcolumnId,
            taskcolumnPriority,
            taskcolumnTag,
            taskcolumnTitle,
            taskcolumnUpdated
          ],
          orderBy: '$taskcolumnUpdated DESC',
          where: '$taskcolumnTag = ? AND $taskcolumnFinished = ?',
          whereArgs: <Object?>[
            tag?.fromEnumToString(),
            (done ?? false) ? 1 : 0
          ],
        );
      } else {
        if (tag == Tag.all) {
          list = await db!.query(
            tasktable,
            columns: [
              taskcolumnDate,
              taskcolumnHours,
              taskcolumnTag,
              taskcolumnRecurrence,
              taskcolumnDescription,
              taskcolumnFinished,
              taskcolumnId,
              taskcolumnPriority,
              taskcolumnTag,
              taskcolumnTitle,
              taskcolumnUpdated
            ],
            orderBy: '$taskcolumnUpdated DESC',
            where:
                '$taskcolumnDate BETWEEN ? AND ? AND $taskcolumnFinished = ?',
            whereArgs: <Object?>[
              DateTime(date.year, date.month, date.day).toIso8601String(),
              DateTime(date.year, date.month, date.day, 23, 59, 59)
                  .toIso8601String(),
              (done ?? false) ? 1 : 0
            ],
          );
        } else {
          list = await db!.query(
            tasktable,
            columns: [
              taskcolumnDate,
              taskcolumnHours,
              taskcolumnTag,
              taskcolumnRecurrence,
              taskcolumnDescription,
              taskcolumnFinished,
              taskcolumnId,
              taskcolumnPriority,
              taskcolumnTag,
              taskcolumnTitle,
              taskcolumnUpdated
            ],
            orderBy: '$taskcolumnUpdated DESC',
            where:
                '$taskcolumnDate BETWEEN ? AND ? AND $taskcolumnTag = ? AND $taskcolumnFinished = ?',
            whereArgs: <Object?>[
              DateTime(date.year, date.month, date.day).toIso8601String(),
              DateTime(date.year, date.month, date.day, 23, 59, 59)
                  .toIso8601String(),
              tag?.fromEnumToString(),
              (done ?? false) ? 1 : 0
            ],
          );
        }
      }
    }

    return list
        .map(
          (e) => TaskModel.fromObjectDb(e),
        )
        .toList();
  }

  Future<List<BookModel>> getBooks({TagBook? tag, bool? done}) async {
    List<Map<String, Object?>> list;
    if (tag != null && tag != TagBook.all) {
      list = await db!.query(
        booktable,
        columns: [
          bookcolumnTitle,
          bookcolumnAuthor,
          bookcolumnStar,
          bookcolumnCurrentPage,
          bookcolumnFinalPage,
          bookcolumnBookState,
          bookcolumnTagBook,
          bookcolumnUpdated,
        ],
        orderBy: '$bookcolumnUpdated DESC',
        where: '$bookcolumnTagBook = ? ',
        whereArgs: <Object?>[tag.fromEnumToString()],
      );
    } else {
      list = await db!.query(
        booktable,
        columns: [
          bookcolumnTitle,
          bookcolumnAuthor,
          bookcolumnStar,
          bookcolumnCurrentPage,
          bookcolumnFinalPage,
          bookcolumnBookState,
          bookcolumnTagBook,
          bookcolumnUpdated,
        ],
        orderBy: '$bookcolumnUpdated DESC',
      );
    }
    return list
        .map(
          (e) => BookModel.fromObjectDb(e),
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
            const Duration(milliseconds: 1500),
          );
          if (db == null) {
            await open();
          }
          return db;
        },
      );
}
