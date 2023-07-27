import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/tasks/data/datasources/delete_task_datasource.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class DeleteTaskDatasourceImpl implements DeleteTaskDatasource {
  @override
  Future<void> call(TaskEntity task) async {
    try {
      await GetIt.I.get<DataBaseCustom>().deleteTask(task.id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
