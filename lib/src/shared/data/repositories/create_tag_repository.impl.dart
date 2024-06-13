import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/data/datasourcers/create_tag_datasource.dart';
import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/domain/repositories/create_tag_repository.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

class CreateTagRepositoryImpl implements CreateTagRepository {
  final CreateTagDatasource _createTagDatasource;
  const CreateTagRepositoryImpl(this._createTagDatasource);
  @override
  Future<Either<Exception, TagEntity>> call({
    required String label,
    required TagType type,
  }) async {
    try {
      final result = await _createTagDatasource(label: label, type: type);
      return Right(TagModel.toEntity(result));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
