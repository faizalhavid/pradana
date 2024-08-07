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
    print(movieListJson);
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
