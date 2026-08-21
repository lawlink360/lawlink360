class ClientModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String? cnic;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    this.cnic,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  ClientModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? cnic,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      cnic: cnic ?? this.cnic,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}