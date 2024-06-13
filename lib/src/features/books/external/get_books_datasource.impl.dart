import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/data/datasources/get_books_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class GetBooksDatasourceImpl implements GetBooksDatasource {
  @override
  Future<List<BookModel>> call({int? tagId, bool? done}) async {
    try {
      List<BookModel> tasks =
          await GetIt.I.get<DataBaseCustom>().getBooks(tagId: tagId);
      return tasks;
    } catch (e) {
      throw Exception(e);
    }
  }
}
