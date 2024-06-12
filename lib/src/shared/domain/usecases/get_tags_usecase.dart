import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/domain/repositories/get_tags_repository.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

abstract class GetTagsUsecase {
  Future<Either<Exception, List<TagEntity>>> call(TagType type);
}

class GetTagsUsecaseImpl implements GetTagsUsecase {
  final GetTagsRepository _getTagsRepository;
  const GetTagsUsecaseImpl(this._getTagsRepository);
  @override
  Future<Either<Exception, List<TagEntity>>> call(TagType type) {
    return _getTagsRepository(type);
  }
}
