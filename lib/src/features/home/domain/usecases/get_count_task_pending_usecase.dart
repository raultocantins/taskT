import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/home/domain/repositories/get_count_tasks_pending_repository.dart';

abstract class GetCountTasksPendingUsecase {
  Future<Either<Exception, int>> call();
}

class GetCountTasksPendingUsecaseImpl implements GetCountTasksPendingUsecase {
  final GetCountTasksPendingRepository _getCountTasksPendingRepository;
  const GetCountTasksPendingUsecaseImpl(this._getCountTasksPendingRepository);
  @override
  Future<Either<Exception, int>> call() {
    return _getCountTasksPendingRepository();
  }
}
