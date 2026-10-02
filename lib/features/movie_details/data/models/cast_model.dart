import 'package:movies_app/features/movie_details/domain/entities/cast_entity.dart';

class CastModel {
  final String name;
  final String characterName;
  final String urlSmallImage;
  final String imdbCode;

  const CastModel({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
    required this.imdbCode,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] as String? ?? '',
      characterName: json['character_name'] as String? ?? '',
      urlSmallImage: json['url_small_image'] as String? ?? '',
      imdbCode: json['imdb_code'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'character_name': characterName,
      'url_small_image': urlSmallImage,
      'imdb_code': imdbCode,
    };
  }

  CastEntity toEntity() {
    return CastEntity(
      name: name,
      characterName: characterName,
      urlSmallImage: urlSmallImage,
      imdbCode: imdbCode,
    );
  }

  factory CastModel.fromEntity(CastEntity entity) {
    return CastModel(
      name: entity.name,
      characterName: entity.characterName,
      urlSmallImage: entity.urlSmallImage,
      imdbCode: entity.imdbCode,
    );
  }
}
