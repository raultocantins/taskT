import 'package:task_planner/src/features/home/data/models/task_model.dart';
import 'package:task_planner/src/features/home/domain/entities/task_entity.dart';

abstract class SaveTaskDatasource {
  Future<TaskModel> call(TaskEntity task);
}
