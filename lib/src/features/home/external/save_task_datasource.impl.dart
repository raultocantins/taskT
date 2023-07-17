import 'package:get_it/get_it.dart';
import 'package:taskt/src/features/home/data/datasources/save_task_datasource.dart';
import 'package:taskt/src/features/home/data/models/task_model.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/shared/services/database/db.dart';

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
