import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/domain/repositories/get_tasks_repository.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/tags_enum.dart';

abstract class GetTasksUsecase {
  Future<Either<Exception, List<TaskEntity>>> call(
      {DateTime? date, Tag? tag, bool? done});
}

class GetTasksUsecaseImpl implements GetTasksUsecase {
  final GetTasksRepository _getTasksRepository;
  const GetTasksUsecaseImpl(this._getTasksRepository);
  @override
  Future<Either<Exception, List<TaskEntity>>> call(
      {DateTime? date, Tag? tag, bool? done}) {
    return _getTasksRepository(date: date, tag: tag, done: done);
  }
}
