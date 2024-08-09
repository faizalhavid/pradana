import 'package:freezed_annotation/freezed_annotation.dart';

part 'BelongsToCollection.freezed.dart';
part 'BelongsToCollection.g.dart';

/// Kelas `BelongsToCollection` untuk merepresentasikan koleksi yang dimiliki oleh sebuah film.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `id` (int): ID dari koleksi.
/// - `name` (String): Nama dari koleksi.
/// - `poster_path` (String?, opsional): Path poster dari koleksi.
/// - `backdrop_path` (String?, opsional): Path backdrop dari koleksi.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `BelongsToCollection`
/// dari sebuah map JSON.
@freezed
class BelongsToCollection with _$BelongsToCollection {
  /// Konstruktor untuk `BelongsToCollection`.
  ///
  /// Konstruktor ini menerima beberapa parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  const factory BelongsToCollection({
    required int id,
    required String name,
    String? poster_path,
    String? backdrop_path,
  }) = _BelongsToCollection;

  /// Metode `fromJson` untuk membuat instance `BelongsToCollection` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `BelongsToCollection`.
  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);
}
