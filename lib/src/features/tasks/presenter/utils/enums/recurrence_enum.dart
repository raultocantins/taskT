enum Recurrence { daily, weekly, monthly, none }

extension RecurrencesExtensions on Recurrence {
  String label() {
    switch (this) {
      case Recurrence.daily:
        return 'Daily';
      case Recurrence.weekly:
        return 'Weekly';
      case Recurrence.monthly:
        return 'Monthly';
      case Recurrence.none:
        return 'None';

      default:
        return 'None';
    }
  }

  static Recurrence fromStringToEnum(String text) {
    switch (text) {
      case 'daily':
        return Recurrence.daily;
      case 'weekly':
        return Recurrence.weekly;
      case 'monthly':
        return Recurrence.monthly;
      case 'none':
        return Recurrence.none;

      default:
        return Recurrence.none;
    }
  }

  String fromEnumToString() {
    switch (this) {
      case Recurrence.daily:
        return 'daily';
      case Recurrence.weekly:
        return 'weekly';
      case Recurrence.monthly:
        return 'monthly';
      case Recurrence.none:
        return 'none';

      default:
        return 'none';
    }
  }
}
