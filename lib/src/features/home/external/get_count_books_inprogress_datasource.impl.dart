import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/home/data/datasourcers/get_count_books_inprogress_datasource.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class GetCountBooksInprogressDatasourceImpl
    implements GetCountBooksInprogressDatasource {
  @override
  Future<int> call() async {
    try {
      final count =
          await GetIt.I.get<DataBaseCustom>().getCountBooksInProgress();
      return count;
    } catch (e) {
      throw Exception(e);
    }
  }
}
