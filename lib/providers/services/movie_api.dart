import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pradana/models/data/Genre.dart';
import 'dart:convert';

import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_api.g.dart';

@riverpod
Future<List<Movie>> getMoviesNowPlaying(GetMoviesNowPlayingRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    final limitedMovies = movieListJson.take(6).toList();
    return limitedMovies.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

@riverpod
Future<List<Movie>> getMoviesPopular(GetMoviesPopularRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

@riverpod
Future<List<Genre>> getGenres(GetGenresRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=en-US'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final List<dynamic> genreListJson = jsonDecode(response.body)['genres'];
    return genreListJson.map((json) => Genre.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load genres');
  }
}

@riverpod
Future<Movie> getMovieDetail(GetMovieDetailRef ref, int id) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/$id?language=en-US&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load movie detail');
  }
}

@riverpod
Future<List<Movie>> searchMovies(SearchMoviesRef ref, String query) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?language=en-US&query=$query&page=1&include_adult=false'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to search movies');
  }
}

@riverpod
Future<List<Movie>> getWatchlist(GetWatchlistRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/watchlist/movies?language=en-US&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load watchlist');
  }
}

@riverpod
Future<List<Movie>> getFavorites(GetFavoritesRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/favorite/movies?language=en-US&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final List<dynamic> movieListJson = jsonDecode(response.body)['results'];
    return movieListJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load favorites');
  }
}

@riverpod
Future<void> addMovieToWatchlist(AddMovieToWatchlistRef ref, int id) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.post(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/watchlist?session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {'media_type': 'movie', 'media_id': id, 'watchlist': true}));
  if (response.statusCode != 201) {
    throw Exception('Failed to add movie to watchlist');
  }
}

@riverpod
Future<void> addMovieToFavorites(AddMovieToFavoritesRef ref, int id) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.post(
      Uri.parse(
          'https://api.themoviedb.org/3/account/{account_id}/favorite?session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {'media_type': 'movie', 'media_id': id, 'favorite': true}));
  if (response.statusCode != 201) {
    throw Exception('Failed to add movie to favorites');
  }
}
