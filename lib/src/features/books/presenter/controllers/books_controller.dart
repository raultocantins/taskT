import 'package:mobx/mobx.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/usecases/delete_book_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/get_books_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/save_book_usecase.dart';
import 'package:task_planner/src/features/books/domain/usecases/update_book_usecase.dart';
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
  bool isLoading = false;

  @observable
  int? tagId;

  @observable
  List<BookEntity> books = [];

  @action
  void changeBooks(List<BookEntity> value) {
    books = value;
  }

  @action
  void changeTag(int? value) {
    tagId = value;
    getBooks();
  }

  @action
  void changeIsLoading(bool value) {
    isLoading = value;
  }

  Future<void> getBooks() async {
    changeIsLoading(true);
    var result = await _getBooksUsecase(tagId: tagId, done: false);
    result.fold(
      (l) => null,
      (r) {
        changeBooks(r);
      },
    );
    changeIsLoading(false);
  }

  Future<void> createBook(BookEntity book) async {
    changeIsLoading(true);
    var result = await _saveBookUsecase(book);
    result.fold(
      (l) => null,
      (r) {
        if (tagId == null) {
          changeBooks([...books, r]);
        } else if (book.tagId == tagId) {
          changeBooks([...books, r]);
        }
      },
    );
    changeIsLoading(false);
  }

  Future<void> deleteBook(BookEntity book) async {
    changeIsLoading(true);
    var result = await _deleteBookUsecase(book);
    result.fold(
      (l) => null,
      (_) {
        List<BookEntity> updatedList = books;
        updatedList.removeWhere((element) => element.id == book.id);
        changeBooks([...updatedList]);
      },
    );
    changeIsLoading(false);
  }

  Future<void> updateBook(BookEntity book) async {
    changeIsLoading(true);
    var result = await _updateBookUsecase(book);
    result.fold(
      (l) => null,
      (updatedBook) {
        List<BookEntity> updatedList = books;

        if (tagId == null) {
          for (int i = 0; i < updatedList.length; i++) {
            if (updatedList[i].id == updatedBook.id) {
              updatedList[i] = updatedBook;
              break;
            }
          }
          changeBooks([...updatedList]);
        } else if (updatedBook.tagId == tagId) {
          for (int i = 0; i < updatedList.length; i++) {
            if (updatedList[i].id == updatedBook.id) {
              updatedList[i] = updatedBook;
              break;
            }
          }
          changeBooks([...updatedList]);
        }
      },
    );
    changeIsLoading(false);
  }

  Future<void> removeWithTag(int id) async {
    List<BookEntity> updatedList = books;
    updatedList.removeWhere((element) => element.tagId == id);
    changeBooks([...updatedList]);
  }

  void dispose() {
    isLoading = false;
    tagId = null;
    books = [];
  }
}
