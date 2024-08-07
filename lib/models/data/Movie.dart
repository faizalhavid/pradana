import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pradana/models/data/BelongsToCollection.dart';
import 'package:pradana/models/data/Genre.dart';
import 'package:pradana/models/data/ProductionCompany.dart';
import 'package:pradana/models/data/ProductionCountry.dart';
import 'package:pradana/models/data/SpokenLanguage.dart';

part 'Movie.freezed.dart';
part 'Movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    int? vote_count,
    bool? video,
    double? vote_average,
    String? title,
    double? popularity,
    String? poster_path,
    String? original_language,
    String? original_title,
    List<int>? genre_ids,
    String? backdrop_path,
    bool? adult,
    String? overview,
    String? release_date,
    BelongsToCollection? belongs_to_collection,
    int? budget,
    List<Genre>? genres,
    String? homepage,
    String? imdb_id,
    List<String>? origin_country,
    List<ProductionCompany>? production_companies,
    List<ProductionCountry>? production_countries,
    int? revenue,
    int? runtime,
    List<SpokenLanguage>? spoken_languages,
    String? status,
    String? tagline,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
