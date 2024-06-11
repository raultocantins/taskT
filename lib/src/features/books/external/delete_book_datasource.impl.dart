import 'package:task_planner/src/features/books/data/datasources/delete_book_datasource.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

class DeleteBookDatasourceImpl implements DeleteBookDatasource {
  @override
  Future<void> call(BookEntity book) async {
    try {
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }
}
