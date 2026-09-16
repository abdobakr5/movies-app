import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.titleEnglish,
    required super.titleLong,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.genres,
    required super.summary,
    required super.descriptionFull,
    required super.backgroundImage,
    required super.backgroundImageOriginal,
    required super.smallCoverImage,
    required super.mediumCoverImage,
    required super.largeCoverImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleLong: json['title_long'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'] ?? '',
      descriptionFull: json['description_full'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      backgroundImageOriginal: json['background_image_original'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
    );
  }
}