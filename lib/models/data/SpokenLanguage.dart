import 'package:freezed_annotation/freezed_annotation.dart';

part 'SpokenLanguage.freezed.dart';
part 'SpokenLanguage.g.dart';

/// Kelas `SpokenLanguage` untuk merepresentasikan bahasa yang digunakan dalam film.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `english_name` (String): Nama bahasa dalam bahasa Inggris.
/// - `iso_639_1` (String): Kode ISO 639-1 dari bahasa.
/// - `name` (String): Nama bahasa.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `SpokenLanguage`
/// dari sebuah map JSON.
@freezed
class SpokenLanguage with _$SpokenLanguage {
  /// Konstruktor untuk `SpokenLanguage`.
  ///
  /// Konstruktor ini menerima beberapa parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  const factory SpokenLanguage({
    required String english_name,
    required String iso_639_1,
    required String name,
  }) = _SpokenLanguage;

  /// Metode `fromJson` untuk membuat instance `SpokenLanguage` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `SpokenLanguage`.
  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);
}
