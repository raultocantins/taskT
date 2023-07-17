import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/home/data/datasources/update_task_datasource.dart';
import 'package:task_planner/src/features/home/data/models/task_model.dart';
import 'package:task_planner/src/features/home/domain/entities/task_entity.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class UpdateTaskDatasourceImpl implements UpdateTaskDatasource {
  @override
  Future<TaskModel> call(TaskEntity task) async {
    try {
      TaskModel taskAdded =
          await GetIt.I.get<DataBaseCustom>().updateTask(task);
      return taskAdded;
    } catch (e) {
      throw Exception(e);
    }
  }
}
