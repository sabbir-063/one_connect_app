import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/CreatePostModel/admin_post_model.dart';
import 'post_widget.dart';

class PostsList extends StatelessWidget {
  final RxList<AdminPostModel> posts;

  const PostsList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostWidget(post: posts[index]);
      },
    );
  }
}
