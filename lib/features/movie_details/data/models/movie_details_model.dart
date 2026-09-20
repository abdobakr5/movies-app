import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';
import 'cast_model.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  const MovieDetailsModel({
    required super.id,
    required super.title,
    required super.titleEnglish,
    required super.titleLong,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.likeCount,
    required super.genres,
    required super.summary,
    required super.descriptionFull,
    required super.backgroundImage,
    required super.smallCoverImage,
    required super.mediumCoverImage,
    required super.largeCoverImage,
    required super.screenshots,
    required super.cast,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final screenshotsList = <String>[];
    for (int i = 1; i <= 3; i++) {
      final largeShot = json['large_screenshot_image$i'];
      final mediumShot = json['medium_screenshot_image$i'];
      if (largeShot != null && largeShot.toString().isNotEmpty) {
        screenshotsList.add(largeShot.toString());
      } else if (mediumShot != null && mediumShot.toString().isNotEmpty) {
        screenshotsList.add(mediumShot.toString());
      }
    }

    final rawCast = json['cast'] as List<dynamic>? ?? [];
    final castList = rawCast
        .whereType<Map<String, dynamic>>()
        .map((c) => CastModel.fromJson(c))
        .toList();

    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleLong: json['title_long'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'] ?? '',
      descriptionFull: json['description_full'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      screenshots: screenshotsList,
      cast: castList,
    );
  }
}
