import 'package:dartz/dartz.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/domain/repositories/save_task_repository.dart';

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
