import 'package:taskt/src/features/home/domain/entities/task_entity.dart';

abstract class DeleteTaskDatasource {
  Future<void> call(TaskEntity task);
}
