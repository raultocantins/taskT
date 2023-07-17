import 'package:dartz/dartz.dart';
import 'package:task_planner/src/features/home/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/home/presenter/utils/enums/tags_enum.dart';

abstract class GetTasksRepository {
  Future<Either<Exception, List<TaskEntity>>> call(
      {DateTime? date, Tag? tag, bool? done});
}
