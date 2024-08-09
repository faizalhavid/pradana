import 'package:flutter/material.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/widgets/Card/BannerMovieCard.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Movie> data;

  CustomSearchDelegate(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = data
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return BannerMovieCard(
            size: MediaQuery.of(context).size, movie: results[index]);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final suggestions = data
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(color: ColorResources.grayLight),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return Container(
              height: 200,
              child: BannerMovieCard(size: size, movie: suggestions[index]));
        },
      ),
    );
  }
}
