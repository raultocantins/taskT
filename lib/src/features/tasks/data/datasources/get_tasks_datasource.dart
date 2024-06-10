import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/tags_enum.dart';

abstract class GetTasksDatasource {
  Future<List<TaskModel>> call({DateTime? date, Tag? tag, bool? done});
}
