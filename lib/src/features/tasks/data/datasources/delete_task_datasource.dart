import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';

abstract class DeleteTaskDatasource {
  Future<void> call(TaskEntity task);
}
