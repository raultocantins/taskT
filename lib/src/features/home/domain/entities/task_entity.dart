import 'package:taskt/src/features/home/presenter/utils/enums/priority_enum.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';

class TaskEntity {
  int? id;
  String title;
  String description;
  Priority priority;
  DateTime date;
  DateTime hours;
  bool finished;
  Tag tag;
  TaskEntity(
      {this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.finished,
      required this.tag,
      required this.date,
      required this.hours});
}
