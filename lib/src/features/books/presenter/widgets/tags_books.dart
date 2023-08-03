import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/presenter/controllers/books_controller.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';

class TagsBooks extends StatefulWidget {
  static final List<TagBook> tags = [
    TagBook.all,
    TagBook.fantasy,
    TagBook.action,
  ];
  const TagsBooks({super.key});

  @override
  State<TagsBooks> createState() => _TagsCustomState();
}

class _TagsCustomState extends State<TagsBooks> {
  BooksController? _controller;

  @override
  void initState() {
    _controller = GetIt.I.get<BooksController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: TagsBooks.tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () => _controller?.changeTag(TagsBooks.tags[index]),
              child: Observer(
                builder: (context) {
                  return Chip(
                    backgroundColor: _controller?.tag == TagsBooks.tags[index]
                        ? Colors.white
                        : null,
                    elevation: 0.5,
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    label: Text(
                      TagsBooks.tags[index].label(context),
                      style: TextStyle(
                          color: _controller?.tag == TagsBooks.tags[index]
                              ? Colors.black
                              : null),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
