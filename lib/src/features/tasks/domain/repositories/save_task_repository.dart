import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';

abstract class SaveTaskRepository {
  Future<Either<Exception, TaskEntity>> call(TaskEntity task);
}
