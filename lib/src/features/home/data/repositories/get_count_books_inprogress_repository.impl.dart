import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/home/data/datasourcers/get_count_books_inprogress_datasource.dart';

import 'package:task_planner/src/features/home/domain/repositories/get_count_books_inprogress_repository.dart';

class GetCountBooksInprogressRepositoryImpl
    implements GetCountBooksInprogressRepository {
  final GetCountBooksInprogressDatasource _getCountBooksInprogressDatasource;
  const GetCountBooksInprogressRepositoryImpl(
      this._getCountBooksInprogressDatasource);
  @override
  Future<Either<Exception, int>> call() async {
    try {
      int result = await _getCountBooksInprogressDatasource();
      return Right(result);
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
