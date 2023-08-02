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
  bool? get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool? value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$tagAtom =
      Atom(name: '_BooksControllerBase.tag', context: context);

  @override
  TagBook get tag {
    _$tagAtom.reportRead();
    return super.tag;
  }

  @override
  set tag(TagBook value) {
    _$tagAtom.reportWrite(value, super.tag, () {
      super.tag = value;
    });
  }

  late final _$_booksAtom =
      Atom(name: '_BooksControllerBase._books', context: context);

  @override
  List<BookEntity> get _books {
    _$_booksAtom.reportRead();
    return super._books;
  }

  @override
  set _books(List<BookEntity> value) {
    _$_booksAtom.reportWrite(value, super._books, () {
      super._books = value;
    });
  }

  late final _$_BooksControllerBaseActionController =
      ActionController(name: '_BooksControllerBase', context: context);

  @override
  void changeTag(TagBook value) {
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
tag: ${tag}
    ''';
  }
}
