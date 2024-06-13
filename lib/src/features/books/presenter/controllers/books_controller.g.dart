// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BooksController on _BooksControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_BooksControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$tagIdAtom =
      Atom(name: '_BooksControllerBase.tagId', context: context);

  @override
  int? get tagId {
    _$tagIdAtom.reportRead();
    return super.tagId;
  }

  @override
  set tagId(int? value) {
    _$tagIdAtom.reportWrite(value, super.tagId, () {
      super.tagId = value;
    });
  }

  late final _$booksAtom =
      Atom(name: '_BooksControllerBase.books', context: context);

  @override
  List<BookEntity> get books {
    _$booksAtom.reportRead();
    return super.books;
  }

  @override
  set books(List<BookEntity> value) {
    _$booksAtom.reportWrite(value, super.books, () {
      super.books = value;
    });
  }

  late final _$_BooksControllerBaseActionController =
      ActionController(name: '_BooksControllerBase', context: context);

  @override
  void changeBooks(List<BookEntity> value) {
    final _$actionInfo = _$_BooksControllerBaseActionController.startAction(
        name: '_BooksControllerBase.changeBooks');
    try {
      return super.changeBooks(value);
    } finally {
      _$_BooksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTag(int? value) {
    final _$actionInfo = _$_BooksControllerBaseActionController.startAction(
        name: '_BooksControllerBase.changeTag');
    try {
      return super.changeTag(value);
    } finally {
      _$_BooksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsLoading(bool value) {
    final _$actionInfo = _$_BooksControllerBaseActionController.startAction(
        name: '_BooksControllerBase.changeIsLoading');
    try {
      return super.changeIsLoading(value);
    } finally {
      _$_BooksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tagId: ${tagId},
books: ${books}
    ''';
  }
}
