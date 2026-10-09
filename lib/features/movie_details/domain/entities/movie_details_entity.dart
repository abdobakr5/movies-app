import 'cast_entity.dart';

class MovieDetailsEntity {
  final int id;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final int year;
  final double rating;
  final int runtime;
  final int likeCount;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String backgroundImage;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<String> screenshots;
  final List<CastEntity> cast;

  const MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.likeCount,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.backgroundImage,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.screenshots,
    required this.cast,
  });
}
