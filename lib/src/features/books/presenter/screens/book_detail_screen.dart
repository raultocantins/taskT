// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';

class BookDetailScreen extends StatefulWidget {
  final BookEntity book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.book,
                      child: const Icon(
                        Icons.book,
                        size: 140,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.title,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.book.author,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 24,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              const Row(
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "A book description is a short summary of a book's story or content that is designed to “hook” a reader and lead to a sale. Typically, the book's description conveys important information about its topic or focus (in nonfiction) or the plot and tone (for a novel or any other piece of fiction",
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 48,
              ),
              const Row(
                children: [
                  Text(
                    'Reviews',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 110,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, item) {
                      return const ReviewCard(
                          review:
                              'ótimo livro, estou amando o livro. especialmete sobre as formas que o livro trata sobre produtividade.',
                          reviewerName: 'alex raul',
                          reviewerImg: '');
                    }),
              ),
              const SizedBox(
                height: 48,
              ),
              const Row(
                children: [
                  Text(
                    'Annotations',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 110,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, item) {
                      return const ReviewCard(
                          review:
                              'ótimo livro, estou amando o livro. especialmete sobre as formas que o livro trata sobre produtividade.',
                          reviewerName: 'alex raul',
                          reviewerImg: '');
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.edit_document),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String review;
  final String reviewerName;
  final String reviewerImg;
  const ReviewCard(
      {super.key,
      required this.review,
      required this.reviewerName,
      required this.reviewerImg});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 260,
                      child: Text(
                        review,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
