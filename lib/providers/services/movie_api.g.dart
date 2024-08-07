// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMoviesNowPlayingHash() =>
    r'488d8ab57c3c2f8cc14ad9e6e5f923480e2a89ea';

/// See also [getMoviesNowPlaying].
@ProviderFor(getMoviesNowPlaying)
final getMoviesNowPlayingProvider =
    AutoDisposeFutureProvider<List<Movie>>.internal(
  getMoviesNowPlaying,
  name: r'getMoviesNowPlayingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMoviesNowPlayingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMoviesNowPlayingRef = AutoDisposeFutureProviderRef<List<Movie>>;
String _$getMoviesPopularHash() => r'820f6dc4f8dbd9a5c5ebf57ec66db57e2aced6b3';

/// See also [getMoviesPopular].
@ProviderFor(getMoviesPopular)
final getMoviesPopularProvider =
    AutoDisposeFutureProvider<List<Movie>>.internal(
  getMoviesPopular,
  name: r'getMoviesPopularProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMoviesPopularHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMoviesPopularRef = AutoDisposeFutureProviderRef<List<Movie>>;
String _$getGenresHash() => r'415b905144388a5994c77d1fb66c169b07041544';

/// See also [getGenres].
@ProviderFor(getGenres)
final getGenresProvider = AutoDisposeFutureProvider<List<Genre>>.internal(
  getGenres,
  name: r'getGenresProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getGenresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetGenresRef = AutoDisposeFutureProviderRef<List<Genre>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
