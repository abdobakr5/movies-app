import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsEntity movieDetails;
  final List<MovieEntity> movieSuggestions;

  MovieDetailsSuccess({
    required this.movieDetails,
    required this.movieSuggestions,
  });
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}
