import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/widgets/Card/BannerMovieCard.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovie = ref.watch(favoriteMovieProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies 🎞️'),
      ),
      body: Container(
        height: size.height,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            if (favoriteMovie == null) {
              return Center(
                child: Column(
                  children: [Text('No data')],
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
