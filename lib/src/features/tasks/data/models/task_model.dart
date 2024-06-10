// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/priority_enum.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/recurrence_enum.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/tags_enum.dart';
part 'task_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class TaskModel {
  final int? id;
  final DateTime date;
  final DateTime hours;
  final String description;
  final bool finished;
  final Priority priority;
  final Tag tag;
  final Recurrence recurrence;
  final String title;

  TaskModel(
      {this.id,
      required this.date,
      required this.hours,
      required this.description,
      required this.finished,
      required this.priority,
      required this.tag,
      required this.recurrence,
      required this.title});
  factory TaskModel.fromJson(dynamic json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  Map<String, dynamic> toMap() => {
        'date': date.toIso8601String(),
        'hours': date.toIso8601String(),
        'description': description,
        'finished': finished ? 1 : 0,
        'priority': priority.fromEnumToString(),
        'tag': tag.fromEnumToString(),
        'recurrence': recurrence.fromEnumToString(),
        'title': title
      };
  static TaskModel fromObjectDb(Map<String, dynamic> task) {
    return TaskModel(
      id: task['_id'],
      date: DateTime.parse(task['date']),
      hours: DateTime.parse(task['hours']),
      description: task['description'],
      finished: task['finished'] == 1 ? true : false,
      priority: PriorityExtensions.fromStringToEnum(task['priority']),
      tag: TagsExtensions.fromStringToEnum(task['tag']),
      recurrence: RecurrencesExtensions.fromStringToEnum(task['recurrence']),
      title: task['title'],
    );
  }

  static TaskEntity toEntity(TaskModel model) {
    return TaskEntity(
      id: model.id,
      date: model.date,
      hours: model.hours,
      description: model.description,
      finished: model.finished,
      priority: model.priority,
      tag: model.tag,
      recurrence: model.recurrence,
      title: model.title,
    );
  }

  static TaskModel toModel(TaskEntity entity) {
    return TaskModel(
        id: entity.id,
        date: entity.date,
        hours: entity.hours,
        description: entity.description,
        finished: entity.finished,
        priority: entity.priority,
        tag: entity.tag,
        recurrence: entity.recurrence,
        title: entity.title);
  }
}
