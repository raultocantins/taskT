import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

abstract class GetBooksRepository {
  Future<Either<Exception, List<BookEntity>>> call({int? tagId, bool? done});
}
