import 'package:flutter/material.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'similar_movie_card.dart';

class SimilarMoviesSection extends StatelessWidget {
  final List<MovieEntity> movies;

  const SimilarMoviesSection({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Similar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return SimilarMovieCard(
              movie: movie,
              onTap: () {
                Navigator.push(
                  context,
                  AppRoutes.movieDetails(movie.id),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
