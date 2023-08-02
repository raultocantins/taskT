import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/delete_book_repository.dart';

abstract class DeleteBookUsecase {
  Future<Either<Exception, void>> call(BookEntity task);
}

class DeleteBookUsecaseImpl implements DeleteBookUsecase {
  final DeleteBookRepository _deleteTaskRepository;
  const DeleteBookUsecaseImpl(this._deleteTaskRepository);
  @override
  Future<Either<Exception, void>> call(BookEntity task) {
    return _deleteTaskRepository(task);
  }
}
