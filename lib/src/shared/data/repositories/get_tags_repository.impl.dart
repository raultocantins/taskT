import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/data/datasourcers/get_tags_datasource.dart';
import 'package:task_planner/src/shared/domain/repositories/get_tags_repository.dart';
import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';

class GetTagsRepositoryImpl implements GetTagsRepository {
  final GetTagsDatasource _getTagsDatasource;
  const GetTagsRepositoryImpl(this._getTagsDatasource);
  @override
  Future<Either<Exception, List<TagEntity>>> call(TagType? type) async {
    try {
      List<TagModel> result = await _getTagsDatasource(type);
      return Right(result.map((e) => TagModel.toEntity(e)).toList());
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
