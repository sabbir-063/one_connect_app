class PostCardModel {
  final String profileName;
  final String profilePicUrl;
  final String timeAgo;
  final String postMessage;
  final int donationNeeded;
  final int donationRaised;

  PostCardModel({
    required this.profileName,
    required this.profilePicUrl,
    required this.timeAgo,
    required this.postMessage,
    required this.donationNeeded,
    required this.donationRaised,
  });
}
