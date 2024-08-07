import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:pradana/models/data/RequestToken.dart';
import 'package:shared_preferences/shared_preferences.dart';

final requesttokenProvider = StateProvider<RequestToken?>((ref) {
  return null;
});

final sessionIdProvider = StateProvider<String>((ref) {
  return '';
});

final sessionProvider = StateProvider<String?>((ref) {
  return null;
});

final guestSessionProvider = StateProvider<String>((ref) {
  return '';
});

final loadingProvider = StateProvider<bool>((ref) => false);

final initialRouteProvider = FutureProvider<String>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final requestToken = prefs.getString('request_token');
  final sessionId =
      prefs.getString('guest_session_id') ?? prefs.getString('session_id');

  if (requestToken != null) {
    ref.read(requesttokenProvider.notifier).state =
        RequestToken.fromJson(jsonDecode(requestToken));
    return '/dashboard';
  }
  if (sessionId != null) {
    ref.read(sessionIdProvider.notifier).state = sessionId;
    return '/dashboard';
  }
  return '/auth/welcome';
});
