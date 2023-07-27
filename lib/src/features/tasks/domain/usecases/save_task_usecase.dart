import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/domain/repositories/save_task_repository.dart';

abstract class SaveTaskUsecase {
  Future<Either<Exception, TaskEntity>> call(TaskEntity task);
}

class SaveTaskUsecaseImpl implements SaveTaskUsecase {
  final SaveTaskRepository _saveTaskRepository;
  const SaveTaskUsecaseImpl(this._saveTaskRepository);
  @override
  Future<Either<Exception, TaskEntity>> call(TaskEntity task) {
    return _saveTaskRepository(task);
  }
}
