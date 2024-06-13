import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/home/domain/repositories/get_count_books_inprogress_repository.dart';

abstract class GetCountBooksInprogressUsecase {
  Future<Either<Exception, int>> call();
}

class GetCountBooksInprogressUsecaseImpl
    implements GetCountBooksInprogressUsecase {
  final GetCountBooksInprogressRepository _getCountBooksInprogressRepository;
  const GetCountBooksInprogressUsecaseImpl(
      this._getCountBooksInprogressRepository);
  @override
  Future<Either<Exception, int>> call() {
    return _getCountBooksInprogressRepository();
  }
}
