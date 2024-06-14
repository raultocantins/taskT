import 'package:flutter/material.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/book_state_enum.dart';
import 'package:task_planner/src/features/books/presenter/widgets/book_card_custom.dart';
import 'package:task_planner/src/features/books/presenter/widgets/new_book_bottomsheet.dart';
import 'package:intl/intl.dart';

class CardCustomBookWidget extends StatefulWidget {
  final BookEntity book;
  final Function(BookEntity book) delete;
  final Function(BookEntity book) update;

  const CardCustomBookWidget(
      {required this.book,
      required this.delete,
      required this.update,
      super.key});

  @override
  State<CardCustomBookWidget> createState() => _CardCustomBookWidgetState();
}

class _CardCustomBookWidgetState extends State<CardCustomBookWidget> {
  String shortTitle(String text) {
    return text.length > 25 ? '${text.substring(0, 25)}...' : text;
  }

  String shortText(String text) {
    return text.length > 80 ? '${text.substring(0, 80)}...' : text;
  }

  String getTimeDate(DateTime? date) {
    return DateFormat('HH:mm').format(date?.toLocal() ?? DateTime.now());
  }

  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: expanded
          ? SizedBox(
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 24, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.book.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            expanded
                                ? widget.book.author
                                : shortText(widget.book.author),
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.book.finished
                              ? Container()
                              : SizedBox(
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Transform.scale(
                                        scale: 1.3,
                                        child: Checkbox(
                                          shape: const OvalBorder(),
                                          side: const BorderSide(),
                                          value: false,
                                          onChanged: (value) {
                                            widget.update(
                                              BookEntity(
                                                id: widget.book.id,
                                                title: widget.book.title,
                                                author: widget.book.author,
                                                bookState: BookState.finished,
                                                currentPage:
                                                    widget.book.finalPage,
                                                finalPage:
                                                    widget.book.finalPage,
                                                star: widget.book.star,
                                                tagId: widget.book.tagId,
                                                finished: true,
                                                endDate: DateTime.now(),
                                              ),
                                            );
                                            setState(() {
                                              expanded = !expanded;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          widget.book.finished
                              ? Container()
                              : IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      enableDrag: true,
                                      useSafeArea: true,
                                      context: context,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      elevation: 0,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: NewBookBottomSheet(
                                            edit: true,
                                            book: widget.book,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                          IconButton(
                            onPressed: () {
                              widget.delete(widget.book);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 24,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : BookCardCustom(book: widget.book),
    );
  }
}
