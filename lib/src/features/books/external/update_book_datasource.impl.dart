import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/data/datasources/update_book_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class UpdateBookDatasourceImpl implements UpdateBookDatasource {
  @override
  Future<BookModel> call(BookEntity book) async {
    try {
      BookModel bookAdded =
          await GetIt.I.get<DataBaseCustom>().updateBook(book);
      return bookAdded;
    } catch (e) {
      throw Exception(e);
    }
  }
}
