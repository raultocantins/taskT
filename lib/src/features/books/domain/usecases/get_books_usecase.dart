import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/get_books_repository.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';

abstract class GetBooksUsecase {
  Future<Either<Exception, List<BookEntity>>> call({TagBook? tag, bool? done});
}

class GetBooksUsecaseImpl implements GetBooksUsecase {
  final GetBooksRepository _getTasksRepository;
  const GetBooksUsecaseImpl(this._getTasksRepository);
  @override
  Future<Either<Exception, List<BookEntity>>> call({TagBook? tag, bool? done}) {
    return _getTasksRepository(tag: tag, done: done);
  }
}
