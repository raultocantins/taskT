import 'package:task_planner/src/features/tasks/data/datasources/get_tasks_datasource.dart';
import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/repositories/get_tasks_repository.dart';

class GetTasksRepositoryImpl implements GetTasksRepository {
  final GetTasksDatasource _getTasksDatasource;
  const GetTasksRepositoryImpl(this._getTasksDatasource);
  @override
  Future<Either<Exception, List<TaskEntity>>> call(
      {DateTime? date, int? tagId, bool? done}) async {
    try {
      List<TaskModel> result =
          await _getTasksDatasource(date: date, tagId: tagId, done: done);
      return Right(result.map((e) => TaskModel.toEntity(e)).toList());
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
