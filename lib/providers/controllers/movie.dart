import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/Movie.dart';

/// Kelas `MovieNotifier` untuk mengelola daftar film.
///
/// Kelas ini menggunakan `StateNotifier` untuk mengelola state berupa daftar
/// film (`List<Movie>`). Kelas ini menyediakan metode untuk menambah, menghapus,
/// dan memeriksa status film dalam daftar.

class MovieNotifier extends StateNotifier<List<Movie>> {
  /// Konstruktor untuk `MovieNotifier`.
  ///
  /// Menginisialisasi state dengan daftar film kosong.
  MovieNotifier() : super([]);

  /// Menambahkan film ke dalam daftar.
  ///
  /// Jika film belum ada dalam daftar, film akan ditambahkan.
  ///
  /// [movie] adalah objek film yang akan ditambahkan.
  void addMovie(Movie movie) {
    if (!state.contains(movie)) {
      state = [...state, movie];
    }
  }

  /// Menghapus film dari daftar.
  ///
  /// Film akan dihapus dari daftar berdasarkan ID-nya.
  ///
  /// [movie] adalah objek film yang akan dihapus.
  void removeMovie(Movie movie) {
    state = state.where((element) => element.id != movie.id).toList();
  }

  void update(List<Movie> movies) {
    state = movies;
  }

  /// Mengubah status favorit film.
  ///
  /// Jika film sudah ada dalam daftar, film akan dihapus. Jika tidak, film akan ditambahkan.
  ///
  /// [movie] adalah objek film yang status favoritnya akan diubah.
  void toggleFavorite(Movie movie) {
    if (state.contains(movie)) {
      removeMovie(movie);
    } else {
      addMovie(movie);
    }
  }

  /// Memeriksa apakah film adalah favorit.
  ///
  /// Mengembalikan `true` jika film ada dalam daftar, `false` jika tidak.
  ///
  /// [movie] adalah objek film yang akan diperiksa.
  bool isFavorite(Movie movie) {
    return state.contains(movie);
  }

  /// Memeriksa apakah film ada dalam daftar tontonan.
  ///
  /// Mengembalikan `true` jika film ada dalam daftar, `false` jika tidak.
  ///
  /// [movie] adalah objek film yang akan diperiksa.
  bool isWatchlist(Movie movie) {
    return state.contains(movie);
  }

  /// Menghapus semua film dari daftar.
  ///
  /// Mengosongkan daftar film.
  void clear() {
    state = [];
  }
}

/// Provider untuk menyimpan daftar tontonan film.
///
/// Provider ini menggunakan `StateNotifierProvider` untuk menyimpan daftar film
/// dalam bentuk `List<Movie>`. `MovieNotifier` digunakan sebagai pengelola state.
final watchlistMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  return MovieNotifier();
});

/// Provider untuk menyimpan daftar film favorit.
///
/// Provider ini menggunakan `StateNotifierProvider` untuk menyimpan daftar film
/// dalam bentuk `List<Movie>`. `MovieNotifier` digunakan sebagai pengelola state.
final favoriteMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  return MovieNotifier();
});
