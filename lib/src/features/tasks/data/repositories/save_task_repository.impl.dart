import 'package:task_planner/src/features/tasks/data/datasources/save_task_datasource.dart';
import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/repositories/save_task_repository.dart';

class SaveTaskRepositoryImpl implements SaveTaskRepository {
  final SaveTaskDatasource _saveTaskDatasource;
  const SaveTaskRepositoryImpl(this._saveTaskDatasource);
  @override
  Future<Either<Exception, TaskEntity>> call(TaskEntity task) async {
    try {
      return Right(TaskModel.toEntity(await _saveTaskDatasource(task)));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
