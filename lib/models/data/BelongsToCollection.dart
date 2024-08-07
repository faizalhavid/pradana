import 'package:freezed_annotation/freezed_annotation.dart';

part 'BelongsToCollection.freezed.dart';
part 'BelongsToCollection.g.dart';

@freezed
class BelongsToCollection with _$BelongsToCollection {
  const factory BelongsToCollection({
    required int id,
    required String name,
    String? poster_path,
    String? backdrop_path,
  }) = _BelongsToCollection;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);
}
