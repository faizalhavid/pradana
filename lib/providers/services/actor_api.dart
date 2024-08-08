import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pradana/models/data/Actor.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'actor_api.g.dart';

@riverpod
Future<List<Actor>> getPopularActors(GetPopularActorsRef ref) async {
  final access_token = dotenv.env['API_ACCESS_TOKEN'];
  final session = ref.read(sessionProvider.notifier).state ??
      ref.read(guestSessionProvider.notifier).state;
  final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/person/popular?language=en-US&page=1&session_id=$session'),
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    final List<dynamic> actorListJson = jsonDecode(response.body)['results'];
    return actorListJson.map((json) => Actor.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load popular actor');
  }
}
