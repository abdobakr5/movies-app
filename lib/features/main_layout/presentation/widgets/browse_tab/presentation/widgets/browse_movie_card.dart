import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/features/browse/presentation/cubit/browse_cubit.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';

class BrowseMovieCard extends StatelessWidget {
  final MovieModel movie;

  const BrowseMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 1. تسجيل الفيلم في Firebase History تلقائياً
        context.read<BrowseCubit>().addToHistory(movie);

        // 2. الانتقال لشاشة التفاصيل
        Navigator.pushNamed(
          context,
          AppStrings.movieDetails,
          arguments: movie,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              movie.mediumCoverImage,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.grey,
                child: const Icon(Icons.broken_image, color: AppColors.white38),
              ),
            ),
            // Badge التقييم (مأخوذ من تصميم زميلك)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      '${movie.rating}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: AppColors.yellow, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
