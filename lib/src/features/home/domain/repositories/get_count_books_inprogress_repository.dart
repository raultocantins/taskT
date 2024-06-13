import 'package:dartz/dartz.dart';

abstract class GetCountBooksInprogressRepository {
  Future<Either<Exception, int>> call();
}
