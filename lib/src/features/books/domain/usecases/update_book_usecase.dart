import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/update_book_repository.dart';

abstract class UpdateBookUsecase {
  Future<Either<Exception, BookEntity>> call(BookEntity task);
}

class UpdateBookUsecaseImpl implements UpdateBookUsecase {
  final UpdateBookRepository _updateTaskRepository;
  const UpdateBookUsecaseImpl(this._updateTaskRepository);
  @override
  Future<Either<Exception, BookEntity>> call(BookEntity task) {
    return _updateTaskRepository(task);
  }
}
