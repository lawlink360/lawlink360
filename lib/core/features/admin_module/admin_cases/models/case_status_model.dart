class CaseStatusModel {
  static const String pending = 'Pending';
  static const String active = 'Active';
  static const String onHold = 'On Hold';
  static const String closed = 'Closed';
  static const String dismissed = 'Dismissed';

  static const String all = 'All';

  static const List<String> values = [
    pending,
    active,
    onHold,
    closed,
    dismissed,
  ];

  static String fromValue(String? value) {
    if (value == null || !values.contains(value)) {
      return pending;
    }

    return value;
  }

  static bool isPending(String status) => status == pending;

  static bool isActive(String status) => status == active;

  static bool isOnHold(String status) => status == onHold;

  static bool isClosed(String status) => status == closed;

  static bool isDismissed(String status) => status == dismissed;
}