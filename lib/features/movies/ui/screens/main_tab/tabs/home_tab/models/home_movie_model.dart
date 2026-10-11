import 'package:movies_app/core/utils/app_assets.dart';

class MovieModel {
  final String id;
  String imageUrl;
  final String rating;
  final String? title;
  final String backgroundUrl;
  final List<String> genres;

  MovieModel({
    required this.id,
    required this.imageUrl,
    required this.rating,
    this.title,
    required this.backgroundUrl,
    required this.genres,
  });

  // جاهز ليستقبّل البيانات من API زميلك مباشرة
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id']?.toString() ?? '',
      imageUrl: json['poster_path'] ?? json['image'] ?? '',
      rating: (json['vote_average'] ?? json['rating'] ?? '0.0').toString(),
      title: json['title'],
      backgroundUrl: json['backdrop_path'] ?? json['background'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }

  // Dummy Data لاستخدامها في مرحلة تطوير الـ UI
  static List<MovieModel> get dummyBannerMovies => [
        MovieModel(
          id: '1',
          imageUrl: AppAssets.movie1917,
          rating: '7.7',
          backgroundUrl: AppAssets.background,
          genres: [],
        ),
        MovieModel(
          id: '2',
          imageUrl: AppAssets.movieBatman,
          rating: '7.7',
          backgroundUrl: AppAssets.background,
          genres: [],
        ),
        MovieModel(
          id: '3',
          imageUrl: AppAssets.movieCaptainAmerica,
          rating: '7.7',
          backgroundUrl: AppAssets.background,
          genres: [],
        ),
      ];

  static List<MovieModel> get dummyActionMovies => [
        MovieModel(
          id: '4',
          imageUrl: AppAssets.movieCaptainAmerica2,
          rating: '7.7',
          backgroundUrl: AppAssets.background,
          genres: [],
        ),
        MovieModel(
          id: '5',
          imageUrl: AppAssets.moviewar,
          rating: '7.7',
          backgroundUrl: AppAssets.background,
          genres: [],
        ),
        MovieModel(
          id: '6',
          imageUrl: AppAssets.movie1917,
          rating: '7.7',
          backgroundUrl: AppAssets.background,
          genres: [],
        ),
      ];
}
