import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/providers/services/movie_api.dart';
import 'package:shimmer/shimmer.dart';

/// Kelas `DetailMovieScreen` untuk menampilkan detail film.
///
/// Kelas ini menggunakan `ConsumerStatefulWidget` untuk memungkinkan konsumsi
/// state dari provider.
///
/// Kelas ini memiliki beberapa properti dan metode:
/// - `_dragableScrollableSheetKey` (GlobalKey): Kunci untuk mengakses `DraggableScrollableSheet`.
/// - `_dragableScrollableSheetController` (DraggableScrollableController): Controller untuk mengontrol `DraggableScrollableSheet`.
/// - `sheet` (DraggableScrollableSheet): Getter untuk mengakses `DraggableScrollableSheet`.
/// - `_animateSheet` (void Function(double)): Metode untuk menganimasikan `DraggableScrollableSheet`.
/// - `build` (BuildContext): Metode untuk membangun tampilan layar.
/// - `initState` (): Metode untuk inisialisasi state. yang digunakan untuk mengatur listener pada controller.
/// - `handleWatchlistButton` (): Metode untuk menangani aksi tombol watchlist.
/// - `handleFavoriteButton` (): Metode untuk menangani aksi tombol favorit.
/// - `renderBackdropPath` (Size, Movie): Metode untuk membangun tampilan latar belakang.
/// - `renderOverviewInformation` (Size, Movie, BuildContext): Metode untuk membangun tampilan informasi film.
/// - `renderScrollableBottomSheet` (Movie, void Function(), void Function(), bool, bool): Metode untuk membangun tampilan `DraggableScrollableSheet`.
/// - `renderMoviePoster` (Size, Movie): Metode untuk membangun tampilan poster film.
/// - `renderMovieCompanyProduction` (Movie): Metode untuk membangun tampilan perusahaan produksi film.
/// - `renderMoviesLabelInformation` (BuildContext, Movie): Metode untuk membangun tampilan label informasi film.
/// - `DetailMovieScreen` ({Movie}): Konstruktor untuk `DetailMovieScreen`.
class DetailMovieScreen extends ConsumerStatefulWidget {
  final Movie movie;
  final String tag;

  const DetailMovieScreen({required this.tag, required this.movie, super.key});

  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends ConsumerState<DetailMovieScreen> {
  final _draggableScrollableSheetKey = GlobalKey();
  final _draggableScrollableSheetController = DraggableScrollableController();

  DraggableScrollableSheet get sheet =>
      (_draggableScrollableSheetKey.currentWidget as DraggableScrollableSheet);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    _draggableScrollableSheetController.addListener(() {
      final currentSize = _draggableScrollableSheetController.size;

      if (currentSize <= 0.05) _animateSheet(sheet.snapSizes!.first);
      if (currentSize >= 0.95) _animateSheet(sheet.snapSizes!.last);
    });
  }

  void _animateSheet(double size) {
    _draggableScrollableSheetController.animateTo(
      size,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movie);
    final size = MediaQuery.of(context).size;
    final AsyncValue<Movie> movieAsyncValue =
        ref.watch(getMovieDetailProvider(widget.movie.id));

    final bool isFavorite =
        ref.watch(favoriteMovieProvider).contains(widget.movie);
    final bool isWatchlist =
        ref.watch(watchlistMovieProvider).contains(widget.movie);

    void handleWatchlistButton() {
      if (isWatchlist) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.movie.title} added to watch list movie!'),
        ));
        ref.read(watchlistMovieProvider.notifier).removeMovie(widget.movie);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.movie.title} added to watch list movie!'),
        ));
        ref.read(watchlistMovieProvider.notifier).addMovie(widget.movie);
      }
    }

    void handleFavoriteButton() {
      if (isFavorite) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.movie.title} removed from favorite movie!'),
        ));
        ref.read(favoriteMovieProvider.notifier).removeMovie(widget.movie);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.movie.title} added to favorite movie!'),
        ));
        ref.read(favoriteMovieProvider.notifier).addMovie(widget.movie);
      }
    }

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
          actions: [
            IconButton(
                icon: const Icon(Icons.download, color: Colors.white),
                onPressed: () async {
                  final filePathAsyncValue = ref.read(
                      downloadMoviePosterProvider(widget.movie.poster_path));
                  filePathAsyncValue.when(
                    loading: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Downloading...'))),
                    error: (err, stack) => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error: $err'))),
                    data: (filePath) => ScaffoldMessenger.of(context)
                        .showSnackBar(
                            SnackBar(content: Text('Downloaded to $filePath'))),
                  );
                })
          ]),
      body: movieAsyncValue.when(
        loading: () => renderLoadingState(size),
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
        data: (movie) => Stack(
          children: [
            renderBackdropPath(size, movie),
            renderOverviewInformation(size, movie, context),
            movie.status == 'Released'
                ? Positioned(
                    right: size.width * 0.2,
                    top: size.height * 0.2,
                    child: Image.asset(
                      'assets/icons/verified.png',
                    ),
                  )
                : SizedBox.shrink(),
            renderScrollableBottomSheet(movie, handleWatchlistButton,
                handleFavoriteButton, isWatchlist, isFavorite),
          ],
        ),
      ),
    );
  }

  Stack renderLoadingState(Size size) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: size.height * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(49, 255, 255, 255),
                ),
                child: Hero(
                  tag: widget.movie.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Shimmer.fromColors(
                      child: Image.asset(
                        'assets/images/placeholder.png',
                      ),
                      baseColor: ColorResources.neutral200,
                      highlightColor: ColorResources.neutral100,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: ColorResources.neutral200,
                      highlightColor: ColorResources.neutral100,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: ColorResources.gray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: size.width * 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: ColorResources.neutral200,
                      highlightColor: ColorResources.neutral100,
                      child: Container(
                        height: 15,
                        decoration: BoxDecoration(
                          color: ColorResources.gray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: size.width * 0.8,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: ColorResources.neutral200,
                      highlightColor: ColorResources.neutral100,
                      child: Container(
                        height: 15,
                        decoration: BoxDecoration(
                          color: ColorResources.gray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: size.width * 0.8,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: ColorResources.neutral200,
                      highlightColor: ColorResources.neutral100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorResources.gray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 65,
                        width: size.width * 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column renderOverviewInformation(
      Size size, Movie movie, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        renderMoviePoster(size, movie),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title ?? '',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: ColorResources.neutral0,
                    ),
              ),
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: size.width * 0.5,
                    ),
                    child: Text(
                      movie.tagline?.toUpperCase() ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorResources.neutral50,
                            fontWeight: FontWeight.w100,
                            overflow: TextOverflow.ellipsis,
                          ),
                      maxLines: 4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.circle,
                      color: ColorResources.neutral50,
                      size: 10,
                    ),
                  ),
                  Text(
                    movie.adult! ? '18+' : '13+',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorResources.neutral50,
                          fontWeight: FontWeight.w100,
                        ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.circle,
                      color: ColorResources.neutral50,
                      size: 10,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: ColorResources.neutral50,
                        size: 20,
                      ),
                      Text(
                        movie.vote_average!.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorResources.neutral50,
                              fontWeight: FontWeight.w100,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              renderMoviesLabelInformation(context, movie),
              const SizedBox(
                height: 20,
              ),
              renderMovieCompanyProduction(movie)
            ],
          ),
        ),
      ],
    );
  }

  Container renderBackdropPath(Size size, Movie movie) {
    return Container(
      height: size.height,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            ColorResources.neutral900.withOpacity(0.4),
            BlendMode.darken,
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              ColorResources.neutral900.withOpacity(0.8),
              BlendMode.saturation,
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
      ),
    );
  }

  Positioned renderScrollableBottomSheet(
    Movie movie,
    void Function() onTapwatchlistButton,
    void Function() onTapFavoriteButton,
    bool isWatchlist,
    bool isFavorite,
  ) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return DraggableScrollableSheet(
            key: _draggableScrollableSheetKey,
            controller: _draggableScrollableSheetController,
            initialChildSize: 0.08,
            maxChildSize: 0.9,
            minChildSize: 0,
            expand: true,
            snap: true,
            snapSizes: [
              70 / constraints.maxHeight,
              0.35,
              0.9,
            ],
            builder: (BuildContext context, ScrollController scrollController) {
              return DecoratedBox(
                decoration: const BoxDecoration(
                  color: ColorResources.neutral0,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                              child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: ColorResources.neutral300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ))),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Text('Overview',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: ColorResources.neutral900,
                                    )),
                            Text(movie.overview ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorResources.neutral900,
                                    )),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('Genres',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: ColorResources.neutral900,
                                      )),
                            ),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: movie.genres!.map((genre) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: ColorResources.neutral200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    genre.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: ColorResources.neutral900,
                                        ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('Production Countries',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: ColorResources.neutral900,
                                      )),
                            ),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children:
                                  movie.production_countries!.map((country) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: ColorResources.neutral200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    country.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: ColorResources.neutral900,
                                        ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('Albums',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: ColorResources.neutral900,
                                      )),
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/placeholder.png',
                                      image:
                                          'https://image.tmdb.org/t/p/original/${movie.belongs_to_collection?.poster_path}',
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/placeholder.png',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  movie.belongs_to_collection?.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: ColorResources.neutral900,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('Languages',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: ColorResources.neutral900,
                                      )),
                            ),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: movie.spoken_languages!.map((language) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: ColorResources.neutral200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    language.english_name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: ColorResources.neutral900,
                                        ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                onTapFavoriteButton();
                              },
                              child: Text(
                                  '${isFavorite ? 'Remove from' : 'Add to'} Favorite'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorResources.neutral300,
                                foregroundColor: ColorResources.neutral900,
                              ),
                              onPressed: () {
                                onTapwatchlistButton();
                              },
                              child: Text(
                                  '${isWatchlist ? 'Remove from' : 'Add to'} Watchlist'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Container renderMoviePoster(Size size, Movie movie) {
    return Container(
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
            image: 'https://image.tmdb.org/t/p/original/${movie.poster_path}',
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
    );
  }

  Wrap renderMovieCompanyProduction(Movie movie) {
    return Wrap(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                ? Center(child: Icon(Icons.image_not_supported))
                : null,
          ),
        );
      }).toList(),
    );
  }

  ClipRRect renderMoviesLabelInformation(BuildContext context, Movie movie) {
    return ClipRRect(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Length',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorResources.neutral300,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${movie.runtime! ~/ 60} H ${movie.runtime! % 60} M',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorResources.neutral0,
                          ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Language',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorResources.neutral300,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movie.spoken_languages?.first.english_name
                              .toUpperCase() ??
                          '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorResources.neutral0,
                          ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Likes',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorResources.neutral300,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      movie.vote_count.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
    );
  }
}
