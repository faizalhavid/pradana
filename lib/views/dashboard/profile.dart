import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/providers/controllers/movie.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/widgets/Card/InsightMovieCard.dart';

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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final watchListMovie = ref.watch(watchlistMovieProvider);
    final favoriteMovie = ref.watch(favoriteMovieProvider);
    final bool isDarkMode =
        ref.watch(themeControllerProvider).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_profile.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Pradana',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('@pradana'),
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
