import 'package:faker/faker.dart';

import '../../../models/CreatePostModel/admin_post_model.dart';

List<AdminPostModel> generateUniqueAdminPostData(int count) {
  final faker = Faker();
  final List<AdminPostModel> adminPosts = [];

  for (int i = 0; i < count; i++) {
    adminPosts.add(AdminPostModel(
      profileName: faker.person.name(),
      profilePicUrl: faker.internet.httpUrl(),
      timeAgo: '${faker.randomGenerator.integer(12)}h ago',
      postMessage: faker.lorem
          .sentences(faker.randomGenerator.integer(3, min: 1))
          .join(' '),
      donationNeeded: faker.randomGenerator.integer(10000, min: 100),
      imageUrls: List.generate(faker.randomGenerator.integer(5, min: 1),
          (_) => faker.internet.httpUrl()),
    ));
  }

  return adminPosts;
}
