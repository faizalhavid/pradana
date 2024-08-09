import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Actor.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/services/actor_api.dart';
import 'package:pradana/providers/services/movie_api.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/widgets/Card/BannerMovieCard.dart';
import 'package:pradana/widgets/Card/InsightMovieCard.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _refreshData() async {
    ref.invalidate(getMoviesNowPlayingProvider);
    ref.invalidate(getMoviesPopularProvider);
    ref.invalidate(getPopularActorsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Movie>> movieNowPlayingAsyncValue =
        ref.watch(getMoviesNowPlayingProvider);
    final AsyncValue<List<Movie>> moviePopularAsyncValue =
        ref.watch(getMoviesPopularProvider);
    final AsyncValue<List<Actor>> popularActorAsyncValue =
        ref.watch(getPopularActorsProvider);
    final size = MediaQuery.of(context).size;
    final theme = ref.watch(themeControllerProvider);

    void handleChangeTheme() {
      ref.read(themeControllerProvider.notifier).toggleTheme();
    }

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        Navigator.pop(context, result);
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            children: [
              const Icon(Icons.movie, color: ColorResources.neutral300),
              Text(
                'Movies',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: ColorResources.neutral300,
                    ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => handleChangeTheme(),
              icon: Icon(
                theme == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Movies Now Playing 🎥',
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          weight: 500,
                        )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  height: size.height * 0.425,
                  width: double.infinity,
                  child: movieNowPlayingAsyncValue.when(
                    data: (movie) => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.4,
                          ),
                          child: InsightMovieCard(
                            movie: movie[index],
                          ),
                        );
                      },
                      itemCount: movie.length,
                    ),
                    loading: () => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 340,
                          child: Shimmer.fromColors(
                            baseColor: ColorResources.neutral300,
                            highlightColor: ColorResources.neutral200,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorResources.neutral200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                    error: (err, stack) {
                      print(err);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.sync_problem,
                            color: ColorResources.gray,
                            size: 40,
                          ),
                          Text(
                            'Failed to get data',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: ColorResources.gray),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  'Trending Now 📈',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.start,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  height: size.height * 0.25,
                  width: double.infinity,
                  child: moviePopularAsyncValue.when(
                    data: (movie) => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          constraints:
                              BoxConstraints(maxWidth: size.width * 0.8),
                          child: BannerMovieCard(
                            movie: movie[index],
                            size: size,
                          ),
                        );
                      },
                      itemCount: movie.length,
                    ),
                    loading: () => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: size.width * 0.7,
                          child: Shimmer.fromColors(
                            baseColor: ColorResources.neutral200,
                            highlightColor: ColorResources.neutral100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorResources.neutral200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                    error: (err, stack) {
                      print(err);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.sync_problem,
                            color: ColorResources.gray,
                            size: 40,
                          ),
                          Text(
                            'Failed to get data',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: ColorResources.gray),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  'Popular Actors 🎭',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.start,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  height: size.height * 0.15,
                  width: double.infinity,
                  child: popularActorAsyncValue.when(
                    data: (actors) => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: size.width * 0.3,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        actors[index].profile_path!),
                              ),
                              Text(
                                actors[index].name ?? '',
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: actors.length,
                    ),
                    loading: () => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Shimmer.fromColors(
                              baseColor: ColorResources.neutral200,
                              highlightColor: ColorResources.neutral100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorResources.neutral200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                    error: (err, stack) {
                      print(err);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.sync_problem,
                            color: ColorResources.gray,
                            size: 40,
                          ),
                          Text(
                            'Failed to get data',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: ColorResources.gray),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
