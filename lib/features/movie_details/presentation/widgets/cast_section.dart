import 'package:flutter/material.dart';
import 'package:movies_app/features/movie_details/domain/entities/cast_entity.dart';
import 'cast_item.dart';

class CastSection extends StatelessWidget {
  final List<CastEntity> castList;

  const CastSection({
    super.key,
    required this.castList,
  });

  @override
  Widget build(BuildContext context) {
    if (castList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cast',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: castList.map((cast) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CastItem(cast: cast),
            );
          }).toList(),
        ),
      ],
    );
  }
}
