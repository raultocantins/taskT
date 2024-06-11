import 'package:task_planner/src/features/tasks/data/models/task_model.dart';

abstract class GetTasksDatasource {
  Future<List<TaskModel>> call({DateTime? date, int? tagId, bool? done});
}
