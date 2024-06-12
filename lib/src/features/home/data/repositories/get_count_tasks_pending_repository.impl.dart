import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/home/data/datasourcers/get_count_tasks_pending_datasource.dart';
import 'package:task_planner/src/features/home/domain/repositories/get_count_tasks_pending_repository.dart';

class GetCountTasksPendingRepositoryImpl
    implements GetCountTasksPendingRepository {
  final GetCountTasksPendingDatasource _getCountTasksPendingDatasource;
  const GetCountTasksPendingRepositoryImpl(
      this._getCountTasksPendingDatasource);
  @override
  Future<Either<Exception, int>> call() async {
    try {
      int result = await _getCountTasksPendingDatasource();
      return Right(result);
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
