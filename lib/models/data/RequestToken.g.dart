// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestTokenImpl _$$RequestTokenImplFromJson(Map<String, dynamic> json) =>
    _$RequestTokenImpl(
      request_token: json['request_token'] as String,
      success: json['success'] as bool,
      expires_at: json['expires_at'] as String,
    );

Map<String, dynamic> _$$RequestTokenImplToJson(_$RequestTokenImpl instance) =>
    <String, dynamic>{
      'request_token': instance.request_token,
      'success': instance.success,
      'expires_at': instance.expires_at,
    };
