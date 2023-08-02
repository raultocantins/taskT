import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

abstract class UpdateBookDatasource {
  Future<BookModel> call(BookEntity task);
}
