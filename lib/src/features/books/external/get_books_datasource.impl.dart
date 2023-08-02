import 'package:task_planner/src/features/books/data/datasources/get_books_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/tasks/presenter/utils/enums/tags_enum.dart';

class GetBooksDatasourceImpl implements GetBooksDatasource {
  @override
  Future<List<BookModel>> call({DateTime? date, Tag? tag, bool? done}) async {
    try {
      // List<TaskModel> tasks = await GetIt.I
      //     .get<DataBaseCustom>()
      //     .getTasks(date: date, tag: tag, done: done);
      return [];
    } catch (e) {
      throw Exception(e);
    }
  }
}
