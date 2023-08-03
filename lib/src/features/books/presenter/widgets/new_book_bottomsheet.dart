import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/controllers/books_controller.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/book_state_enum.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/tags_books_enum.dart';
import 'package:task_planner/src/features/books/presenter/widgets/tags_books.dart';

class NewBookBottomSheet extends StatefulWidget {
  final bool? edit;
  final BookEntity? book;
  const NewBookBottomSheet({this.edit = false, this.book, super.key});

  @override
  State<NewBookBottomSheet> createState() => _NewBookBottomSheetState();
}

class _NewBookBottomSheetState extends State<NewBookBottomSheet> {
  BooksController? _controller;
  TextEditingController? _titleController;
  TextEditingController? _authorController;
  TextEditingController? _currentPageController;
  TextEditingController? _finalPageController;
  TagBook? _tag;
  FocusNode focusNodeTitle = FocusNode();
  FocusNode focusNodeAuthor = FocusNode();
  FocusNode focusNodeCurrentPage = FocusNode();
  FocusNode focusNodeFinalPage = FocusNode();

  @override
  void initState() {
    _controller = GetIt.I.get<BooksController>();
    setup();
    super.initState();
  }

  void setup() {
    if (widget.edit ?? false) {
      _titleController = TextEditingController(text: widget.book?.title);
      _authorController = TextEditingController(text: widget.book?.author);
      _currentPageController = TextEditingController(
        text: widget.book?.currentPage.toString(),
      );
      _finalPageController = TextEditingController(
        text: widget.book?.finalPage.toString(),
      );
      _tag = widget.book?.tagBook;
    } else {
      _titleController = TextEditingController(text: '');
      _authorController = TextEditingController(text: '');
      _currentPageController = TextEditingController(text: '');
      _finalPageController = TextEditingController(text: '');
      _tag = TagBook.all;
    }
  }

  void updateTag(TagBook tag) {
    setState(() {
      _tag = tag;
    });
  }

  List<TagBook> filterTags(List<TagBook> originalList, TagBook tagToRemove) {
    List<TagBook> updatedList = List.from(originalList);
    updatedList.removeWhere((TagBook item) => item == tagToRemove);
    return updatedList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          focusNodeAuthor.unfocus();
          focusNodeTitle.unfocus();
          focusNodeCurrentPage.unfocus();
          focusNodeFinalPage.unfocus();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                Container(
                  height: 5,
                  width: 30,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: TextSelectionTheme(
                    data: const TextSelectionThemeData(
                      cursorColor: Colors.white,
                    ),
                    child: TextField(
                      controller: _titleController,
                      autofocus: true,
                      focusNode: focusNodeTitle,
                      maxLength: 50,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      decoration: InputDecoration(
                        counterStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                        hintText: 'Título do livro',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 24,
                        ),
                      ),
                      onSubmitted: (v) {
                        focusNodeAuthor.requestFocus();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: TextSelectionTheme(
                    data: const TextSelectionThemeData(
                      cursorColor: Colors.white,
                    ),
                    child: TextField(
                      controller: _authorController,
                      focusNode: focusNodeAuthor,
                      maxLength: 50,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      decoration: InputDecoration(
                        counterStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                        hintText: 'Nome do autor do livro',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 24,
                        ),
                      ),
                      onSubmitted: (v) {
                        focusNodeCurrentPage.requestFocus();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Páginas',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Primeira Página a Ler',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              focusNode: focusNodeCurrentPage,
                              controller: _currentPageController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                              decoration: InputDecoration(
                                counterStyle:
                                    const TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                alignLabelWithHint: true,
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 24,
                                ),
                              ),
                              onSubmitted: (v) {
                                focusNodeFinalPage.requestFocus();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Última Página a Ler',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              focusNode: focusNodeFinalPage,
                              controller: _finalPageController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                              decoration: InputDecoration(
                                counterStyle:
                                    const TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                alignLabelWithHint: true,
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).tag,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            filterTags(TagsBooks.tags, TagBook.all).length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                _tag ==
                                        filterTags(
                                            TagsBooks.tags, TagBook.all)[index]
                                    ? updateTag(TagBook.all)
                                    : updateTag(
                                        filterTags(
                                            TagsBooks.tags, TagBook.all)[index],
                                      );
                              },
                              child: Builder(
                                builder: (context) {
                                  return Chip(
                                    backgroundColor: _tag ==
                                            filterTags(TagsBooks.tags,
                                                TagBook.all)[index]
                                        ? Colors.white
                                        : null,
                                    elevation: 0.5,
                                    labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 4),
                                    label: Text(
                                      filterTags(TagsBooks.tags, TagBook.all)[
                                              index]
                                          .label(context),
                                      style: TextStyle(
                                          color: _tag ==
                                                  filterTags(TagsBooks.tags,
                                                      TagBook.all)[index]
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
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        S.of(context).back,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(100, 60),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        if (widget.edit ?? false) {
                          _controller?.updateBook(
                            BookEntity(
                              id: widget.book!.id,
                              title: _titleController!.text,
                              author: _authorController!.text,
                              bookState: widget.book!.bookState,
                              currentPage: int.parse(
                                _currentPageController!.text,
                              ),
                              finalPage: int.parse(
                                _finalPageController!.text,
                              ),
                              star: widget.book!.star,
                              tagBook: _tag!,
                            ),
                          );
                        } else {
                          _controller?.createBook(
                            BookEntity(
                              title: _titleController!.text,
                              author: _authorController!.text,
                              bookState: BookState.initial,
                              currentPage: int.parse(
                                _currentPageController!.text,
                              ),
                              finalPage: int.parse(
                                _finalPageController!.text,
                              ),
                              star: 0,
                              tagBook: _tag!,
                            ),
                          );
                        }

                        Navigator.of(context).pop();
                      },
                      child: Text(
                        S.of(context).save,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
