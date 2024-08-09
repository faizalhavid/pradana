import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pradana/models/data/Actor.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'actor_api.g.dart';

/// Fungsi `getPopularActors` untuk mendapatkan daftar aktor populer.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi daftar `Actor`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionProvider` atau `guestSessionProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk mendapatkan daftar aktor populer. Token akses diambil dari variabel
/// lingkungan `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan daftar objek `Actor`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<List<Actor>>` yang berisi daftar aktor populer.
@riverpod
Future<List<Actor>> getPopularActors(GetPopularActorsRef ref) async {
  // Mengambil token akses dari environment variable.
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  // Mengambil session id dari provider.
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  // Mengirimkan permintaan HTTP GET ke endpoint API The Movie Database.
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/person/popular?language=en-US&page=1&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });

  // Menguraikan respons JSON dan mengembalikan daftar aktor.
  if (response.statusCode == 200) {
    final List<dynamic> actorListJson = jsonDecode(response.body)['results'];
    return actorListJson.map((json) => Actor.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load popular actor');
  }
}
