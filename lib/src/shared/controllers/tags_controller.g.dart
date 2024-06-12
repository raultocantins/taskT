// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TagsController on _TagsControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_TagsControllerBase.isLoading', context: context);

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

  late final _$tagsAtom =
      Atom(name: '_TagsControllerBase.tags', context: context);

  @override
  List<TagEntity>? get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(List<TagEntity>? value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  late final _$_TagsControllerBaseActionController =
      ActionController(name: '_TagsControllerBase', context: context);

  @override
  void changeTags(List<TagEntity>? value) {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction(
        name: '_TagsControllerBase.changeTags');
    try {
      return super.changeTags(value);
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsLoading(bool value) {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction(
        name: '_TagsControllerBase.changeIsLoading');
    try {
      return super.changeIsLoading(value);
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tags: ${tags}
    ''';
  }
}
