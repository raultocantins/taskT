// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

class BookCardCustom extends StatefulWidget {
  final BookEntity book;

  const BookCardCustom({
    super.key,
    required this.book,
  });

  @override
  State<BookCardCustom> createState() => _BookCardCustomState();
}

class _BookCardCustomState extends State<BookCardCustom> {
  final List<int> stars = [0, 1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          title: Text(widget.book.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.book.author),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: stars.map(
                  (e) {
                    if (widget.book.star > e) {
                      return const Icon(
                        Icons.star,
                        size: 15,
                      );
                    } else {
                      return Icon(Icons.star,
                          size: 15, color: Colors.grey.withOpacity(0.3));
                    }
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: widget.book.currentPage / widget.book.finalPage,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      '${(widget.book.currentPage / widget.book.finalPage * 100).toInt()}%'),
                ],
              ),
            ],
          ),
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.book,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
