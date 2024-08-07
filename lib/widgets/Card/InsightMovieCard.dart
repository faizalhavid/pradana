import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';

class InsightMovieCard extends StatelessWidget {
  final Movie movies;
  final VoidCallback _onTap;

  InsightMovieCard({required this.movies, required VoidCallback onTap})
      : _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${movies.title}-${movies.id}',
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 206,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 260,
                width: 206,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  placeholderFit: BoxFit.cover,
                  placeholderScale: 2,
                  image:
                      'https://image.tmdb.org/t/p/original/${movies.poster_path}',
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 260,
                  width: 206,
                  child: Material(
                    color: Colors
                        .transparent, // Make the material background transparent
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _onTap,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 35,
                              width: 65,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: ColorResources.neutral0,
                                          size: 20,
                                        ),
                                        Text(
                                          movies.vote_average
                                                  ?.toStringAsFixed(1) ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: ColorResources.neutral0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      size: 20,
                                      Icons.favorite_border,
                                      color: ColorResources.neutral0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movies.title ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Release Date: ${movies.release_date ?? ''}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorResources.neutral400,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
