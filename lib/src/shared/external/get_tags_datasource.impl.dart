import 'package:get_it/get_it.dart';
import 'package:task_planner/src/shared/data/datasourcers/get_tags_datasource.dart';
import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/services/database/db.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

class GetTagsDatasourceImpl implements GetTagsDatasource {
  @override
  Future<List<TagModel>> call(TagType type) async {
    try {
      List<TagModel> tasks = await GetIt.I.get<DataBaseCustom>().getTags(type);
      return tasks;
    } catch (e) {
      throw Exception(e);
    }
  }
}
