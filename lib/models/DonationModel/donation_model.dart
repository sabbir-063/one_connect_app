class DonationModel {
  final String userName;
  final String email;
  final double amount;
  final DateTime timestamp;
  final String donationType;

  DonationModel({
    required this.userName,
    required this.email,
    required this.amount,
    required this.timestamp,
    required this.donationType,
  });
}
