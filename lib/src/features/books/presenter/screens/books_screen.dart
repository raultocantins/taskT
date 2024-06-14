import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/books/presenter/controllers/books_controller.dart';
import 'package:task_planner/src/features/books/presenter/widgets/card_custom_book_widget.dart';
import 'package:task_planner/src/features/books/presenter/widgets/new_book_bottomsheet.dart';
import 'package:task_planner/src/features/home/presentation/controllers/home_controller.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';
import 'package:task_planner/src/shared/widgets/tags_custom_widget.dart';

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
    GetIt.I.get<HomeController>().getCountBooksInprogress();
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
            backgroundColor: Theme.of(context).colorScheme.background,
            forceMaterialTransparency: true,
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Text(
                        'Livros',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.filter_list_outlined,
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Text(
                    'Pendentes e concluídos.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: TagsCustom(
                    onTap: (id) => _controller?.changeTag(id),
                    tagId: _controller?.tagId,
                    tagType: TagType.book,
                    tagRemoved: (id) => _controller?.removeWithTag(id),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                    child: ListView.builder(
                      itemCount: _controller?.books.length,
                      itemBuilder: (context, i) => CardCustomBookWidget(
                        book: _controller!.books[i],
                        delete: (v) => _controller?.deleteBook(v),
                        update: (v) => _controller?.updateBook(v),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                enableDrag: true,
                useSafeArea: true,
                context: context,
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 0,
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
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
