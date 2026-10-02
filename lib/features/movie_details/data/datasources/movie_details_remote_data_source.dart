import 'dart:convert';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/api_manager.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'package:movies_app/features/movie_details/data/models/movie_details_model.dart';

class MovieDetailsRemoteDataSource {
  final ApiManager apiManager;

  MovieDetailsRemoteDataSource(this.apiManager);

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await apiManager.getRequest(
      ApiConstants.movieDetails,
      queryParameters: {
        'movie_id': '$movieId',
        'with_images': 'true',
        'with_cast': 'true',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'ok' && json['data'] != null && json['data']['movie'] != null) {
        return MovieDetailsModel.fromJson(json['data']['movie']);
      } else {
        throw Exception(json['status_message'] ?? 'Failed to load movie details');
      }
    } else {
      throw Exception('Failed to load movie details (${response.statusCode})');
    }
  }

  Future<List<MovieModel>> getMovieSuggestions(int movieId) async {
    final response = await apiManager.getRequest(
      ApiConstants.movieSuggestions,
      queryParameters: {
        'movie_id': '$movieId',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'ok' && json['data'] != null) {
        final rawMovies = json['data']['movies'] as List<dynamic>? ?? [];
        return rawMovies
            .whereType<Map<String, dynamic>>()
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load movie suggestions (${response.statusCode})');
    }
  }
}
