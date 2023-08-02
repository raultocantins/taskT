// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map json) => BookModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      author: json['author'] as String,
      star: json['star'] as int,
      bookState: $enumDecode(_$BookStateEnumMap, json['bookState']),
      currentPage: json['currentPage'] as int,
      finalPage: json['finalPage'] as int,
      tagBook: $enumDecode(_$TagBookEnumMap, json['tagBook']),
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'star': instance.star,
      'currentPage': instance.currentPage,
      'finalPage': instance.finalPage,
      'bookState': _$BookStateEnumMap[instance.bookState]!,
      'tagBook': _$TagBookEnumMap[instance.tagBook]!,
    };

const _$BookStateEnumMap = {
  BookState.initial: 'initial',
  BookState.paused: 'paused',
  BookState.started: 'started',
  BookState.finished: 'finished',
};

const _$TagBookEnumMap = {
  TagBook.all: 'all',
  TagBook.fantasy: 'fantasy',
  TagBook.action: 'action',
};
