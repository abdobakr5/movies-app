import 'package:flutter/material.dart';

class ScreenshotSection extends StatelessWidget {
  final List<String> screenshots;

  const ScreenshotSection({
    super.key,
    required this.screenshots,
  });

  @override
  Widget build(BuildContext context) {
    if (screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Screen Shots',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: screenshots.map((url) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  url,
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 190,
                    width: double.infinity,
                    color: const Color(0xFF282828),
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white38,
                      size: 40,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
