enum TagType { task, book }

extension TagTypeExtensions on TagType {
  static TagType fromStringToEnum(String text) {
    switch (text) {
      case 'task':
        return TagType.task;
      case 'book':
        return TagType.book;
      default:
        return throw Exception();
    }
  }
}
