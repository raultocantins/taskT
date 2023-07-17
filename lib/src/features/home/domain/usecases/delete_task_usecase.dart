import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/home/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/home/domain/repositories/delete_task_repository.dart';

abstract class DeleteTaskUsecase {
  Future<Either<Exception, void>> call(TaskEntity task);
}

class DeleteTaskUsecaseImpl implements DeleteTaskUsecase {
  final DeleteTaskRepository _deleteTaskRepository;
  const DeleteTaskUsecaseImpl(this._deleteTaskRepository);
  @override
  Future<Either<Exception, void>> call(TaskEntity task) {
    return _deleteTaskRepository(task);
  }
}
