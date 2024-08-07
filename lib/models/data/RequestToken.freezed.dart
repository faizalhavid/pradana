// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'RequestToken.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestToken _$RequestTokenFromJson(Map<String, dynamic> json) {
  return _RequestToken.fromJson(json);
}

/// @nodoc
mixin _$RequestToken {
  String get request_token => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String get expires_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestTokenCopyWith<RequestToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestTokenCopyWith<$Res> {
  factory $RequestTokenCopyWith(
          RequestToken value, $Res Function(RequestToken) then) =
      _$RequestTokenCopyWithImpl<$Res, RequestToken>;
  @useResult
  $Res call({String request_token, bool success, String expires_at});
}

/// @nodoc
class _$RequestTokenCopyWithImpl<$Res, $Val extends RequestToken>
    implements $RequestTokenCopyWith<$Res> {
  _$RequestTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request_token = null,
    Object? success = null,
    Object? expires_at = null,
  }) {
    return _then(_value.copyWith(
      request_token: null == request_token
          ? _value.request_token
          : request_token // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      expires_at: null == expires_at
          ? _value.expires_at
          : expires_at // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestTokenImplCopyWith<$Res>
    implements $RequestTokenCopyWith<$Res> {
  factory _$$RequestTokenImplCopyWith(
          _$RequestTokenImpl value, $Res Function(_$RequestTokenImpl) then) =
      __$$RequestTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String request_token, bool success, String expires_at});
}

/// @nodoc
class __$$RequestTokenImplCopyWithImpl<$Res>
    extends _$RequestTokenCopyWithImpl<$Res, _$RequestTokenImpl>
    implements _$$RequestTokenImplCopyWith<$Res> {
  __$$RequestTokenImplCopyWithImpl(
      _$RequestTokenImpl _value, $Res Function(_$RequestTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request_token = null,
    Object? success = null,
    Object? expires_at = null,
  }) {
    return _then(_$RequestTokenImpl(
      request_token: null == request_token
          ? _value.request_token
          : request_token // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      expires_at: null == expires_at
          ? _value.expires_at
          : expires_at // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestTokenImpl implements _RequestToken {
  const _$RequestTokenImpl(
      {required this.request_token,
      required this.success,
      required this.expires_at});

  factory _$RequestTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestTokenImplFromJson(json);

  @override
  final String request_token;
  @override
  final bool success;
  @override
  final String expires_at;

  @override
  String toString() {
    return 'RequestToken(request_token: $request_token, success: $success, expires_at: $expires_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestTokenImpl &&
            (identical(other.request_token, request_token) ||
                other.request_token == request_token) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.expires_at, expires_at) ||
                other.expires_at == expires_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, request_token, success, expires_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestTokenImplCopyWith<_$RequestTokenImpl> get copyWith =>
      __$$RequestTokenImplCopyWithImpl<_$RequestTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestTokenImplToJson(
      this,
    );
  }
}

abstract class _RequestToken implements RequestToken {
  const factory _RequestToken(
      {required final String request_token,
      required final bool success,
      required final String expires_at}) = _$RequestTokenImpl;

  factory _RequestToken.fromJson(Map<String, dynamic> json) =
      _$RequestTokenImpl.fromJson;

  @override
  String get request_token;
  @override
  bool get success;
  @override
  String get expires_at;
  @override
  @JsonKey(ignore: true)
  _$$RequestTokenImplCopyWith<_$RequestTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
