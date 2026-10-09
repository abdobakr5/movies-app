import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/usecases/get_movies_usecase.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetMoviesUseCase getMoviesUseCase;

  SearchCubit(this.getMoviesUseCase) : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final movies = await getMoviesUseCase(query: query.trim());
      emit(SearchSuccess(movies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieEntity> movies;

  SearchSuccess(this.movies);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}