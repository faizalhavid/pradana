import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pradana/models/data/Genre.dart';
import 'dart:convert';

import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_api.g.dart';

/// Fungsi `getMoviesNowPlaying` untuk mendapatkan daftar film yang sedang tayang.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi daftar `Movie`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mendapatkan daftar film yang sedang tayang. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan daftar objek `Movie`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<List<Movie>>` yang berisi daftar film yang sedang tayang.
@riverpod
Future<List<Movie>> getMoviesNowPlaying(GetMoviesNowPlayingRef ref) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  // Menguraikan respons JSON dan mengembalikan daftar film.
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    final limitedMovies = movieListJson.take(6).toList();
    return limitedMovies.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

/// Fungsi `getMoviesPopular` untuk mendapatkan daftar film populer.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi daftar `Movie`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mendapatkan daftar film populer. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan daftar objek `Movie`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<List<Movie>>` yang berisi daftar film populer.
@riverpod
Future<List<Movie>> getMoviesPopular(GetMoviesPopularRef ref) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  // Menguraikan respons JSON dan mengembalikan daftar film.
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

/// Fungsi `getGenres` untuk mendapatkan daftar genre film.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi daftar `Genre`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mendapatkan daftar genre film. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan daftar objek `Genre`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<List<Genre>>` yang berisi daftar genre film.
@riverpod
Future<List<Genre>> getGenres(GetGenresRef ref) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=en-US'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  // Menguraikan respons JSON dan mengembalikan daftar genre.
  if (response.statusCode == 200) {
    final List<dynamic> genreListJson = jsonDecode(response.body)['genres'];
    return genreListJson.map((json) => Genre.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load genres');
  }
}

/// Fungsi `getMovieDetail` untuk mendapatkan detail film berdasarkan ID.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi objek `Movie`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// [id] adalah ID film yang detailnya akan diambil.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mendapatkan detail film berdasarkan ID. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan objek `Movie`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<Movie>` yang berisi detail film.
@riverpod
Future<Movie> getMovieDetail(GetMovieDetailRef ref, int id) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/$id?language=en-US&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  // Menguraikan respons JSON dan mengembalikan detail film.
  if (response.statusCode == 200) {
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load movie detail');
  }
}

/// Fungsi `searchMovies` untuk mencari film berdasarkan query.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi daftar `Movie`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// [query] adalah string query yang digunakan untuk mencari film.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mencari film berdasarkan query. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan daftar objek `Movie`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<List<Movie>>` yang berisi daftar film hasil pencarian.
@riverpod
Future<List<Movie>> searchMovies(SearchMoviesRef ref, String query) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?language=en-US&query=$query&page=1&include_adult=false'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  // Menguraikan respons JSON dan mengembalikan daftar film hasil pencarian.
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to search movies');
  }
}

/// Fungsi `getWatchlist` untuk mendapatkan daftar film watchlist pengguna.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi daftar `Movie`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mendapatkan daftar film watchlist pengguna. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan daftar objek `Movie`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<List<Movie>>` yang berisi daftar film watchlist pengguna.
@riverpod
Future<List<Movie>> getWatchlist(GetWatchlistRef ref) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/watchlist/movies?language=en-US&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  // Menguraikan respons JSON dan mengembalikan daftar film watchlist.
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load watchlist');
  }
}

/// Fungsi `getFavorites` untuk mendapatkan daftar film favorit pengguna.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi daftar `Movie`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mendapatkan daftar film favorit pengguna. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan daftar objek `Movie`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<List<Movie>>` yang berisi daftar film favorit pengguna.
@riverpod
Future<List<Movie>> getFavorites(GetFavoritesRef ref) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/favorite/movies?language=en-US&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  // Menguraikan respons JSON dan mengembalikan daftar film favorit.
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load favorites');
  }
}

/// Fungsi `addMovieToWatchlist` untuk menambahkan film ke watchlist pengguna.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` tanpa nilai (void).
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// [id] adalah ID film yang akan ditambahkan ke watchlist.
///
/// Fungsi ini mengirimkan permintaan HTTP POST ke endpoint API The Movie Database
/// untuk menambahkan film ke watchlist pengguna. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 201),
/// film akan ditambahkan ke watchlist. Jika permintaan gagal, fungsi ini akan
/// melemparkan pengecualian.
///
/// Mengembalikan `Future<void>` yang menandakan bahwa film telah ditambahkan ke watchlist.
@riverpod
Future<void> addMovieToWatchlist(AddMovieToWatchlistRef ref, int id) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;

  // Mengirimkan permintaan HTTP POST ke endpoint API The Movie Database.
  final response = await http.post(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/watchlist?session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {'media_type': 'movie', 'media_id': id, 'watchlist': true}));
  // Jika permintaan gagal, melemparkan pengecualian.
  if (response.statusCode != 201) {
    throw Exception('Failed to add movie to watchlist');
  }
}

/// Fungsi `addMovieToFavorites` untuk menambahkan film ke daftar favorit pengguna.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` tanpa nilai (void).
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// [id] adalah ID film yang akan ditambahkan ke daftar favorit.
///
/// Fungsi ini mengirimkan permintaan HTTP POST ke endpoint API The Movie Database
/// untuk menambahkan film ke daftar favorit pengguna. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 201),
/// film akan ditambahkan ke daftar favorit. Jika permintaan gagal, fungsi ini akan
/// melemparkan pengecualian.
///
/// Mengembalikan `Future<void>` yang menandakan bahwa film telah ditambahkan ke daftar favorit.
@riverpod
Future<void> addMovieToFavorites(AddMovieToFavoritesRef ref, int id) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  // Mengirimkan permintaan HTTP POST ke endpoint API The Movie Database.
  final response = await http.post(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/favorite?session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {'media_type': 'movie', 'media_id': id, 'favorite': true}));
  // Jika permintaan gagal, melemparkan pengecualian.
  if (response.statusCode != 201) {
    throw Exception('Failed to add movie to favorites');
  }
}
