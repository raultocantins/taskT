import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';

abstract class UpdateTaskRepository {
  Future<Either<Exception, TaskEntity>> call(TaskEntity task);
}
