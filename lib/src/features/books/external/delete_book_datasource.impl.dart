import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/data/datasources/delete_book_datasource.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class DeleteBookDatasourceImpl implements DeleteBookDatasource {
  @override
  Future<void> call(BookEntity book) async {
    try {
      await GetIt.I.get<DataBaseCustom>().deleteTask(book.id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
