import 'package:flutter/material.dart';
import 'package:task_planner/generated/l10n.dart';

enum Tag { all, work, personal, wishlist, birthday }

extension TagsExtensions on Tag {
  String label(BuildContext context) {
    switch (this) {
      case Tag.all:
        return S.of(context).all;
      case Tag.work:
        return S.of(context).work;
      case Tag.personal:
        return S.of(context).personal;
      case Tag.wishlist:
        return S.of(context).wishlist;
      case Tag.birthday:
        return S.of(context).birthday;
      default:
        return S.of(context).all;
    }
  }

  static Tag fromStringToEnum(String text) {
    switch (text) {
      case 'all':
        return Tag.all;
      case 'work':
        return Tag.work;
      case 'personal':
        return Tag.personal;
      case 'wishlist':
        return Tag.wishlist;
      case 'birthday':
        return Tag.birthday;
      default:
        return Tag.all;
    }
  }

  String fromEnumToString() {
    switch (this) {
      case Tag.all:
        return 'all';
      case Tag.work:
        return 'work';
      case Tag.personal:
        return 'personal';
      case Tag.wishlist:
        return 'wishlist';
      case Tag.birthday:
        return 'birthday';
      default:
        return 'all';
    }
  }
}
