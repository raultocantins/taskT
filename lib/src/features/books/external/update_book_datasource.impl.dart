import 'package:task_planner/src/features/books/data/datasources/update_book_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/book_state_enum.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';

class UpdateBookDatasourceImpl implements UpdateBookDatasource {
  @override
  Future<BookModel> call(BookEntity task) async {
    try {
      // TaskModel taskAdded =
      //     await GetIt.I.get<DataBaseCustom>().updateTask(task);
      return BookModel(
          title: '',
          author: '',
          star: 1,
          bookState: BookState.initial,
          currentPage: 0,
          finalPage: 1,
          tagBook: TagBook.all);
    } catch (e) {
      throw Exception(e);
    }
  }
}
