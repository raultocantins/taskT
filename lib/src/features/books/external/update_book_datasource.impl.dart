import 'package:task_planner/src/features/books/data/datasources/update_book_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

class UpdateBookDatasourceImpl implements UpdateBookDatasource {
  @override
  Future<BookModel> call(BookEntity book) async {
    try {
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }
}
