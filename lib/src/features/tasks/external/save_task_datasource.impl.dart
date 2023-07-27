import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/tasks/data/datasources/save_task_datasource.dart';
import 'package:task_planner/src/features/tasks/data/models/task_model.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class SaveTaskDatasourceImpl implements SaveTaskDatasource {
  @override
  Future<TaskModel> call(TaskEntity task) async {
    try {
      TaskModel taskAdded = await GetIt.I.get<DataBaseCustom>().saveTask(task);
      return taskAdded;
    } catch (e) {
      throw Exception(e);
    }
  }
}
