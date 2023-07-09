enum Tag { all, work, personal, wishlist, birthday }

extension TagsExtensions on Tag {
  String label() {
    switch (this) {
      case Tag.all:
        return 'All';
      case Tag.work:
        return 'Work';
      case Tag.personal:
        return 'Personal';
      case Tag.wishlist:
        return 'Wishlist';
      case Tag.birthday:
        return 'Birthday';
      default:
        return 'All';
    }
  }

  static Tag fromStringToEnum(String text) {
    switch (text) {
      case 'all':
        return Tag.all;
      case 'work':
        return Tag.work;
      case 'personal':
        return Tag.personal;
      case 'wishlist':
        return Tag.wishlist;
      case 'birthday':
        return Tag.birthday;
      default:
        return Tag.all;
    }
  }

  String fromEnumToString() {
    switch (this) {
      case Tag.all:
        return 'all';
      case Tag.work:
        return 'work';
      case Tag.personal:
        return 'personal';
      case Tag.wishlist:
        return 'wishlist';
      case Tag.birthday:
        return 'birthday';
      default:
        return 'all';
    }
  }
}
