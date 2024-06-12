import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/home/data/datasourcers/get_count_tasks_pending_datasource.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class GetCountTasksPendingDatasourceImpl
    implements GetCountTasksPendingDatasource {
  @override
  Future<int> call() async {
    try {
      final count = await GetIt.I.get<DataBaseCustom>().getCountTasksPending();
      return count;
    } catch (e) {
      throw Exception(e);
    }
  }
}
