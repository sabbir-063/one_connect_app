class DonationTracker {
  final String donatorId;
  final String receiverId;
  final int amount;
  final String type; // 'centralFund' or 'user'
  final DateTime time;
  final String donationMedia; // e.g., 'Bkash', 'Nogod', etc.
  final String postId;

  DonationTracker({
    required this.donatorId,
    required this.receiverId,
    required this.amount,
    required this.type,
    required this.time,
    required this.donationMedia,
    required this.postId,
  });

  // Convert DonationTracker to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'donatorId': donatorId,
      'receiverId': receiverId,
      'amount': amount,
      'type': type,
      'time': time.toIso8601String(),
      'donationMedia': donationMedia,
      'postId': postId,
    };
  }

  // Create a DonationTracker from a Firestore map
  factory DonationTracker.fromMap(Map<String, dynamic> map) {
    return DonationTracker(
      donatorId: map['donatorId'],
      receiverId: map['receiverId'],
      amount: map['amount'],
      type: map['type'],
      time: DateTime.parse(map['time']),
      donationMedia: map['donationMedia'],
      postId: map['postId'],
    );
  }
}