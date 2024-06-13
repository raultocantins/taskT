import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/domain/repositories/create_tag_repository.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

abstract class CreateTagUsecase {
  Future<Either<Exception, TagEntity>> call({
    required String label,
    required TagType type,
  });
}

class CreateTagUsecaseImpl implements CreateTagUsecase {
  final CreateTagRepository _createTagRepository;
  const CreateTagUsecaseImpl(this._createTagRepository);
  @override
  Future<Either<Exception, TagEntity>> call({
    required String label,
    required TagType type,
  }) {
    return _createTagRepository(label: label, type: type);
  }
}
