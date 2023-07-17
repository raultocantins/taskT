import 'package:task_planner/src/features/home/domain/entities/task_entity.dart';

abstract class DeleteTaskDatasource {
  Future<void> call(TaskEntity task);
}
