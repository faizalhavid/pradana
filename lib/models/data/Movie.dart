import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pradana/models/data/BelongsToCollection.dart';
import 'package:pradana/models/data/Genre.dart';
import 'package:pradana/models/data/ProductionCompany.dart';
import 'package:pradana/models/data/ProductionCountry.dart';
import 'package:pradana/models/data/SpokenLanguage.dart';

part 'Movie.freezed.dart';
part 'Movie.g.dart';

/// Kelas `Movie` untuk merepresentasikan sebuah film.
///
/// Kelas ini menggunakan anotasi `@freezed` untuk menghasilkan kode boilerplate
/// seperti konstruktor, metode `copyWith`, dan metode `toJson`.
///
/// Kelas ini memiliki beberapa properti:
/// - `id` (int): ID dari film.
/// - `vote_count` (int?, opsional): Jumlah suara yang diterima film.
/// - `video` (bool?, opsional): Menunjukkan apakah film tersebut adalah video.
/// - `vote_average` (double?, opsional): Rata-rata suara yang diterima film.
/// - `title` (String?, opsional): Judul film.
/// - `popularity` (double?, opsional): Popularitas film.
/// - `poster_path` (String?, opsional): Path poster film.
/// - `original_language` (String?, opsional): Bahasa asli film.
/// - `original_title` (String?, opsional): Judul asli film.
/// - `genre_ids` (List<int>?, opsional): Daftar ID genre film.
/// - `backdrop_path` (String?, opsional): Path backdrop film.
/// - `adult` (bool?, opsional): Menunjukkan apakah film tersebut untuk dewasa.
/// - `overview` (String?, opsional): Deskripsi singkat film.
/// - `release_date` (String?, opsional): Tanggal rilis film.
/// - `belongs_to_collection` (BelongsToCollection?, opsional): Koleksi yang dimiliki oleh film.
/// - `budget` (int?, opsional): Anggaran film.
/// - `genres` (List<Genre>?, opsional): Daftar genre film.
/// - `homepage` (String?, opsional): Halaman utama film.
/// - `imdb_id` (String?, opsional): ID IMDb film.
/// - `origin_country` (List<String>?, opsional): Daftar negara asal film.
/// - `production_companies` (List<ProductionCompany>?, opsional): Daftar perusahaan produksi film.
/// - `production_countries` (List<ProductionCountry>?, opsional): Daftar negara produksi film.
/// - `revenue` (int?, opsional): Pendapatan film.
/// - `runtime` (int?, opsional): Durasi film dalam menit.
/// - `spoken_languages` (List<SpokenLanguage>?, opsional): Daftar bahasa yang digunakan dalam film.
/// - `status` (String?, opsional): Status rilis film.
/// - `tagline` (String?, opsional): Tagline film.
///
/// Kelas ini juga menyediakan metode `fromJson` untuk membuat instance `Movie`
/// dari sebuah map JSON.
@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    int? vote_count,
    bool? video,
    double? vote_average,
    String? title,
    double? popularity,
    String? poster_path,
    String? original_language,
    String? original_title,
    List<int>? genre_ids,
    String? backdrop_path,
    bool? adult,
    String? overview,
    String? release_date,
    BelongsToCollection? belongs_to_collection,
    int? budget,
    List<Genre>? genres,
    String? homepage,
    String? imdb_id,
    List<String>? origin_country,
    List<ProductionCompany>? production_companies,
    List<ProductionCountry>? production_countries,
    int? revenue,
    int? runtime,
    List<SpokenLanguage>? spoken_languages,
    String? status,
    String? tagline,
  }) = _Movie;

  /// Metode `fromJson` untuk membuat instance `Movie` dari sebuah map JSON.
  ///
  /// [json] adalah map yang berisi data JSON.
  ///
  /// Mengembalikan instance `Movie`.

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
