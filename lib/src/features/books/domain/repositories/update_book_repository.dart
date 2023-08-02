import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

abstract class UpdateBookRepository {
  Future<Either<Exception, BookEntity>> call(BookEntity task);
}
