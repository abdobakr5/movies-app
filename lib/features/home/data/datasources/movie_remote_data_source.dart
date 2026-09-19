import 'dart:convert';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/api_manager.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';

class MovieRemoteDataSource {
  final ApiManager apiManager;

  MovieRemoteDataSource(this.apiManager);

  Future<List<MovieModel>> getMovies() async {
    final response = await apiManager.getRequest(
      ApiConstants.listMovies,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final movies = data['data']['movies'] as List;

      return movies.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
