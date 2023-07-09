import 'package:get_it/get_it.dart';
import 'package:taskt/src/features/home/data/datasources/delete_task_datasource.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/shared/database/db.dart';

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
