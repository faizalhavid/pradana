// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductionCompany.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductionCompanyImpl _$$ProductionCompanyImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductionCompanyImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      logoPath: json['logoPath'] as String?,
      originCountry: json['originCountry'] as String?,
    );

Map<String, dynamic> _$$ProductionCompanyImplToJson(
        _$ProductionCompanyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoPath': instance.logoPath,
      'originCountry': instance.originCountry,
    };
