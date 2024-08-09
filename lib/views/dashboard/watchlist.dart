import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/widgets/Card/BannerMovieCard.dart';

/// Kelas `WatchlistScreen` untuk menampilkan daftar film watchlist.
///
/// Kelas ini menggunakan `ConsumerWidget` untuk memungkinkan konsumsi
/// state dari provider.
///
/// Kelas ini memiliki beberapa properti dan metode:
/// - `watchListMovie` (List<Movie?>): Daftar film watchlist yang diambil dari provider.
/// - `size` (Size): Ukuran layar perangkat.
/// - `isDarkMode` (bool): Menunjukkan apakah mode gelap sedang aktif.
/// - `handleChangeTheme` (void): Metode untuk mengganti tema aplikasi.

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchListMovie = ref.watch(watchlistMovieProvider);
    final size = MediaQuery.of(context).size;

    final bool isDarkMode =
        ref.watch(themeControllerProvider).brightness == Brightness.dark;

    void handleChangeTheme() {
      ref.read(themeControllerProvider.notifier).toggleTheme();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text('Watchlist Movies 🌟'),
        actions: [
          IconButton(
            onPressed: () => handleChangeTheme(),
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Container(
        height: size.height,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            if (watchListMovie == null) {
              return Center(
                child: Column(
                  children: [Text('No data')],
                ),
              );
            }
            return Container(
              height: size.height * 0.25,
              child: BannerMovieCard(
                movie: watchListMovie[index]!,
                size: size,
              ),
            );
          },
          itemCount: watchListMovie.length,
        ),
      ),
    );
  }
}
