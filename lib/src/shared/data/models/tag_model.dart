import 'package:json_annotation/json_annotation.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

part 'tag_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class TagModel {
  int id;
  String label;
  TagType type;

  TagModel(this.id, this.label, {required this.type});

  factory TagModel.fromJson(dynamic json) => _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  Map<String, dynamic> toMap() => {
        'id': id,
        'label': label,
        'type': type.name,
      };
  static TagModel fromObjectDb(Map<String, dynamic> task) {
    return TagModel(
      task['_id'],
      task['label'],
      type: TagTypeExtensions.fromStringToEnum(
        task['type'],
      ),
    );
  }

  static TagEntity toEntity(TagModel model) {
    return TagEntity(model.id, model.label, type: model.type);
  }

  static TagModel toModel(TagEntity entity) {
    return TagModel(entity.id, entity.label, type: entity.type);
  }
}
