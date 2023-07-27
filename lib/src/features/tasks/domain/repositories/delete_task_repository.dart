import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';

abstract class DeleteTaskRepository {
  Future<Either<Exception, void>> call(TaskEntity task);
}
