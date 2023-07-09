// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map json) => TaskModel(
      id: json['id'] as int?,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      finished: json['finished'] as bool,
      priority: $enumDecode(_$PriorityEnumMap, json['priority']),
      tag: $enumDecode(_$TagEnumMap, json['tag']),
      title: json['title'] as String,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'finished': instance.finished,
      'priority': _$PriorityEnumMap[instance.priority]!,
      'tag': _$TagEnumMap[instance.tag]!,
      'title': instance.title,
    };

const _$PriorityEnumMap = {
  Priority.none: 'none',
  Priority.low: 'low',
  Priority.medium: 'medium',
  Priority.high: 'high',
};

const _$TagEnumMap = {
  Tag.all: 'all',
  Tag.work: 'work',
  Tag.personal: 'personal',
  Tag.wishlist: 'wishlist',
  Tag.birthday: 'birthday',
};
