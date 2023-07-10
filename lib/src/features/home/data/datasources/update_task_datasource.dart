import 'package:taskt/src/features/home/data/models/task_model.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';

abstract class UpdateTaskDatasource {
  Future<TaskModel> call(TaskEntity task);
}
