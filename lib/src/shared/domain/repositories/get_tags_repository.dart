import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';

abstract class GetTagsRepository {
  Future<Either<Exception, List<TagEntity>>> call(TagType? type);
}
