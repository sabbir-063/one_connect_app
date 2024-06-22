import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'ONECONNECT',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  // Action for creating a post
                },
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Action for searching a post
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  // Action for notifications
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
