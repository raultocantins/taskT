// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/priority_enum.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';
import 'package:taskt/src/shared/utils/extensions/date_extension.dart';
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
  final String title;

  TaskModel(
      {this.id,
      required this.date,
      required this.hours,
      required this.description,
      required this.finished,
      required this.priority,
      required this.tag,
      required this.title});
  factory TaskModel.fromJson(dynamic json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  Map<String, dynamic> toMap() => {
        'date': date.formatDateToDatabase(),
        'hours': hours.toString(),
        'description': description,
        'finished': finished ? 1 : 0,
        'priority': priority.fromEnumToString(),
        'tag': tag.fromEnumToString(),
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
        title: entity.title);
  }
}
