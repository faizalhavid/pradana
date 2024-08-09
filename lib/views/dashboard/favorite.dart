import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/widgets/Card/BannerMovieCard.dart';

/// Kelas `FavoriteScreen` untuk menampilkan daftar film favorit.
///
/// Kelas ini menggunakan `ConsumerWidget` untuk memungkinkan konsumsi
/// state dari provider.
///
/// Kelas ini memiliki beberapa properti dan metode:
/// - `favoriteMovie` (List<Movie?>): Daftar film favorit yang diambil dari provider.
/// - `size` (Size): Ukuran layar perangkat.
/// - `isDarkMode` (bool): Menunjukkan apakah mode gelap sedang aktif.
///
/// Kelas ini juga menyediakan metode `handleChangeTheme` untuk mengubah tema aplikasi.
///
/// Metode `build` membangun tampilan layar dengan AppBar dan daftar film favorit.
class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovie = ref.watch(favoriteMovieProvider);
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
        title: Text('Film Favorit 🎞️'),
        actions: [
          IconButton(
            onPressed: () => handleChangeTheme(),
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Container(
        height: size.height,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            if (favoriteMovie == null) {
              return Center(
                child: Column(
                  children: [Text('Tidak ada data')],
                ),
              );
            }
            return Container(
              height: size.height * 0.25,
              child: BannerMovieCard(
                movie: favoriteMovie[index]!,
                size: size,
              ),
            );
          },
          itemCount: favoriteMovie.length,
        ),
      ),
    );
  }
}
