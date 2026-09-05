class LawyerStatusModel {
  final String value;
  final String label;

  const LawyerStatusModel({
    required this.value,
    required this.label,
  });

  static const List<LawyerStatusModel> all = [
    LawyerStatusModel(
      value: 'active',
      label: 'Active',
    ),
    LawyerStatusModel(
      value: 'inactive',
      label: 'Inactive',
    ),
    LawyerStatusModel(
      value: 'suspended',
      label: 'Suspended',
    ),
    LawyerStatusModel(
      value: 'pending',
      label: 'Pending',
    ),
  ];

  static LawyerStatusModel? fromValue(String value) {
    for (final status in all) {
      if (status.value == value) {
        return status;
      }
    }

    return null;
  }

  bool get isActive => value == 'active';

  bool get isInactive => value == 'inactive';

  bool get isSuspended => value == 'suspended';

  bool get isPending => value == 'pending';
}