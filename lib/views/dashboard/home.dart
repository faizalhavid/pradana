import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/services/movie_api.dart';
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
    // Re-fetch the data by invalidating the providers
    ref.invalidate(getMoviesNowPlayingProvider);
    ref.invalidate(getMoviesPopularProvider);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Movie>> movieNowPlayingAsyncValue =
        ref.watch(getMoviesNowPlayingProvider);
    final AsyncValue<List<Movie>> moviePopularAsyncValue =
        ref.watch(getMoviesPopularProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
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
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
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
                height: 340,
                width: double.infinity,
                child: movieNowPlayingAsyncValue.when(
                  data: (movie) => ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InsightMovieCard(
                        movie: movie[index],
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
                height: size.height * 0.2225,
                width: double.infinity,
                child: moviePopularAsyncValue.when(
                  data: (movie) => ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return BannerMovieCard(
                        movie: movie[index],
                        size: size,
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
            ],
          ),
        ),
      ),
    );
  }
}
