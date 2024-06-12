import 'package:dartz/dartz.dart';

abstract class GetCountTasksPendingRepository {
  Future<Either<Exception, int>> call();
}
