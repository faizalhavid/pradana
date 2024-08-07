import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProductionCompany.freezed.dart';
part 'ProductionCompany.g.dart';

@freezed
class ProductionCompany with _$ProductionCompany {
  const factory ProductionCompany({
    required int id,
    required String name,
    String? logo_path,
    String? originCountry,
  }) = _ProductionCompany;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
}
