// UserModel class
class UserModel {
  String firstName;
  String lastName;
  String email;
  String phone;
  String country;
  String state;
  String city;
  String birthday;
  String password;
  int donationGiven;
  int donationReceived;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.birthday,
    required this.password,
    this.donationGiven = 0,
    this.donationReceived = 0,
  });

  // Convert UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'country': country,
      'state': state,
      'city': city,
      'birthday': birthday,
      'password': password,
      'donationGiven': donationGiven,
      'donationReceived': donationReceived,
    };
  }

  // Create a UserModel instance from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      birthday: map['birthday'],
      password: map['password'],
      donationGiven: map['donationGiven'] ?? 0,
      donationReceived: map['donationReceived'] ?? 0,
    );
  }
}
