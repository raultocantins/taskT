// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/book_state_enum.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';

part 'book_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class BookModel {
  final int? id;
  final String title;
  final String author;
  final int star;
  final int currentPage;
  final int finalPage;
  final BookState bookState;
  final TagBook tagBook;
  BookModel(
      {this.id,
      required this.title,
      required this.author,
      required this.star,
      required this.bookState,
      required this.currentPage,
      required this.finalPage,
      required this.tagBook});
  factory BookModel.fromJson(dynamic json) => _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);

  Map<String, dynamic> toMap() => {
        'title': title,
        'author': author,
        'star': star,
        'currentpage': currentPage,
        'finalpage': finalPage,
        'bookstate': bookState.fromEnumToString(),
        'tagbook': tagBook.fromEnumToString(),
      };
  static BookModel fromObjectDb(Map<String, dynamic> book) {
    return BookModel(
      id: book['_id'],
      title: book['title'],
      author: book['author'],
      star: book['star'],
      currentPage: book['currentpage'],
      finalPage: book['finalpage'],
      bookState: BookStateExtensions.fromStringToEnum(book['bookstate']),
      tagBook: TagsBookExtensions.fromStringToEnum(book['tagbook']),
    );
  }

  static BookEntity toEntity(BookModel model) {
    return BookEntity(
        id: model.id,
        author: model.author,
        bookState: model.bookState,
        currentPage: model.currentPage,
        finalPage: model.finalPage,
        star: model.star,
        tagBook: model.tagBook,
        title: model.title);
  }

  static BookModel toModel(BookEntity entity) {
    return BookModel(
        id: entity.id,
        author: entity.author,
        bookState: entity.bookState,
        currentPage: entity.currentPage,
        finalPage: entity.finalPage,
        star: entity.star,
        tagBook: entity.tagBook,
        title: entity.title);
  }
}
