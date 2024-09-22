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
  String profileUrl;
  String userNameAuto;

  UserModel({
    required this.firstName,
    required this.lastName,
    this.userNameAuto = '',
    required this.email,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.birthday,
    required this.password,
    this.donationGiven = 0,
    this.donationReceived = 0,
    this.profileUrl =
        '', // Default to an empty string if no profile URL is provided
  });

  // Convert UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userNameAuto': userNameAuto,
      'email': email,
      'phone': phone,
      'country': country,
      'state': state,
      'city': city,
      'birthday': birthday,
      'password': password,
      'donationGiven': donationGiven,
      'donationReceived': donationReceived,
      'profileUrl': profileUrl,
    };
  }

  // Create a UserModel instance from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      userNameAuto: map['userNameAuto'],
      email: map['email'],
      phone: map['phone'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      birthday: map['birthday'],
      password: map['password'],
      donationGiven: map['donationGiven'] ?? 0,
      donationReceived: map['donationReceived'] ?? 0,
      profileUrl: map['profileUrl'] ?? '',
    );
  }
}
