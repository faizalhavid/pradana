import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/RequestToken.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider untuk menyimpan request token.
///
/// Provider ini menggunakan `StateProvider` untuk menyimpan objek `RequestToken?`.
final requesttokenProvider = StateProvider<RequestToken?>((ref) {
  return null;
});

/// Provider untuk menyimpan session ID.
///
/// Provider ini menggunakan `StateProvider` untuk menyimpan string session ID.
final sessionIdProvider = StateProvider<String>((ref) {
  return '';
});

/// Provider untuk menyimpan session.
///
/// Provider ini menggunakan `StateProvider` untuk menyimpan objek `String?`.
final sessionProvider = StateProvider<String?>((ref) {
  return null;
});

/// Provider untuk menyimpan guest session ID.
///
/// Provider ini menggunakan `StateProvider` untuk menyimpan string guest session ID.
final guestSessionProvider = StateProvider<String>((ref) {
  return '';
});

/// Provider untuk menyimpan status loading.
///
/// Provider ini menggunakan `StateProvider` untuk menyimpan status loading sebagai boolean.
final loadingGuestSessionProvider = StateProvider<bool>((ref) => false);
final loadingAuthSessionProvider = StateProvider<bool>((ref) => false);

/// Provider untuk menentukan rute awal aplikasi.
///
/// Provider ini menggunakan `FutureProvider` untuk menentukan rute awal berdasarkan
/// nilai yang disimpan di `SharedPreferences`. Jika `request_token` atau `session_id`
/// ditemukan, rute awal akan diarahkan ke '/dashboard'. Jika tidak, rute awal akan
/// diarahkan ke '/auth/welcome'.
final initialRouteProvider = FutureProvider<String>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final requestToken = prefs.getString('request_token');
  final sessionId =
      prefs.getString('guest_session_id') ?? prefs.getString('session_id');

  if (requestToken != null) {
    try {
      // Assuming requestToken is a plain string, not a JSON string
      ref.read(requesttokenProvider.notifier).state = RequestToken(
          success: true, expires_at: '', request_token: requestToken);
      return '/dashboard';
    } catch (e) {
      print('Error decoding requestToken: $e');
    }
  }
  if (sessionId != null) {
    ref.read(sessionIdProvider.notifier).state = sessionId;
    return '/dashboard';
  }
  return '/auth/welcome';
});
