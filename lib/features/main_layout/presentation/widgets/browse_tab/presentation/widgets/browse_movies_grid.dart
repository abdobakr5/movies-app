import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'browse_movie_card.dart';

class BrowseMoviesGrid extends StatelessWidget {
  final List<MovieModel> movies;

  const BrowseMoviesGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text(
          AppStrings.noMoviesFound,
          style: TextStyle(color: AppColors.white54),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.67,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return BrowseMovieCard(movie: movies[index]);
      },
    );
  }
}
