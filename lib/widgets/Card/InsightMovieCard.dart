import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';

import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/movie.dart';

/// Kelas `InsightMovieCard` untuk menampilkan kartu film dengan informasi detail.
///
/// Kelas ini menggunakan `ConsumerWidget` untuk memungkinkan konsumsi
/// state dari provider.
///
/// Kelas ini memiliki beberapa properti dan metode:
/// - `movie` (Movie): Objek film yang akan ditampilkan dalam kartu.
///
/// Kelas ini juga menyediakan beberapa metode untuk menangani aksi tombol:
/// - `handleWatchlistButton`: Menambahkan atau menghapus film dari daftar watchlist.
/// - `handleFavoriteButton`: Menambahkan atau menghapus film dari daftar favorit.
class InsightMovieCard extends ConsumerWidget {
  final Movie movie;

  const InsightMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFavorite =
        ref.watch(favoriteMovieProvider).map((m) => m.id).contains(movie.id);
    final bool isWatchlist =
        ref.watch(watchlistMovieProvider).map((m) => m.id).contains(movie.id);

    void handleWatchlistButton() {
      if (isWatchlist) {
        Fluttertoast.showToast(
          msg: '${movie.title} removed from watch list movie!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        ref.read(watchlistMovieProvider.notifier).removeMovie(movie);
      } else {
        Fluttertoast.showToast(
          msg: '${movie.title} added to watch list movie!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        ref.read(watchlistMovieProvider.notifier).addMovie(movie);
      }
    }

    void handleFavoriteButton() {
      if (isFavorite) {
        Fluttertoast.showToast(
          msg: '${movie.title} removed from favorite movie!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        ref.read(favoriteMovieProvider.notifier).removeMovie(movie);
      } else {
        Fluttertoast.showToast(
          msg: '${movie.title} added to favorite movie!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        ref.read(favoriteMovieProvider.notifier).addMovie(movie);
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: 'insight_${movie.id}',
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/placeholder.png',
                            placeholderFit: BoxFit.cover,
                            placeholderScale: 1,
                            image:
                                'https://image.tmdb.org/t/p/original/${movie.poster_path}',
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/dashboard/detail-movie',
                                  arguments: {
                                    'movie': movie,
                                    'tag': 'insight_${movie.id}',
                                  });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 65,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: ColorResources.neutral0,
                                    size: 20,
                                  ),
                                  Text(
                                    movie.vote_average?.toStringAsFixed(1) ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: ColorResources.neutral0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: IconButton(
                              onPressed: () {
                                handleFavoriteButton();
                              },
                              icon: Icon(
                                size: 20,
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? ColorResources.primaryColor
                                    : ColorResources.neutral0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Release Date: ${movie.release_date ?? ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorResources.neutral400,
                        ),
                  ),
                ],
              ),
            ),
            Tooltip(
              message: 'Add to Watchlist',
              child: IconButton(
                onPressed: () {
                  handleWatchlistButton();
                },
                icon: Icon(
                  isWatchlist ? Icons.bookmark : Icons.bookmark_add_outlined,
                  color: isWatchlist
                      ? ColorResources.secondaryColor
                      : ColorResources.neutral300,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
