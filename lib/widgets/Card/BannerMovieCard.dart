import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Genre.dart';
import 'package:pradana/models/data/Movie.dart';
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
    return Container(
      child: Stack(
        children: [
          Container(
            width: size.width * 0.8,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
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
                  print('Movie: ${movie.title}');
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
        ],
      ),
    );
  }
}
