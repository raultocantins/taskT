import 'package:task_planner/src/features/books/presenter/utils/enums/book_state_enum.dart';

class BookEntity {
  int? id;
  final String title;
  final String author;
  final int star;
  final int currentPage;
  final int finalPage;
  final BookState bookState;
  final int? tagId;
  final bool finished;
  final DateTime? endDate;
  BookEntity(
      {this.id,
      required this.title,
      required this.author,
      required this.star,
      required this.bookState,
      required this.currentPage,
      required this.finalPage,
      required this.finished,
      this.endDate,
      this.tagId});
}
