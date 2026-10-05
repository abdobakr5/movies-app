import 'package:flutter/material.dart';
import 'package:movies_app/core/app_routes/app_routes.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'movie_card.dart';

class ActionMoviesList extends StatelessWidget {
  final List<MovieModel> movies;

  const ActionMoviesList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: SizedBox(
              width: 125,
              child: MovieCard(
                movie: movie,
                borderRadius: 18,
                onTap: () {
                  Navigator.push(
                    context,
                    AppRoutes.movieDetails(movie.id),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
