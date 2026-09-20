import 'package:movies_app/features/movie_details/domain/entities/cast_entity.dart';

class CastModel extends CastEntity {
  const CastModel({
    required super.name,
    required super.characterName,
    required super.urlSmallImage,
    required super.imdbCode,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      urlSmallImage: json['url_small_image'] ?? '',
      imdbCode: json['imdb_code'] ?? '',
    );
  }
}
