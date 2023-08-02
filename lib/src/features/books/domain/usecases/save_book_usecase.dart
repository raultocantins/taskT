import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/save_book_repository.dart';

abstract class SaveBookUsecase {
  Future<Either<Exception, BookEntity>> call(BookEntity task);
}

class SaveBookUsecaseImpl implements SaveBookUsecase {
  final SaveBookRepository _saveTaskRepository;
  const SaveBookUsecaseImpl(this._saveTaskRepository);
  @override
  Future<Either<Exception, BookEntity>> call(BookEntity task) {
    return _saveTaskRepository(task);
  }
}
