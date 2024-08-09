import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/RequestToken.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_api.g.dart';

/// Fungsi `createRequestToken` untuk membuat token permintaan baru.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi objek `RequestToken`.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `requesttokenProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk membuat token permintaan baru. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// token permintaan akan disimpan dalam `SharedPreferences` dan fungsi ini
/// akan menguraikan respons JSON dan mengembalikan objek `RequestToken`.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<RequestToken>` yang berisi token permintaan baru.
@riverpod
Future<RequestToken> createRequestToken(CreateRequestTokenRef ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/authentication/token/new'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    prefs.setString('request_token', jsonDecode(response.body));
    return RequestToken.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create request token');
  }
}

/// Fungsi `createSessionId` untuk membuat ID sesi baru.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi string ID sesi.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `requesttokenProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk membuat ID sesi baru menggunakan token permintaan. Token akses diambil
/// dari variabel `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan ID sesi.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<String>` yang berisi ID sesi baru.
@riverpod
Future<String> createSessionId(CreateSessionIdRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];

  final request_token =
      ref.read(requesttokenProvider.notifier).state?.request_token;
  final response = await http.get(
    Uri.parse('https://www.themoviedb.org/authenticate/$request_token'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['session_id'];
  } else {
    throw Exception('Failed to create session id');
  }
}

/// Fungsi `createSession` untuk membuat sesi baru.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi string ID sesi.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `sessionIdProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP POST ke endpoint API The Movie Database
/// untuk membuat sesi baru menggunakan ID sesi. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// fungsi ini akan menguraikan respons JSON dan mengembalikan ID sesi.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<String?>` yang berisi ID sesi baru.
@riverpod
Future<String?> createSession(CreateSessionRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final sessionId = ref.read(sessionIdProvider.notifier).state;
  final response = await http.post(
    Uri.parse('https://api.themoviedb.org/3/authentication/session/new'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'session_id': sessionId,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['session_id'];
  } else {
    throw Exception('Failed to create session');
  }
}

/// Fungsi `createGuestSession` untuk membuat sesi tamu baru.
///
/// Fungsi ini menggunakan anotasi `@riverpod` untuk menandai bahwa ini adalah
/// provider yang mengembalikan `Future` berisi string ID sesi tamu.
///
/// [ref] adalah referensi ke provider yang digunakan untuk membaca state dari
/// `guestSessionProvider`.
///
/// Fungsi ini mengirimkan permintaan HTTP GET ke endpoint API The Movie Database
/// untuk membuat sesi tamu baru. Token akses diambil dari variabel
/// `API_ACCESS_TOKEN`. Jika permintaan berhasil (status kode 200),
/// ID sesi tamu akan disimpan dalam `SharedPreferences` dan fungsi ini
/// akan menguraikan respons JSON dan mengembalikan ID sesi tamu.
/// Jika permintaan gagal, fungsi ini akan melemparkan pengecualian.
///
/// Mengembalikan `Future<String>` yang berisi ID sesi tamu baru.
@riverpod
Future<String> createGuestSession(Ref ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/authentication/guest_session/new'),
    headers: {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    prefs.setString(
        'guest_session_id', jsonDecode(response.body)['guest_session_id']);
    return jsonDecode(response.body)['guest_session_id'];
  } else {
    throw Exception('Failed to create guest session');
  }
}
