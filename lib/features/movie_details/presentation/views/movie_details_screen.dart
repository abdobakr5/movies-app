import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/movie_details_cubit.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/movie_details_state.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/cast_section.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/genres_section.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/movie_details_header.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/movie_rating_section.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/movie_summary_section.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/screenshot_section.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/similar_movies_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading || state is MovieDetailsInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.yellow,
              ),
            );
          }

          if (state is MovieDetailsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.red,
                      size: 54,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<MovieDetailsCubit>()
                            .loadMovieDetails(movieId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        foregroundColor: Colors.black,
                      ),
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'Retry',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is MovieDetailsSuccess) {
            final movie = state.movieDetails;
            final summaryText = movie.descriptionFull.isNotEmpty
                ? movie.descriptionFull
                : movie.summary;

            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MovieDetailsHeader(movie: movie),
                    const SizedBox(height: 16),
                    MovieRatingSection(
                      likeCount: movie.likeCount,
                      runtime: movie.runtime,
                      rating: movie.rating,
                    ),
                    const SizedBox(height: 24),
                    ScreenshotSection(screenshots: movie.screenshots),
                    if (movie.screenshots.isNotEmpty)
                      const SizedBox(height: 24),
                    SimilarMoviesSection(movies: state.movieSuggestions),
                    if (state.movieSuggestions.isNotEmpty)
                      const SizedBox(height: 24),
                    MovieSummarySection(summary: summaryText),
                    const SizedBox(height: 24),
                    CastSection(castList: movie.cast),
                    if (movie.cast.isNotEmpty) const SizedBox(height: 24),
                    GenresSection(genres: movie.genres),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
