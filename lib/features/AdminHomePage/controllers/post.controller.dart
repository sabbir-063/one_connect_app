import 'package:get/get.dart';
import '../../../data/static_data/admin_post_data/admin_post_card_data.dart';
import '../../../models/CreatePostModel/admin_post_model.dart';

class PostController extends GetxController {
  var posts = <AdminPostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load initial posts
    posts.addAll(AdminPostData.posts);
  }

  void removePost(AdminPostModel post) {
    posts.remove(post);
  }
}
