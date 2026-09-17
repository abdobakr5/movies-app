import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMoviesUseCase getMoviesUseCase;

  HomeCubit(this.getMoviesUseCase) : super(HomeInitial());

  Future<void> getMovies() async {
    emit(HomeLoading());

    try {
      final movies = await getMoviesUseCase();
      emit(HomeSuccess(movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void selectMovie(MovieEntity movie) {
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;

      emit(
        HomeSuccess(
          currentState.movies,
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
  final MovieEntity? selectedMovie;

  HomeSuccess(
      this.movies, {
        this.selectedMovie,
      });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}