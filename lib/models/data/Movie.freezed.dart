// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return _Movie.fromJson(json);
}

/// @nodoc
mixin _$Movie {
  int get id => throw _privateConstructorUsedError;
  int? get vote_count => throw _privateConstructorUsedError;
  bool? get video => throw _privateConstructorUsedError;
  double? get vote_average => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  double? get popularity => throw _privateConstructorUsedError;
  String? get poster_path => throw _privateConstructorUsedError;
  String? get original_panguage => throw _privateConstructorUsedError;
  String? get original_title => throw _privateConstructorUsedError;
  List<int>? get genre_ids => throw _privateConstructorUsedError;
  String? get backdrop_path => throw _privateConstructorUsedError;
  bool? get adult => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get release_date => throw _privateConstructorUsedError;
  String? get belongs_to_collection => throw _privateConstructorUsedError;
  int? get budget => throw _privateConstructorUsedError;
  List<Genre>? get genres => throw _privateConstructorUsedError;
  String? get homepage => throw _privateConstructorUsedError;
  String? get imdb_id => throw _privateConstructorUsedError;
  List<String>? get origin_country => throw _privateConstructorUsedError;
  List<ProductionCompany>? get production_companies =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res, Movie>;
  @useResult
  $Res call(
      {int id,
      int? vote_count,
      bool? video,
      double? vote_average,
      String? title,
      double? popularity,
      String? poster_path,
      String? original_panguage,
      String? original_title,
      List<int>? genre_ids,
      String? backdrop_path,
      bool? adult,
      String? overview,
      String? release_date,
      String? belongs_to_collection,
      int? budget,
      List<Genre>? genres,
      String? homepage,
      String? imdb_id,
      List<String>? origin_country,
      List<ProductionCompany>? production_companies});
}

/// @nodoc
class _$MovieCopyWithImpl<$Res, $Val extends Movie>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vote_count = freezed,
    Object? video = freezed,
    Object? vote_average = freezed,
    Object? title = freezed,
    Object? popularity = freezed,
    Object? poster_path = freezed,
    Object? original_panguage = freezed,
    Object? original_title = freezed,
    Object? genre_ids = freezed,
    Object? backdrop_path = freezed,
    Object? adult = freezed,
    Object? overview = freezed,
    Object? release_date = freezed,
    Object? belongs_to_collection = freezed,
    Object? budget = freezed,
    Object? genres = freezed,
    Object? homepage = freezed,
    Object? imdb_id = freezed,
    Object? origin_country = freezed,
    Object? production_companies = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      vote_count: freezed == vote_count
          ? _value.vote_count
          : vote_count // ignore: cast_nullable_to_non_nullable
              as int?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool?,
      vote_average: freezed == vote_average
          ? _value.vote_average
          : vote_average // ignore: cast_nullable_to_non_nullable
              as double?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      poster_path: freezed == poster_path
          ? _value.poster_path
          : poster_path // ignore: cast_nullable_to_non_nullable
              as String?,
      original_panguage: freezed == original_panguage
          ? _value.original_panguage
          : original_panguage // ignore: cast_nullable_to_non_nullable
              as String?,
      original_title: freezed == original_title
          ? _value.original_title
          : original_title // ignore: cast_nullable_to_non_nullable
              as String?,
      genre_ids: freezed == genre_ids
          ? _value.genre_ids
          : genre_ids // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      backdrop_path: freezed == backdrop_path
          ? _value.backdrop_path
          : backdrop_path // ignore: cast_nullable_to_non_nullable
              as String?,
      adult: freezed == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      release_date: freezed == release_date
          ? _value.release_date
          : release_date // ignore: cast_nullable_to_non_nullable
              as String?,
      belongs_to_collection: freezed == belongs_to_collection
          ? _value.belongs_to_collection
          : belongs_to_collection // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int?,
      genres: freezed == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      imdb_id: freezed == imdb_id
          ? _value.imdb_id
          : imdb_id // ignore: cast_nullable_to_non_nullable
              as String?,
      origin_country: freezed == origin_country
          ? _value.origin_country
          : origin_country // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      production_companies: freezed == production_companies
          ? _value.production_companies
          : production_companies // ignore: cast_nullable_to_non_nullable
              as List<ProductionCompany>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieImplCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$$MovieImplCopyWith(
          _$MovieImpl value, $Res Function(_$MovieImpl) then) =
      __$$MovieImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? vote_count,
      bool? video,
      double? vote_average,
      String? title,
      double? popularity,
      String? poster_path,
      String? original_panguage,
      String? original_title,
      List<int>? genre_ids,
      String? backdrop_path,
      bool? adult,
      String? overview,
      String? release_date,
      String? belongs_to_collection,
      int? budget,
      List<Genre>? genres,
      String? homepage,
      String? imdb_id,
      List<String>? origin_country,
      List<ProductionCompany>? production_companies});
}

/// @nodoc
class __$$MovieImplCopyWithImpl<$Res>
    extends _$MovieCopyWithImpl<$Res, _$MovieImpl>
    implements _$$MovieImplCopyWith<$Res> {
  __$$MovieImplCopyWithImpl(
      _$MovieImpl _value, $Res Function(_$MovieImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vote_count = freezed,
    Object? video = freezed,
    Object? vote_average = freezed,
    Object? title = freezed,
    Object? popularity = freezed,
    Object? poster_path = freezed,
    Object? original_panguage = freezed,
    Object? original_title = freezed,
    Object? genre_ids = freezed,
    Object? backdrop_path = freezed,
    Object? adult = freezed,
    Object? overview = freezed,
    Object? release_date = freezed,
    Object? belongs_to_collection = freezed,
    Object? budget = freezed,
    Object? genres = freezed,
    Object? homepage = freezed,
    Object? imdb_id = freezed,
    Object? origin_country = freezed,
    Object? production_companies = freezed,
  }) {
    return _then(_$MovieImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      vote_count: freezed == vote_count
          ? _value.vote_count
          : vote_count // ignore: cast_nullable_to_non_nullable
              as int?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool?,
      vote_average: freezed == vote_average
          ? _value.vote_average
          : vote_average // ignore: cast_nullable_to_non_nullable
              as double?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
      poster_path: freezed == poster_path
          ? _value.poster_path
          : poster_path // ignore: cast_nullable_to_non_nullable
              as String?,
      original_panguage: freezed == original_panguage
          ? _value.original_panguage
          : original_panguage // ignore: cast_nullable_to_non_nullable
              as String?,
      original_title: freezed == original_title
          ? _value.original_title
          : original_title // ignore: cast_nullable_to_non_nullable
              as String?,
      genre_ids: freezed == genre_ids
          ? _value._genre_ids
          : genre_ids // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      backdrop_path: freezed == backdrop_path
          ? _value.backdrop_path
          : backdrop_path // ignore: cast_nullable_to_non_nullable
              as String?,
      adult: freezed == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      release_date: freezed == release_date
          ? _value.release_date
          : release_date // ignore: cast_nullable_to_non_nullable
              as String?,
      belongs_to_collection: freezed == belongs_to_collection
          ? _value.belongs_to_collection
          : belongs_to_collection // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int?,
      genres: freezed == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>?,
      homepage: freezed == homepage
          ? _value.homepage
          : homepage // ignore: cast_nullable_to_non_nullable
              as String?,
      imdb_id: freezed == imdb_id
          ? _value.imdb_id
          : imdb_id // ignore: cast_nullable_to_non_nullable
              as String?,
      origin_country: freezed == origin_country
          ? _value._origin_country
          : origin_country // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      production_companies: freezed == production_companies
          ? _value._production_companies
          : production_companies // ignore: cast_nullable_to_non_nullable
              as List<ProductionCompany>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieImpl implements _Movie {
  const _$MovieImpl(
      {required this.id,
      this.vote_count,
      this.video,
      this.vote_average,
      this.title,
      this.popularity,
      this.poster_path,
      this.original_panguage,
      this.original_title,
      final List<int>? genre_ids,
      this.backdrop_path,
      this.adult,
      this.overview,
      this.release_date,
      this.belongs_to_collection,
      this.budget,
      final List<Genre>? genres,
      this.homepage,
      this.imdb_id,
      final List<String>? origin_country,
      final List<ProductionCompany>? production_companies})
      : _genre_ids = genre_ids,
        _genres = genres,
        _origin_country = origin_country,
        _production_companies = production_companies;

  factory _$MovieImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieImplFromJson(json);

  @override
  final int id;
  @override
  final int? vote_count;
  @override
  final bool? video;
  @override
  final double? vote_average;
  @override
  final String? title;
  @override
  final double? popularity;
  @override
  final String? poster_path;
  @override
  final String? original_panguage;
  @override
  final String? original_title;
  final List<int>? _genre_ids;
  @override
  List<int>? get genre_ids {
    final value = _genre_ids;
    if (value == null) return null;
    if (_genre_ids is EqualUnmodifiableListView) return _genre_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? backdrop_path;
  @override
  final bool? adult;
  @override
  final String? overview;
  @override
  final String? release_date;
  @override
  final String? belongs_to_collection;
  @override
  final int? budget;
  final List<Genre>? _genres;
  @override
  List<Genre>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? homepage;
  @override
  final String? imdb_id;
  final List<String>? _origin_country;
  @override
  List<String>? get origin_country {
    final value = _origin_country;
    if (value == null) return null;
    if (_origin_country is EqualUnmodifiableListView) return _origin_country;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductionCompany>? _production_companies;
  @override
  List<ProductionCompany>? get production_companies {
    final value = _production_companies;
    if (value == null) return null;
    if (_production_companies is EqualUnmodifiableListView)
      return _production_companies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Movie(id: $id, vote_count: $vote_count, video: $video, vote_average: $vote_average, title: $title, popularity: $popularity, poster_path: $poster_path, original_panguage: $original_panguage, original_title: $original_title, genre_ids: $genre_ids, backdrop_path: $backdrop_path, adult: $adult, overview: $overview, release_date: $release_date, belongs_to_collection: $belongs_to_collection, budget: $budget, genres: $genres, homepage: $homepage, imdb_id: $imdb_id, origin_country: $origin_country, production_companies: $production_companies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vote_count, vote_count) ||
                other.vote_count == vote_count) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.vote_average, vote_average) ||
                other.vote_average == vote_average) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.poster_path, poster_path) ||
                other.poster_path == poster_path) &&
            (identical(other.original_panguage, original_panguage) ||
                other.original_panguage == original_panguage) &&
            (identical(other.original_title, original_title) ||
                other.original_title == original_title) &&
            const DeepCollectionEquality()
                .equals(other._genre_ids, _genre_ids) &&
            (identical(other.backdrop_path, backdrop_path) ||
                other.backdrop_path == backdrop_path) &&
            (identical(other.adult, adult) || other.adult == adult) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.release_date, release_date) ||
                other.release_date == release_date) &&
            (identical(other.belongs_to_collection, belongs_to_collection) ||
                other.belongs_to_collection == belongs_to_collection) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.homepage, homepage) ||
                other.homepage == homepage) &&
            (identical(other.imdb_id, imdb_id) || other.imdb_id == imdb_id) &&
            const DeepCollectionEquality()
                .equals(other._origin_country, _origin_country) &&
            const DeepCollectionEquality()
                .equals(other._production_companies, _production_companies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        vote_count,
        video,
        vote_average,
        title,
        popularity,
        poster_path,
        original_panguage,
        original_title,
        const DeepCollectionEquality().hash(_genre_ids),
        backdrop_path,
        adult,
        overview,
        release_date,
        belongs_to_collection,
        budget,
        const DeepCollectionEquality().hash(_genres),
        homepage,
        imdb_id,
        const DeepCollectionEquality().hash(_origin_country),
        const DeepCollectionEquality().hash(_production_companies)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      __$$MovieImplCopyWithImpl<_$MovieImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieImplToJson(
      this,
    );
  }
}

abstract class _Movie implements Movie {
  const factory _Movie(
      {required final int id,
      final int? vote_count,
      final bool? video,
      final double? vote_average,
      final String? title,
      final double? popularity,
      final String? poster_path,
      final String? original_panguage,
      final String? original_title,
      final List<int>? genre_ids,
      final String? backdrop_path,
      final bool? adult,
      final String? overview,
      final String? release_date,
      final String? belongs_to_collection,
      final int? budget,
      final List<Genre>? genres,
      final String? homepage,
      final String? imdb_id,
      final List<String>? origin_country,
      final List<ProductionCompany>? production_companies}) = _$MovieImpl;

  factory _Movie.fromJson(Map<String, dynamic> json) = _$MovieImpl.fromJson;

  @override
  int get id;
  @override
  int? get vote_count;
  @override
  bool? get video;
  @override
  double? get vote_average;
  @override
  String? get title;
  @override
  double? get popularity;
  @override
  String? get poster_path;
  @override
  String? get original_panguage;
  @override
  String? get original_title;
  @override
  List<int>? get genre_ids;
  @override
  String? get backdrop_path;
  @override
  bool? get adult;
  @override
  String? get overview;
  @override
  String? get release_date;
  @override
  String? get belongs_to_collection;
  @override
  int? get budget;
  @override
  List<Genre>? get genres;
  @override
  String? get homepage;
  @override
  String? get imdb_id;
  @override
  List<String>? get origin_country;
  @override
  List<ProductionCompany>? get production_companies;
  @override
  @JsonKey(ignore: true)
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
