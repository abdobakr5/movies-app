import 'package:flutter/material.dart';

class MovieSummarySection extends StatelessWidget {
  final String summary;

  const MovieSummarySection({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    if (summary.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Summary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          summary,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
