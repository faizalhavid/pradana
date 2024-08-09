import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProductionCountry.freezed.dart';
part 'ProductionCountry.g.dart';

/// Kelas `ProductionCountry` untuk merepresentasikan negara produksi film.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `iso_3166_1` (String): Kode ISO 3166-1 dari negara.
/// - `name` (String): Nama dari negara.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `ProductionCountry`
/// dari sebuah map JSON.
@freezed
class ProductionCountry with _$ProductionCountry {
  /// Konstruktor untuk `ProductionCountry`.
  ///
  /// Konstruktor ini menerima beberapa parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  const factory ProductionCountry({
    required String iso_3166_1,
    required String name,
  }) = _ProductionCountry;

  /// Metode `fromJson` untuk membuat instance `ProductionCountry` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `ProductionCountry`.
  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
}
