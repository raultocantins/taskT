import 'package:taskt/src/features/home/data/datasources/update_task_datasource.dart';
import 'package:taskt/src/features/home/data/models/task_model.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:taskt/src/features/home/domain/repositories/update_task_repository.dart';

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
