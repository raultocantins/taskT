// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map json) => TagModel(
      (json['id'] as num).toInt(),
      json['label'] as String,
      type: $enumDecode(_$TagTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': _$TagTypeEnumMap[instance.type]!,
    };

const _$TagTypeEnumMap = {
  TagType.task: 'task',
  TagType.book: 'book',
};
