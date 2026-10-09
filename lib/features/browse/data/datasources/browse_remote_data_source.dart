// lib/features/browse/data/datasources/browse_remote_data_source.dart

import 'dart:convert';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_manager.dart';
import '../../../home/data/models/movie_model.dart';

abstract class BrowseRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class BrowseRemoteDataSourceImpl implements BrowseRemoteDataSource {
  final ApiManager apiManager;

  BrowseRemoteDataSourceImpl(this.apiManager);

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await apiManager.getRequest(ApiConstants.listMovies);

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);

      if (decodedBody['status'] == 'ok') {
        final List moviesJson = decodedBody['data']['movies'] ?? [];
        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      }
    }

    throw Exception('Failed to fetch movies from API');
  }
}