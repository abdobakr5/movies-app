import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/movie_details/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_app/features/movie_details/domain/usecase/get_movie_suggestions_usecase.dart';
import 'package:movies_app/features/movie_details/domain/usecase/save_to_history_usecase.dart';
import 'package:movies_app/features/movie_details/ui/cubit/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetMovieSuggestionsUseCase getMovieSuggestionsUseCase;
  final SaveToHistoryUseCase saveToHistoryUseCase;

  MovieDetailsCubit({
    required this.getMovieDetailsUseCase,
    required this.getMovieSuggestionsUseCase,
    required this.saveToHistoryUseCase,
  }) : super(MovieDetailsInitial());

  Future<void> loadMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());

    try {
      final results = await Future.wait([
        getMovieDetailsUseCase(movieId),
        getMovieSuggestionsUseCase(movieId),
      ]);

      final movieDetails = results[0] as MovieDetailsEntity;
      final movieSuggestions = results[1] as List<MovieEntity>;

      emit(MovieDetailsSuccess(
        movieDetails: movieDetails,
        movieSuggestions: movieSuggestions,
      ));

      saveToHistoryUseCase(movieDetails).catchError((_) {});
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}
