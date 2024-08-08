import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';

import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/movie.dart';

class InsightMovieCard extends ConsumerWidget {
  final Movie movie;

  const InsightMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFavorite = ref.watch(favoriteMovieProvider).contains(movie);
    final bool isWatchlist = ref.watch(watchlistMovieProvider).contains(movie);

    void handleWatchlistButton() {
      if (isWatchlist) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${movie.title} added to watch list movie!'),
        ));
        ref.read(watchlistMovieProvider.notifier).removeMovie(movie);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${movie.title} added to watch list movie!'),
        ));
        ref.read(watchlistMovieProvider.notifier).addMovie(movie);
      }
    }

    void handleFavoriteButton() {
      if (isFavorite) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${movie.title} removed from favorite movie!'),
        ));
        ref.read(favoriteMovieProvider.notifier).removeMovie(movie);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${movie.title} added to favorite movie!'),
        ));
        ref.read(favoriteMovieProvider.notifier).addMovie(movie);
      }
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 260,
            width: 206,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              placeholderFit: BoxFit.cover,
              placeholderScale: 2,
              image: 'https://image.tmdb.org/t/p/original/${movie.poster_path}',
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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 260,
              width: 206,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard/detail-movie',
                        arguments: movie);
                  },
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
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 206,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.35,
                        ),
                        child: Text(
                          movie.title ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                  Tooltip(
                    message: 'Add to Watchlist',
                    child: IconButton(
                      onPressed: () {
                        handleWatchlistButton();
                      },
                      icon: Icon(
                        isWatchlist
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined,
                        color: isWatchlist
                            ? ColorResources.secondaryColor
                            : ColorResources.neutral300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
