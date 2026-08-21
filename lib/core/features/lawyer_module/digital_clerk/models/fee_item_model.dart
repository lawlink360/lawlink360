class FeeItemModel {
  final String id;
  final String description;
  final double amount;

  const FeeItemModel({
    required this.id,
    required this.description,
    required this.amount,
  });

  FeeItemModel copyWith({
    String? id,
    String? description,
    double? amount,
  }) {
    return FeeItemModel(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }
}