import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

abstract class DeleteBookRepository {
  Future<Either<Exception, void>> call(BookEntity task);
}
