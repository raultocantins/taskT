import 'package:task_planner/src/features/home/data/datasources/delete_task_datasource.dart';
import 'package:task_planner/src/features/home/domain/entities/task_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/home/domain/repositories/delete_task_repository.dart';

class DeleteTaskRepositoryImpl implements DeleteTaskRepository {
  final DeleteTaskDatasource _deleteTaskDatasource;
  const DeleteTaskRepositoryImpl(this._deleteTaskDatasource);
  @override
  Future<Either<Exception, void>> call(TaskEntity task) async {
    try {
      return Right(await _deleteTaskDatasource(task));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
