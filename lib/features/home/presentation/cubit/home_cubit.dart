import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/usecases/get_movies_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMoviesUseCase getMoviesUseCase;

  HomeCubit(this.getMoviesUseCase) : super(HomeInitial());

  Future<void> getMovies() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        getMoviesUseCase(genre: 'action'),
        getMoviesUseCase(genre: 'romance'),
        getMoviesUseCase(genre: 'drama'),
        getMoviesUseCase(genre: 'horror'),
      ]);

      emit(
        HomeSuccess(
          movies: results[0],
          actionMovies: results[0],
          romanceMovies: results[1],
          dramaMovies: results[2],
          horrorMovies: results[3],
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void selectMovie(MovieEntity movie) {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;

      emit(
        HomeSuccess(
          movies: currentState.movies,
          actionMovies: currentState.actionMovies,
          romanceMovies: currentState.romanceMovies,
          dramaMovies: currentState.dramaMovies,
          horrorMovies: currentState.horrorMovies,
          selectedMovie: movie,
        ),
      );
    }
  }
}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieEntity> movies;
  final List<MovieEntity> actionMovies;
  final List<MovieEntity> romanceMovies;
  final List<MovieEntity> dramaMovies;
  final List<MovieEntity> horrorMovies;

  final MovieEntity? selectedMovie;

  HomeSuccess({
    required this.movies,
    required this.actionMovies,
    required this.romanceMovies,
    required this.dramaMovies,
    required this.horrorMovies,
    this.selectedMovie,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
