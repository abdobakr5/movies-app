import 'package:equatable/equatable.dart';
import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';

abstract class BrowseState extends Equatable {
  const BrowseState();

  @override
  List<Object?> get props => [];
}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseSuccessState extends BrowseState {
  final List<MovieEntity> allMovies;
  final Set<String> genres;
  final String selectedGenre;
  final List<MovieEntity> filteredMovies;

  const BrowseSuccessState({
    required this.allMovies,
    required this.genres,
    required this.selectedGenre,
    required this.filteredMovies,
  });

  @override
  List<Object?> get props => [allMovies, genres, selectedGenre, filteredMovies];
}

class BrowseErrorState extends BrowseState {
  final String message;

  const BrowseErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
