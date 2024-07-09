import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String title;
  final String message;
  final bool isSuccess;

  const CustomSnackbar({
    super.key,
    required this.title,
    required this.message,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: double.infinity,
            color: Colors.grey,
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
