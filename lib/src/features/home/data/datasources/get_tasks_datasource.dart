import 'package:taskt/src/features/home/data/models/task_model.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';

abstract class GetTasksDatasource {
  Future<List<TaskModel>> call({required DateTime date, required Tag tag});
}
