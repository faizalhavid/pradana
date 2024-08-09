import 'package:freezed_annotation/freezed_annotation.dart';

part 'RequestToken.freezed.dart';
part 'RequestToken.g.dart';

/// Kelas `RequestToken` untuk merepresentasikan token permintaan.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `request_token` (String): Token permintaan yang diperlukan.
/// - `success` (bool?, opsional): Menunjukkan apakah permintaan berhasil.
/// - `expires_at` (String?, opsional): Waktu kedaluwarsa token.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `RequestToken`
/// dari sebuah map JSON.
@freezed
class RequestToken with _$RequestToken {
  /// Konstruktor untuk `RequestToken`.
  ///
  /// Konstruktor ini menerima beberapa parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  const factory RequestToken({
    required String request_token,
    bool? success,
    String? expires_at,
  }) = _RequestToken;

  /// Metode `fromJson` untuk membuat instance `RequestToken` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `RequestToken`.
  factory RequestToken.fromJson(Map<String, dynamic> json) =>
      _$RequestTokenFromJson(json);
}
