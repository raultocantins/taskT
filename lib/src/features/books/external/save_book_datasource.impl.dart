import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/data/datasources/save_book_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class SaveBookDatasourceImpl implements SaveBookDatasource {
  @override
  Future<BookModel> call(BookEntity book) async {
    try {
      BookModel taskAdded = await GetIt.I.get<DataBaseCustom>().saveBook(book);
      return taskAdded;
    } catch (e) {
      throw Exception(e);
    }
  }
}
