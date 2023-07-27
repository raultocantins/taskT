import 'package:task_planner/src/features/tasks/data/datasources/update_task_datasource.dart';
import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/repositories/update_task_repository.dart';

class UpdateTaskRepositoryImpl implements UpdateTaskRepository {
  final UpdateTaskDatasource _updateTaskDatasource;
  const UpdateTaskRepositoryImpl(this._updateTaskDatasource);
  @override
  Future<Either<Exception, TaskEntity>> call(TaskEntity task) async {
    try {
      return Right(TaskModel.toEntity(await _updateTaskDatasource(task)));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
