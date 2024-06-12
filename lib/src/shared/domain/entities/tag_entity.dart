import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

class TagEntity {
  int id;
  String label;
  TagType type;

  TagEntity(this.id, this.label, {required this.type});
}
