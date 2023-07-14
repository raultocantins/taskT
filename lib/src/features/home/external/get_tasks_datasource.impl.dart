import 'package:get_it/get_it.dart';
import 'package:taskt/src/features/home/data/datasources/get_tasks_datasource.dart';
import 'package:taskt/src/features/home/data/models/task_model.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';
import 'package:taskt/src/shared/database/db.dart';

class GetTasksDatasourceImpl implements GetTasksDatasource {
  @override
  Future<List<TaskModel>> call({DateTime? date, Tag? tag, bool? done}) async {
    try {
      List<TaskModel> tasks = await GetIt.I
          .get<DataBaseCustom>()
          .getTasks(date: date, tag: tag, done: done);
      return tasks;
    } catch (e) {
      throw Exception(e);
    }
  }
}
