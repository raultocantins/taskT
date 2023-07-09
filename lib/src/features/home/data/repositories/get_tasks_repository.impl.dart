import 'package:taskt/src/features/home/data/datasources/get_tasks_datasource.dart';
import 'package:taskt/src/features/home/data/models/task_model.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:taskt/src/features/home/domain/repositories/get_tasks_repository.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';

class GetTasksRepositoryImpl implements GetTasksRepository {
  final GetTasksDatasource _getTasksDatasource;
  const GetTasksRepositoryImpl(this._getTasksDatasource);
  @override
  Future<Either<Exception, List<TaskEntity>>> call(
      {required DateTime date, required Tag tag}) async {
    try {
      List<TaskModel> result = await _getTasksDatasource(date: date, tag: tag);
      return Right(result.map((e) => TaskModel.toEntity(e)).toList());
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
