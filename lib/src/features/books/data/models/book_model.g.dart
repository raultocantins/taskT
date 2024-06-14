// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map json) => BookModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      star: (json['star'] as num).toInt(),
      bookState: $enumDecode(_$BookStateEnumMap, json['bookState']),
      currentPage: (json['currentPage'] as num).toInt(),
      finalPage: (json['finalPage'] as num).toInt(),
      finished: json['finished'] as bool,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      tagId: (json['tagId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'star': instance.star,
      'currentPage': instance.currentPage,
      'finalPage': instance.finalPage,
      'bookState': _$BookStateEnumMap[instance.bookState]!,
      'tagId': instance.tagId,
      'finished': instance.finished,
      'endDate': instance.endDate?.toIso8601String(),
    };

const _$BookStateEnumMap = {
  BookState.initial: 'initial',
  BookState.paused: 'paused',
  BookState.started: 'started',
  BookState.finished: 'finished',
};
