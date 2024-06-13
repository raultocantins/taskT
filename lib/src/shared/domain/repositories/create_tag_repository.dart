import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

abstract class CreateTagRepository {
  Future<Either<Exception, TagEntity>> call({
    required String label,
    required TagType type,
  });
}
