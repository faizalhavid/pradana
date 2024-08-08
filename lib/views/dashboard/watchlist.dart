import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/widgets/Card/BannerMovieCard.dart';

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchListMovie = ref.watch(watchlistMovieProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
