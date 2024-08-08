import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/Movie.dart';

class MovieNotifier extends StateNotifier<List<Movie>> {
  MovieNotifier() : super([]);

  void addMovie(Movie movie) {
    if (!state.contains(movie)) {
      state = [...state, movie];
    }
  }

  void removeMovie(Movie movie) {
    state = state.where((element) => element.id != movie.id).toList();
  }

  void toggleFavorite(Movie movie) {
    if (state.contains(movie)) {
      removeMovie(movie);
    } else {
      addMovie(movie);
    }
  }

  bool isFavorite(Movie movie) {
    return state.contains(movie);
  }

  bool isWatchlist(Movie movie) {
    return state.contains(movie);
  }

  void clear() {
    state = [];
  }
}

final watchlistMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  return MovieNotifier();
});

final favoriteMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  return MovieNotifier();
});
