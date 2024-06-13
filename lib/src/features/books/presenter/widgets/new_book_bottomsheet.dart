import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/presenter/controllers/books_controller.dart';
import 'package:task_planner/src/features/books/presenter/utils/enums/book_state_enum.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';
import 'package:task_planner/src/shared/widgets/tags_custom_widget.dart';

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
  int? _tagId;
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
      _tagId = widget.book?.tagId;
    } else {
      _titleController = TextEditingController(text: '');
      _authorController = TextEditingController(text: '');
      _currentPageController = TextEditingController(text: '');
      _finalPageController = TextEditingController(text: '');
      _tagId = null;
    }
  }

  void updateTag(int? tagId) {
    setState(() {
      _tagId = tagId;
    });
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: double.infinity,
                child: TextSelectionTheme(
                  data: const TextSelectionThemeData(),
                  child: TextField(
                    controller: _titleController,
                    autofocus: true,
                    focusNode: focusNodeTitle,
                    maxLength: 50,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: 'Título do livro',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onSubmitted: (v) {
                      focusNodeAuthor.requestFocus();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: TextSelectionTheme(
                  data: const TextSelectionThemeData(),
                  child: TextField(
                    controller: _authorController,
                    focusNode: focusNodeAuthor,
                    maxLength: 50,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: 'Nome do autor do livro',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onSubmitted: (v) {
                      focusNodeCurrentPage.requestFocus();
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Páginas',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Primeira Página a Ler:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              focusNode: focusNodeCurrentPage,
                              controller: _currentPageController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                alignLabelWithHint: true,
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.secondary,
                                hintText: '0',
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              onSubmitted: (v) {
                                focusNodeFinalPage.requestFocus();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Última Página a Ler:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              focusNode: focusNodeFinalPage,
                              controller: _finalPageController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                alignLabelWithHint: true,
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.secondary,
                                hintText: '0',
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              onSubmitted: (v) {
                                focusNodeFinalPage.requestFocus();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).tag,
                    style: const TextStyle(fontSize: 16),
                  ),
                  TagsCustom(
                    onTap: (id) => updateTag(id),
                    tagId: _tagId,
                    tagType: TagType.book,
                    tagRemoved: (_) => {},
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      S.of(context).back,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      if (widget.edit ?? false) {
                        final isFinished = int.parse(
                              _currentPageController!.text,
                            ) ==
                            int.parse(
                              _finalPageController!.text,
                            );
                        _controller?.updateBook(
                          BookEntity(
                            id: widget.book!.id,
                            title: _titleController!.text,
                            author: _authorController!.text,
                            bookState: isFinished
                                ? BookState.finished
                                : widget.book!.bookState == BookState.finished
                                    ? BookState.started
                                    : widget.book!.bookState,
                            currentPage: int.parse(
                              _currentPageController!.text,
                            ),
                            finalPage: int.parse(
                              _finalPageController!.text,
                            ),
                            star: widget.book!.star,
                            tagId: _tagId!,
                          ),
                        );
                      } else {
                        _controller?.createBook(
                          BookEntity(
                            title: _titleController!.text,
                            author: _authorController!.text,
                            bookState: BookState.started,
                            currentPage: int.parse(
                              _currentPageController!.text,
                            ),
                            finalPage: int.parse(
                              _finalPageController!.text,
                            ),
                            star: 0,
                            tagId: _tagId,
                          ),
                        );
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).save,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
