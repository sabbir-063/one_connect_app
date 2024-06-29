class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String state;
  final String city;
  final String birthday;
  final String password;
  final int donationGiven = 0;
  final int donationReceived = 0;

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
  });
}
