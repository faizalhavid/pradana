import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/models/data/User.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/providers/services/auth_api.dart';
import 'package:pradana/providers/services/user_api.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/widgets/Card/InsightMovieCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Kelas `ProfileScreen` untuk menampilkan profil pengguna dan daftar film.
///
/// Kelas ini menggunakan `ConsumerStatefulWidget` untuk memungkinkan konsumsi
/// state dari provider.
///
/// Kelas ini memiliki beberapa properti dan metode:
/// - `_tabController` (TabController): Pengontrol tab untuk mengelola perpindahan antar tab.
/// - `initState` (void): Metode untuk inisialisasi state.
/// - `dispose` (void): Metode untuk membersihkan state.
/// - `build` (Widget): Metode untuk membangun tampilan layar.
/// - `size` (Size): Ukuran layar.
/// - `watchListMovie` (List<Movie>): Daftar film watchlist.
/// - `favoriteMovie` (List<Movie>): Daftar film favorit.
/// - `isDarkMode` (bool): Status tema gelap.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loadMoviesBasedOnAuth(ref);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void loadMoviesBasedOnAuth(WidgetRef ref) async {
    final sessionId = ref.read(sessionIdProvider);

    if (sessionId != null) {
      final movies = await ref.read(getFavoriteMoviesProvider.future);
      ref.read(favoriteMovieProvider.notifier).state = movies;
    } else {
      ref.read(favoriteMovieProvider.notifier).clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchListMovie = ref.watch<List<Movie>>(watchlistMovieProvider);
    final favoriteMovie = ref.watch(favoriteMovieProvider);
    final size = MediaQuery.of(context).size;
    final AsyncValue<User> userAccountDetail =
        ref.watch(getAccountDetailsProvider);
    final bool isDarkMode =
        ref.watch(themeControllerProvider).brightness == Brightness.dark;
    // final AsyncValue<List<Movie>> watchListMovie =
    //     ref.watch(getWatchlistMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.remove('session_id');
              prefs.remove('guest_session_id');
              prefs.remove('request_token');
              ref.read(sessionIdProvider.notifier).state = '';
              ref.read(guestSessionProvider.notifier).state = '';
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/auth/welcome',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userAccountDetail.when(
              data: (user) => Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.avatar?.gravatar?.hash != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image:
                                'https://www.gravatar.com/avatar/${user.avatar!.gravatar!.hash ?? user.avatar!.tmdb?.avatarPath}?s=200',
                            fit: BoxFit.cover,
                          ).image
                        : AssetImage('assets/images/user_profile.jpg'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.name!.isEmpty
                        ? user.username!.isEmpty
                            ? 'Guest'
                            : '@${user.username}'
                        : user.name!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? ColorResources.neutral700
                    : ColorResources.neutral0,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(watchListMovie.length.toString()),
                      Text('Watchlist'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(favoriteMovie.length.toString()),
                      Text('Favorite'),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Watchlist',
                ),
                Tab(
                  text: 'Favorite',
                ),
              ],
            ),
            SizedBox(height: 10),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: size.height * 0.4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (context, index) {
                        return InsightMovieCard(
                          movie: watchListMovie[index],
                        );
                      },
                      itemCount: watchListMovie.length,
                    ),
                  ),
                  SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: size.height * 0.4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (context, index) {
                        return InsightMovieCard(
                          movie: favoriteMovie[index],
                        );
                      },
                      itemCount: favoriteMovie.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
