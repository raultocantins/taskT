import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/data/datasources/get_books_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class GetBooksDatasourceImpl implements GetBooksDatasource {
  @override
  Future<List<BookModel>> call({TagBook? tag, bool? done}) async {
    try {
      List<BookModel> books =
          await GetIt.I.get<DataBaseCustom>().getBooks(tag: tag, done: done);
      return books;
    } catch (e) {
      throw Exception(e);
    }
  }
}
