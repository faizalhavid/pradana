import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/providers/controllers/movie.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 60),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user_profile.jpg'),
              ),
              SizedBox(height: 10),
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
                  color: ColorResources.neutral0,
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
                tabs: [
                  Tab(
                    text: 'Watchlist',
                  ),
                  Tab(
                    text: 'Favorite',
                  ),
                ],
              ),
              Container(
                height:
                    size.height, // Ensure the TabBarView has a defined height
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          mainAxisExtent: size.height *
                              0.4, // Control the height of each item
                          crossAxisSpacing:
                              10.0, // Spacing between items in the cross axis
                          mainAxisSpacing:
                              10.0, // Spacing between items in the main axis
                          childAspectRatio:
                              1.0, // Aspect ratio to control height vs width
                        ),
                        itemBuilder: (context, index) {
                          return InsightMovieCard(
                            movie: watchListMovie[index]!,
                          );
                        },
                        itemCount: watchListMovie?.length ?? 0,
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          mainAxisExtent: size.height *
                              0.4, // Control the height of each item
                          crossAxisSpacing:
                              10.0, // Spacing between items in the cross axis
                          mainAxisSpacing:
                              10.0, // Spacing between items in the main axis
                          childAspectRatio:
                              1.0, // Aspect ratio to control height vs width
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
      ),
    );
  }
}
