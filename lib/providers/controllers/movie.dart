import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/Movie.dart';

final watchlistMovieProvider = StateProvider<List<Movie?>>((ref) {
  return [];
});
final favoriteMovieProvider = StateProvider<List<Movie?>>((ref) {
  return [];
});
