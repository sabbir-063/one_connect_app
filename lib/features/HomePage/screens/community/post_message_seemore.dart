import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostMessageWidget extends StatefulWidget {
  final String postMessage;

  const PostMessageWidget({super.key, required this.postMessage});

  @override
  // ignore: library_private_types_in_public_api
  _PostMessageWidgetState createState() => _PostMessageWidgetState();
}

class _PostMessageWidgetState extends State<PostMessageWidget> {
  bool isExpanded = false; // To manage the expanded state

  @override
  Widget build(BuildContext context) {
    final String firstPart = widget.postMessage.length > 100
        ? widget.postMessage.substring(0, 100)
        : widget.postMessage;
    final String remainingPart = widget.postMessage.length > 100
        ? widget.postMessage.substring(100)
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(
              text: widget.postMessage)); // Copy text to clipboard
          HapticFeedback.vibrate(); // Vibration feedback
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post message copied!'),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isExpanded ? widget.postMessage : firstPart,
              textAlign: TextAlign.justify, // Make the text justified
              style: const TextStyle(fontSize: 16),
            ),
            if (remainingPart.isNotEmpty && !isExpanded)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded; // Toggle expansion
                  });
                },
                child: const Text(
                  " See more...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue, // Blue text for 'See more'
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
