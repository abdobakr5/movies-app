import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';

class MovieRatingSection extends StatelessWidget {
  final int likeCount;
  final int runtime;
  final double rating;

  const MovieRatingSection({
    super.key,
    required this.likeCount,
    required this.runtime,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildBadge(
            icon: Icons.favorite,
            value: '$likeCount',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildBadge(
            icon: Icons.access_time_filled,
            value: '$runtime',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildBadge(
            icon: Icons.star,
            value: rating.toStringAsFixed(1),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.yellow,
            size: 18,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
