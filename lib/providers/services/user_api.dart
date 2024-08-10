import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/models/data/User.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_api.g.dart';

/// Fungsi `getAccountDetails` mengambil detail akun dari API The Movie Database (TMDb).
///
/// Fungsi ini menggunakan Riverpod untuk mengelola state dan dependensi.
/// Fungsi ini mengembalikan sebuah `Future` yang berisi `Map<String, dynamic>` yang merepresentasikan detail akun.

@riverpod
Future<User> getAccountDetails(GetAccountDetailsRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final sessionId = ref.read(sessionIdProvider.notifier).state;

  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/account?session_id=$sessionId'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
  );

  print('response4: ${response.body}');

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get account details');
  }
}

/// Fungsi `getWatchlistMovies` mengambil daftar film yang ditandai sebagai watchlist.
///
/// Fungsi ini menggunakan Riverpod untuk mengelola state dan dependensi.
/// Fungsi ini mengembalikan sebuah `Future` yang berisi daftar film yang ditandai sebagai watchlist.

@riverpod
Future<List<Movie>> getWatchlistMovies(GetWatchlistMoviesRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final sessionId = ref.read(sessionIdProvider.notifier).state;

  final response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/account/$sessionId/watchlist/movies'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
  );

  print('response6: ${response.body}');
  if (response.statusCode == 200) {
    return List<Movie>.from(
        jsonDecode(response.body)['results'].map((x) => Movie.fromJson(x)));
  } else {
    throw Exception('Failed to get watchlist movies');
  }
}

/// Fungsi `getFavoriteMovies` mengambil daftar film yang ditandai sebagai favorit.
///
/// Fungsi ini menggunakan Riverpod untuk mengelola state dan dependensi.
/// Fungsi ini mengembalikan sebuah `Future` yang berisi daftar film yang ditandai sebagai favorit.

@riverpod
Future<List<Movie>> getFavoriteMovies(GetFavoriteMoviesRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final sessionId = ref.read(sessionIdProvider.notifier).state;

  final response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/account/$sessionId/favorite/movies'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
  );

  print('response5: ${response.body}');
  if (response.statusCode == 200) {
    return List<Movie>.from(
        jsonDecode(response.body)['results'].map((x) => Movie.fromJson(x)));
  } else {
    throw Exception('Failed to get favorite movies');
  }
}

/// Fungsi `markAsFavorite` menandai film sebagai favorit.
///
/// Fungsi ini menggunakan Riverpod untuk mengelola state dan dependensi.
/// Fungsi ini mengembalikan sebuah `Future` yang berisi `void`.

@riverpod
Future<void> markAsFavorite(MarkAsFavoriteRef ref, int movieId) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final sessionId = ref.read(sessionIdProvider.notifier).state;

  final response = await http.post(
    Uri.parse('https://api.themoviedb.org/3/account/$sessionId/favorite'),
    headers: {
      'Authorization ': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'media_type': 'movie',
      'media_id': movieId,
      'favorite': true,
    }),
  );

  print('response7: ${response.body}');
  if (response.statusCode != 201) {
    throw Exception('Failed to mark as favorite');
  }
}

/// Fungsi `addToWatchlist` menambahkan film ke watchlist.
///
/// Fungsi ini menggunakan Riverpod untuk mengelola state dan dependensi.
/// Fungsi ini mengembalikan sebuah `Future` yang berisi `void`.

@riverpod
Future<void> addToWatchlist(AddToWatchlistRef ref, int movieId) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final sessionId = ref.read(sessionIdProvider.notifier).state;

  final response = await http.post(
    Uri.parse('https://api.themoviedb.org/3/account/$sessionId/watchlist'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'media_type': 'movie',
      'media_id': movieId,
      'watchlist': true,
    }),
  );

  print('response8: ${response.body}');
  if (response.statusCode != 201) {
    throw Exception('Failed to add to watchlist');
  }
}
