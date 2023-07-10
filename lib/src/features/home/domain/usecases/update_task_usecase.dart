import 'package:dartz/dartz.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/domain/repositories/update_task_repository.dart';

abstract class UpdateTaskUsecase {
  Future<Either<Exception, TaskEntity>> call(TaskEntity task);
}

class UpdateTaskUsecaseImpl implements UpdateTaskUsecase {
  final UpdateTaskRepository _updateTaskRepository;
  const UpdateTaskUsecaseImpl(this._updateTaskRepository);
  @override
  Future<Either<Exception, TaskEntity>> call(TaskEntity task) {
    return _updateTaskRepository(task);
  }
}
