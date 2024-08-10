import 'package:freezed_annotation/freezed_annotation.dart';

part 'Avatar.freezed.dart';
part 'Avatar.g.dart';

/// Kelas model untuk Avatar.
///
/// Kelas ini menggunakan anotasi `freezed` untuk menghasilkan kode boilerplate
/// seperti metode `copyWith`, `toString`, `hashCode`, dan `==`.
///
/// Kelas ini juga menggunakan anotasi `JsonSerializable` untuk mendukung
/// serialisasi JSON.
@freezed
class Avatar with _$Avatar {
  /// Konstruktor untuk membuat instance `Avatar`.
  ///
  /// Parameter:
  /// - `gravatar`: Objek `Gravatar` yang berisi informasi gravatar pengguna (opsional).
  /// - `tmdb`: Objek `Tmdb` yang berisi informasi avatar TMDb pengguna (opsional).
  const factory Avatar({
    Gravatar? gravatar,
    Tmdb? tmdb,
  }) = _Avatar;

  /// Metode untuk membuat instance `Avatar` dari JSON.
  ///
  /// Parameter:
  /// - `json`: Peta yang berisi data JSON.
  ///
  /// Mengembalikan:
  /// - Instance `Avatar` yang dibuat dari data JSON.
  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
}

/// Kelas model untuk Gravatar.
///
/// Kelas ini menggunakan anotasi `freezed` untuk menghasilkan kode boilerplate
/// seperti metode `copyWith`, `toString`, `hashCode`, dan `==`.
///
/// Kelas ini juga menggunakan anotasi `JsonSerializable` untuk mendukung
/// serialisasi JSON.
@freezed
class Gravatar with _$Gravatar {
  /// Konstruktor untuk membuat instance `Gravatar`.
  ///
  /// Parameter:
  /// - `hash`: Hash gravatar pengguna (opsional).
  const factory Gravatar({
    String? hash,
  }) = _Gravatar;

  /// Metode untuk membuat instance `Gravatar` dari JSON.
  ///
  /// Parameter:
  /// - `json`: Peta yang berisi data JSON.
  ///
  /// Mengembalikan:
  /// - Instance `Gravatar` yang dibuat dari data JSON.
  factory Gravatar.fromJson(Map<String, dynamic> json) =>
      _$GravatarFromJson(json);
}

/// Kelas model untuk TMDb (The Movie Database).
///
/// Kelas ini menggunakan anotasi `freezed` untuk menghasilkan kode boilerplate
/// seperti metode `copyWith`, `toString`, `hashCode`, dan `==`.
///
/// Kelas ini juga menggunakan anotasi `JsonSerializable` untuk mendukung
/// serialisasi JSON.
@freezed
class Tmdb with _$Tmdb {
  /// Konstruktor untuk membuat instance `Tmdb`.
  ///
  /// Parameter:
  /// - `avatarPath`: Jalur avatar TMDb pengguna (opsional).
  const factory Tmdb({
    @JsonKey(name: 'avatar_path') String? avatarPath,
  }) = _Tmdb;

  /// Metode untuk membuat instance `Tmdb` dari JSON.
  ///
  /// Parameter:
  /// - `json`: Peta yang berisi data JSON.
  ///
  /// Mengembalikan:
  /// - Instance `Tmdb` yang dibuat dari data JSON.
  factory Tmdb.fromJson(Map<String, dynamic> json) => _$TmdbFromJson(json);
}
