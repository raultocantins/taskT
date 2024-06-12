import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/data/datasourcers/delete_tag_datasource.dart';
import 'package:task_planner/src/shared/domain/repositories/delete_tag_repository.dart';

class DeleteTagRepositoryImpl implements DeleteTagRepository {
  final DeleteTagDatasource _deleteTagDatasource;
  const DeleteTagRepositoryImpl(this._deleteTagDatasource);
  @override
  Future<Either<Exception, void>> call(int id) async {
    try {
      await _deleteTagDatasource(id);
      // ignore: void_checks
      return const Right(unit);
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
