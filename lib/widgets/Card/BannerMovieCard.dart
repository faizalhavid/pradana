import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Genre.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/providers/services/movie_api.dart';

class BannerMovieCard extends ConsumerWidget {
  const BannerMovieCard({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Genre>> genresAsyncValue =
        ref.watch(getGenresProvider);
    final watchlistMovie = ref.watch(watchlistMovieProvider);
    bool isAddedWatchlist = watchlistMovie.contains(movie);

    void handleWatchlistButton() {
      if (!isAddedWatchlist) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${movie.title} added to watch list movie !'),
        ));
        ref.read(watchlistMovieProvider.notifier).state.add(movie);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${movie.title} already added to watch list movie !'),
      ));
    }

    return Container(
      child: Stack(
        children: [
          Hero(
            tag: movie.id,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: size.width,
                    // height: double.infinity,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      placeholderFit: BoxFit.cover,
                      placeholderScale: 2,
                      alignment: Alignment.centerRight,
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          ColorResources.neutral800.withOpacity(0.8),
                          ColorResources.neutral800.withOpacity(0.3),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            width: size.width * 0.8,
            child: Material(
              color: Colors
                  .transparent, // Make the material background transparent
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  // Navigate to the detail movie screen
                  Navigator.pushNamed(context, '/dashboard/detail-movie',
                          arguments: movie)
                      .then((_) {
                    // This block will be executed when the user returns to this screen
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: ColorResources.neutral0,
                              ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: Wrap(
                            children: [
                              if (genresAsyncValue.when(
                                  data: (genres) => genres
                                      .where((genre) =>
                                          movie.genre_ids!.contains(genre.id))
                                      .isNotEmpty,
                                  loading: () => false,
                                  error: (err, stack) => false))
                                ...genresAsyncValue.value!
                                    .where((genre) =>
                                        movie.genre_ids!.contains(genre.id))
                                    .take(5) // Limit to 5 genres
                                    .map((genre) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: ColorResources.neutral0
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(genre.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: ColorResources.neutral0,
                                              fontWeight: FontWeight.w600,
                                            )),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: ColorResources.neutral0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      handleWatchlistButton();
                    },
                    icon: CircleAvatar(
                      backgroundColor: isAddedWatchlist
                          ? ColorResources.neutral0
                          : Colors.transparent,
                      child: Icon(
                        isAddedWatchlist
                            ? Icons.bookmark_add
                            : Icons.bookmark_border,
                        color: isAddedWatchlist
                            ? ColorResources.secondaryColor
                            : ColorResources.neutral0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
