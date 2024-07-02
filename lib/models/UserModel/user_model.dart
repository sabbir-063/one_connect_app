
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
  int donationGiven = 0;
  int donationReceived = 0;
  UserRank rank = UserRank.None; 
   
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


}
enum UserRank { None, Gold, Silver, Bronze }
