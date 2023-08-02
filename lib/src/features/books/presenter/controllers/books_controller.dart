import 'package:mobx/mobx.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/usecases/delete_book_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/get_books_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/save_book_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/update_book_usecase.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';
part 'books_controller.g.dart';

// ignore: library_private_types_in_public_api
class BooksController = _BooksControllerBase with _$BooksController;

abstract class _BooksControllerBase with Store {
  final SaveBookUsecase _saveBookUsecase;
  final UpdateBookUsecase _updateBookUsecase;
  final GetBooksUsecase _getBooksUsecase;
  final DeleteBookUsecase _deleteBookUsecase;
  _BooksControllerBase(this._saveBookUsecase, this._getBooksUsecase,
      this._deleteBookUsecase, this._updateBookUsecase);

  @observable
  bool? isLoading = false;

  @observable
  TagBook tag = TagBook.all;

  @observable
  List<BookEntity> _books = [];

  @action
  void changeTag(TagBook value) {
    tag = value;
  }

  @action
  void changeIsLoading(bool value) {
    isLoading = value;
  }

  void dispose() {
    isLoading = false;
    tag = TagBook.all;
    _books = [];
  }
}
