import 'package:get_it/get_it.dart';
import 'package:task_planner/src/shared/data/datasourcers/delete_tag_datasource.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class DeleteTagDatasourceImpl implements DeleteTagDatasource {
  @override
  Future<void> call(int id) async {
    try {
      await GetIt.I.get<DataBaseCustom>().deleteTag(id);
      return;
    } catch (e) {
      throw Exception(e);
    }
  }
}
