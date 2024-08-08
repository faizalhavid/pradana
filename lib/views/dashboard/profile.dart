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
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: 'https://via.placeholder.com/150',
                ).image,
              ),
              SizedBox(height: 10),
              Text(
                'Pradana',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('@pradana'),
              SizedBox(height: 20),
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
                        Text('1000'),
                        Text('Watchlist'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('1000'),
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            if (watchListMovie == null) {
                              return Center(
                                child: Column(
                                  children: [Text('No data')],
                                ),
                              );
                            }
                            return Container(
                              child: InsightMovieCard(
                                movie: watchListMovie[index]!,
                              ),
                            );
                          },
                          itemCount: watchListMovie?.length ??
                              0, // Number of items in the grid
                        )),
                    Container(
                      height: size.height,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (favoriteMovie == null) {
                            return Center(
                              child: Column(
                                children: [Text('No data')],
                              ),
                            );
                          }
                          return Container(
                            child: InsightMovieCard(
                              movie: favoriteMovie[index]!,
                            ),
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
