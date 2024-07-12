class AdminModel {
  String name;
  String email;
  String password;
  int donationGiven;
  int donationReceived;

  AdminModel({
    required this.name,
    required this.email,
    required this.password,
    this.donationGiven = 0,
    this.donationReceived = 0,
  });

  // Convert AdminModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'donationGiven': donationGiven,
      'donationReceived': donationReceived,
    };
  }

  // Create a AdminModel instance from a map
  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      donationGiven: map['donationGiven'] ?? 0,
      donationReceived: map['donationReceived'] ?? 0,
    );
  }
}
