// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map json) => TaskModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: $enumDecode(_$PriorityEnumMap, json['priority']),
      finished: json['finished'] as bool,
      tagId: (json['tagId'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': _$PriorityEnumMap[instance.priority]!,
      'date': instance.date.toIso8601String(),
      'finished': instance.finished,
      'tagId': instance.tagId,
    };

const _$PriorityEnumMap = {
  Priority.none: 'none',
  Priority.low: 'low',
  Priority.medium: 'medium',
  Priority.high: 'high',
};
