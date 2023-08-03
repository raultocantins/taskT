import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';

abstract class GetBooksDatasource {
  Future<List<BookModel>> call({TagBook? tag, bool? done});
}
