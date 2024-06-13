import 'package:task_planner/src/features/books/data/models/book_model.dart';

abstract class GetBooksDatasource {
  Future<List<BookModel>> call({int? tagId, bool? done});
}
