import 'package:dartz/dartz.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/domain/repositories/get_tasks_repository.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';

abstract class GetTasksUsecase {
  Future<Either<Exception, List<TaskEntity>>> call({DateTime? date, Tag? tag});
}

class GetTasksUsecaseImpl implements GetTasksUsecase {
  final GetTasksRepository _getTasksRepository;
  const GetTasksUsecaseImpl(this._getTasksRepository);
  @override
  Future<Either<Exception, List<TaskEntity>>> call({DateTime? date, Tag? tag}) {
    return _getTasksRepository(date: date, tag: tag);
  }
}
