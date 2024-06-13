import 'package:get_it/get_it.dart';
import 'package:task_planner/src/shared/data/datasourcers/create_tag_datasource.dart';
import 'package:task_planner/src/shared/data/models/tag_model.dart';
import 'package:task_planner/src/shared/services/database/db.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

class CreateTagDatasourceImpl implements CreateTagDatasource {
  @override
  Future<TagModel> call({
    required String label,
    required TagType type,
  }) async {
    try {
      final result =
          await GetIt.I.get<DataBaseCustom>().saveTag(label: label, type: type);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
