import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/RequestToken.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_api.g.dart';

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
