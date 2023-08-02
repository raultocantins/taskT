import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/tasks/presenter/utils/enums/tags_enum.dart';

abstract class GetBooksRepository {
  Future<Either<Exception, List<BookEntity>>> call(
      {DateTime? date, Tag? tag, bool? done});
}
