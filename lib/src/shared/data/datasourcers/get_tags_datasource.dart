import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';

abstract class GetTagsDatasource {
  Future<List<TagModel>> call(TagType? type);
}
