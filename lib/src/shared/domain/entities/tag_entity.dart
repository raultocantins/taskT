class TagEntity {
  int id;
  String label;
  TagType type;

  TagEntity(this.id, this.label, {required this.type});
}

enum TagType { task, book }
