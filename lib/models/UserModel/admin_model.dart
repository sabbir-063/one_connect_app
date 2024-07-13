class AdminModel {
  String name;
  String email;
  String password;

  AdminModel({
    required this.name,
    required this.email,
    required this.password,
  });

  // Convert AdminModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Create a AdminModel instance from a map
  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
