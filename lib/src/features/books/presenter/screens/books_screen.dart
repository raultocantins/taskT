import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/presenter/controllers/books_controller.dart';
import 'package:task_planner/src/features/books/presenter/widgets/book_card_custom.dart';
import 'package:task_planner/src/features/books/presenter/widgets/new_book_bottomsheet.dart';
import 'package:task_planner/src/features/books/presenter/widgets/tags_books.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> opacityAnimation;
  BooksController? _controller;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _controller = GetIt.I.get<BooksController>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    opacityAnimation = CurvedAnimation(
        parent: Tween<double>(begin: 1, end: 0).animate(_animationController),
        curve: Curves.easeInOutExpo);
    _controller?.getBooks();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: const [],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Livros',
                        style: TextStyle(fontSize: 40),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.filter_list_outlined,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Mostrando todos os seus livros',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const TagsBooks(),
                  const SizedBox(
                    height: 14,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _controller?.books.length,
                      itemBuilder: (context, i) => BookCardCustom(
                        book: _controller!.books[i],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                barrierColor: Colors.transparent,
                isDismissible: true,
                enableDrag: true,
                useSafeArea: false,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const NewBookBottomSheet(),
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}