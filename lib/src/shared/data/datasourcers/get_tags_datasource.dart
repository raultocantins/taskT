import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

abstract class GetTagsDatasource {
  Future<List<TagModel>> call(TagType type);
}
