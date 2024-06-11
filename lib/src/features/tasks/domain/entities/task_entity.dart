import 'package:task_planner/src/features/tasks/presentation/utils/enums/priority_enum.dart';

class TaskEntity {
  int? id;
  String title;
  String? description;
  Priority priority;
  DateTime date;
  bool finished;
  int? tagId;
  TaskEntity({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.finished,
    required this.tagId,
    required this.date,
  });
}
