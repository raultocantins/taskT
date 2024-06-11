// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/priority_enum.dart';

part 'task_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class TaskModel {
  int? id;
  String title;
  String? description;
  Priority priority;
  DateTime date;
  bool finished;
  int? tagId;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.finished,
    required this.tagId,
    required this.date,
  });
  factory TaskModel.fromJson(dynamic json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  Map<String, dynamic> toMap() => {
        'date': date.millisecondsSinceEpoch,
        'description': description,
        'finished': finished ? 1 : 0,
        'priority': priority.fromEnumToString(),
        'tagId': tagId,
        'title': title
      };
  static TaskModel fromObjectDb(Map<String, dynamic> task) {
    return TaskModel(
      id: task['_id'],
      date: DateTime.fromMillisecondsSinceEpoch(task['date']),
      description: task['description'],
      finished: task['finished'] == 1 ? true : false,
      priority: PriorityExtensions.fromStringToEnum(task['priority']),
      tagId: task['tagId'],
      title: task['title'],
    );
  }

  static TaskEntity toEntity(TaskModel model) {
    return TaskEntity(
      id: model.id,
      date: model.date,
      description: model.description,
      finished: model.finished,
      priority: model.priority,
      tagId: model.tagId,
      title: model.title,
    );
  }

  static TaskModel toModel(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      date: entity.date,
      description: entity.description,
      finished: entity.finished,
      priority: entity.priority,
      tagId: entity.tagId,
      title: entity.title,
    );
  }
}
