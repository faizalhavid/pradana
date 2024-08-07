// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieImpl _$$MovieImplFromJson(Map<String, dynamic> json) => _$MovieImpl(
      id: (json['id'] as num).toInt(),
      vote_count: (json['vote_count'] as num?)?.toInt(),
      video: json['video'] as bool?,
      vote_average: (json['vote_average'] as num?)?.toDouble(),
      title: json['title'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      poster_path: json['poster_path'] as String?,
      original_panguage: json['original_panguage'] as String?,
      original_title: json['original_title'] as String?,
      genre_ids: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      backdrop_path: json['backdrop_path'] as String?,
      adult: json['adult'] as bool?,
      overview: json['overview'] as String?,
      release_date: json['release_date'] as String?,
      belongs_to_collection: json['belongs_to_collection'] as String?,
      budget: (json['budget'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String?,
      imdb_id: json['imdb_id'] as String?,
      origin_country: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      production_companies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MovieImplToJson(_$MovieImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vote_count': instance.vote_count,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'title': instance.title,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'original_panguage': instance.original_panguage,
      'original_title': instance.original_title,
      'genre_ids': instance.genre_ids,
      'backdrop_path': instance.backdrop_path,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.release_date,
      'belongs_to_collection': instance.belongs_to_collection,
      'budget': instance.budget,
      'genres': instance.genres,
      'homepage': instance.homepage,
      'imdb_id': instance.imdb_id,
      'origin_country': instance.origin_country,
      'production_companies': instance.production_companies,
    };
