import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';

abstract class GetTasksRepository {
  Future<Either<Exception, List<TaskEntity>>> call(
      {DateTime? date, int? tagId, bool? done});
}
