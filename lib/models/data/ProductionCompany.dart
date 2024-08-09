import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProductionCompany.freezed.dart';
part 'ProductionCompany.g.dart';

/// Kelas `ProductionCompany` untuk merepresentasikan perusahaan produksi film.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `id` (int): ID dari perusahaan produksi.
/// - `name` (String): Nama dari perusahaan produksi.
/// - `logo_path` (String?, opsional): Path logo dari perusahaan produksi.
/// - `originCountry` (String?, opsional): Negara asal dari perusahaan produksi.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `ProductionCompany`
/// dari sebuah map JSON.
@freezed
class ProductionCompany with _$ProductionCompany {
  /// Konstruktor untuk `ProductionCompany`.
  ///
  /// Konstruktor ini menerima beberapa parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  const factory ProductionCompany({
    required int id,
    required String name,
    String? logo_path,
    String? originCountry,
  }) = _ProductionCompany;

  /// Metode `fromJson` untuk membuat instance `ProductionCompany` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `ProductionCompany`.
  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
}
