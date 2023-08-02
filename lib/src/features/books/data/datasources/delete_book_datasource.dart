import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

abstract class DeleteBookDatasource {
  Future<void> call(BookEntity task);
}
