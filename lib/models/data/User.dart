import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pradana/models/data/Avatar.dart';

part 'User.freezed.dart';
part 'User.g.dart';

/// Kelas model untuk pengguna (User).
///
/// Kelas ini menggunakan anotasi `freezed` untuk menghasilkan kode boilerplate
/// seperti metode `copyWith`, `toString`, `hashCode`, dan `==`.
///
/// Kelas ini juga menggunakan anotasi `JsonSerializable` untuk mendukung
/// serialisasi JSON.
@freezed
class User with _$User {
  /// Konstruktor untuk membuat instance `User`.
  ///
  /// Parameter:
  /// - `id`: ID unik untuk pengguna (wajib).
  /// - `username`: Nama pengguna (opsional).
  /// - `name`: Nama lengkap pengguna (opsional).
  /// - `email`: Alamat email pengguna (opsional).
  /// - `includeAdult`: Apakah pengguna termasuk konten dewasa (opsional).
  /// - `avatar`: Objek `Avatar` yang berisi informasi avatar pengguna (opsional).
  const factory User({
    required int id,
    String? username,
    String? name,
    String? email,
    @JsonKey(name: 'include_adult') bool? includeAdult,
    Avatar? avatar,
  }) = _User;

  /// Metode untuk membuat instance `User` dari JSON.
  ///
  /// Parameter:
  /// - `json`: Peta yang berisi data JSON.
  ///
  /// Mengembalikan:
  /// - Instance `User` yang dibuat dari data JSON.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
