import 'package:task_planner/src/features/home/data/models/task_model.dart';
import 'package:task_planner/src/features/home/presenter/utils/enums/tags_enum.dart';

abstract class GetTasksDatasource {
  Future<List<TaskModel>> call({DateTime? date, Tag? tag, bool? done});
}
