import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const PostButton({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}