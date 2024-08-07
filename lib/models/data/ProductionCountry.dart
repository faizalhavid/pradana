import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProductionCountry.freezed.dart';
part 'ProductionCountry.g.dart';

@freezed
class ProductionCountry with _$ProductionCountry {
  const factory ProductionCountry({
    required String iso_3166_1,
    required String name,
  }) = _ProductionCountry;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
}
