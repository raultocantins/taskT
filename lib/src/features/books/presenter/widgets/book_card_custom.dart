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
  String shortTitle(String text) {
    return text.length > 25 ? '${text.substring(0, 25)}...' : text;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          shortTitle(widget.book.title),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.book.author,
              style: const TextStyle(fontSize: 13),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: LinearProgressIndicator(
                      value: widget.book.currentPage / widget.book.finalPage,
                      minHeight: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${(widget.book.currentPage / widget.book.finalPage * 100).toInt()}%',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        leading: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.book)],
        ),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
