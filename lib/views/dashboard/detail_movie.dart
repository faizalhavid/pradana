import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/services/movie_api.dart';

class DetailMovieScreen extends ConsumerStatefulWidget {
  final Movie movie;

  const DetailMovieScreen({required this.movie, super.key});

  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends ConsumerState<DetailMovieScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    _animationController = BottomSheet.createAnimationController(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet(MediaQuery.of(context).size);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Movie> movieAsyncValue =
        ref.watch(getMovieDetailProvider(widget.movie.id));
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: movieAsyncValue.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (movie) => Stack(
          children: [
            Container(
              height: size.height,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  ColorResources.neutral900.withOpacity(0.2),
                  BlendMode.darken,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  placeholderFit: BoxFit.cover,
                  placeholderScale: 2,
                  image:
                      'https://image.tmdb.org/t/p/original/${movie.backdrop_path}',
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: size.height * 0.4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(49, 255, 255, 255),
                  ),
                  child: Hero(
                    tag: movie.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        placeholderFit: BoxFit.cover,
                        placeholderScale: 1,
                        image:
                            'https://image.tmdb.org/t/p/original/${movie.poster_path}',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title ?? '',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: ColorResources.neutral0,
                                ),
                      ),
                      Text(
                        movie.overview ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorResources.neutral0,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: ColorResources.neutral0.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rating',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ColorResources.neutral300,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        movie.vote_average.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: ColorResources.neutral0,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Language',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ColorResources.neutral300,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        movie.spoken_languages?.first
                                                .english_name
                                                .toUpperCase() ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: ColorResources.neutral0,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Likes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ColorResources.neutral300,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        movie.vote_count.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: ColorResources.neutral0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: movie.production_companies!.map((company) {
                          return Tooltip(
                            message: company.name,
                            waitDuration: Duration(milliseconds: 500),
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: ColorResources.neutral0.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                                image: company.logo_path != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/original/${company.logo_path}',
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: company.logo_path == null
                                  ? Center(
                                      child: Icon(Icons.image_not_supported))
                                  : null,
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            movie.status == 'Released'
                ? Positioned(
                    right: size.width * 0.2,
                    top: size.height * 0.2,
                    child: Image.asset(
                      'assets/icons/verified.png',
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: size.height * 0.2,
            decoration: const BoxDecoration(
              color: ColorResources.neutral0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Genres',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: ColorResources.neutral900,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showBottomSheet(Size size) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize:
              0.1, // Initial height as a fraction of the screen height (10% of the screen)
          minChildSize: 0.05, // Minimum height (5% of the screen)
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: size.height * 0.2,
              decoration: const BoxDecoration(
                color: ColorResources.neutral0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Genres',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: ColorResources.neutral900,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        );
      },
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
