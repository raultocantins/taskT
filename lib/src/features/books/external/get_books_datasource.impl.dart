import 'package:task_planner/src/features/books/data/datasources/get_books_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';

class GetBooksDatasourceImpl implements GetBooksDatasource {
  @override
  Future<List<BookModel>> call({TagBook? tag, bool? done}) async {
    try {
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }
}
