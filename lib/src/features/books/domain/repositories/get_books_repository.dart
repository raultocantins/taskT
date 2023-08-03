import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';

abstract class GetBooksRepository {
  Future<Either<Exception, List<BookEntity>>> call({TagBook? tag, bool? done});
}
