class AdminPostModel {
  final String profileName;
  final String profilePicUrl;
  final String timeAgo;
  final String postMessage;
  final int donationNeeded;
  final List<String> imageUrls;

  AdminPostModel({
    required this.profileName,
    required this.profilePicUrl,
    required this.timeAgo,
    required this.postMessage,
    required this.donationNeeded,
    required this.imageUrls,
  });
}
