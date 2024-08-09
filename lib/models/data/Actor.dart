import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pradana/models/data/Movie.dart';

part 'Actor.freezed.dart';
part 'Actor.g.dart';

/// Kelas `Actor` untuk merepresentasikan aktor dalam sebuah film.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `id` (int): ID dari aktor.
/// - `adult` (bool?, opsional): Menunjukkan apakah aktor tersebut dewasa.
/// - `gender` (int?, opsional): Jenis kelamin aktor (1 untuk perempuan, 2 untuk laki-laki).
/// - `known_for_department` (String?, opsional): Departemen yang dikenal oleh aktor.
/// - `name` (String?, opsional): Nama aktor.
/// - `original_name` (String?, opsional): Nama asli aktor.
/// - `popularity` (double?, opsional): Popularitas aktor.
/// - `profile_path` (String?, opsional): Path profil gambar aktor.
/// - `known_for` (List<Movie>?, opsional): Daftar film yang dikenal oleh aktor.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `Actor`
/// dari sebuah map JSON.
@freezed
class Actor with _$Actor {
  /// Konstruktor untuk `Actor`.
  ///
  /// Konstruktor ini menerima beberapa parameter yang diperlukan untuk menginisialisasi
  /// properti kelas.
  const factory Actor({
    required int id,
    bool? adult,
    int? gender,
    String? known_for_department,
    String? name,
    String? original_name,
    double? popularity,
    String? profile_path,
    List<Movie>? known_for,
  }) = _Actor;

  /// Metode `fromJson` untuk membuat instance `Actor` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `Actor`.
  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
}
