import 'package:freezed_annotation/freezed_annotation.dart';

part 'RequestToken.freezed.dart';
part 'RequestToken.g.dart';

@freezed
class RequestToken with _$RequestToken {
  const factory RequestToken({
    required String request_token,
    required bool success,
    required String expires_at,
  }) = _RequestToken;

  factory RequestToken.fromJson(Map<String, dynamic> json) =>
      _$RequestTokenFromJson(json);
}
