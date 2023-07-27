import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';

abstract class SaveTaskDatasource {
  Future<TaskModel> call(TaskEntity task);
}
