import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/tasks/presenter/utils/enums/tags_enum.dart';

abstract class GetBooksDatasource {
  Future<List<BookModel>> call({DateTime? date, Tag? tag, bool? done});
}
