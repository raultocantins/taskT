import 'package:dartz/dartz.dart';

abstract class DeleteTagRepository {
  Future<Either<Exception, void>> call(int id);
}
