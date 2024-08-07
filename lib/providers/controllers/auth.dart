import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:pradana/models/data/RequestToken.dart';

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
