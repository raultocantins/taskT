import 'package:task_planner/src/shared/data/datasourcers/get_tags_datasource.dart';
import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';

class GetTagsDatasourceImpl implements GetTagsDatasource {
  @override
  Future<List<TagModel>> call(TagType? type) async {
    try {
      // List<TaskModel> tasks = await GetIt.I
      //     .get<DataBaseCustom>()
      //     .getTasks(date: date, tag: Tag.all, done: done);
      return [];
    } catch (e) {
      throw Exception(e);
    }
  }
}
