import 'package:freezed_annotation/freezed_annotation.dart';

part 'Genre.freezed.dart';
part 'Genre.g.dart';

/// Kelas `Genre` untuk merepresentasikan genre film.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `id` (int): ID dari genre.
/// - `name` (String): Nama dari genre.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `Genre`
/// dari sebuah map JSON.
@freezed
class Genre with _$Genre {
  /// Konstruktor untuk `Genre`.
  ///
  /// Konstruktor ini menerima beberapa parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  const factory Genre({
    required int id,
    required String name,
  }) = _Genre;

  /// Metode `fromJson` untuk membuat instance `Genre` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `Genre`.
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
