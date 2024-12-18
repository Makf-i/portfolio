class UserModel {
  final String? id;
  final String name;
  final String email;
  final String address;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     id: json['id'] ?? '',
  //     name: json['name'],
  //     email: json['email'],
  //     address: json['address'],
  //   );
  // }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '', // Use empty string if key is missing
      email: json['email'] ?? '', // Use empty string if key is missing
      address: json['address'] ?? '', // Use empty string if key is missing
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'name': name,
      'email': email,
      'address': address,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? address,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }
}
