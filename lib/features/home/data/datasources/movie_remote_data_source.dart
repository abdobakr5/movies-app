import 'dart:convert';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/api_manager.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';

class MovieRemoteDataSource {
  final ApiManager apiManager;

  MovieRemoteDataSource(this.apiManager);

  Future<List<MovieModel>> getMovies({
    String? query,
    String? genre,
  }) async {
    final response = await apiManager.getRequest(
      ApiConstants.listMovies,
      queryParameters: {
        if (query != null && query.isNotEmpty) 'query_term': query,
        if (genre != null && genre.isNotEmpty) 'genre': genre,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<dynamic> movies = data['data']['movies'] ?? [];

      return movies
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
