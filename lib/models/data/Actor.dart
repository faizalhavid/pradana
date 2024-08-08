import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pradana/models/data/Movie.dart';

part 'Actor.freezed.dart';
part 'Actor.g.dart';

@freezed
class Actor with _$Actor {
  const factory Actor({
    required int id,
    bool? adult,
    int? gender,
    String? known_for_department,
    String? name,
    String? original_name,
    double? popularity,
    String? profile_path,
    List<Movie>? known_for,
  }) = _Actor;

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
}
