import 'package:flutter/material.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/widgets/Card/BannerMovieCard.dart';

/// Kelas `CustomSearchDelegate` untuk menangani pencarian film.
///
/// Kelas ini menggunakan `SearchDelegate` untuk menyediakan antarmuka pencarian
/// yang dapat disesuaikan.
///
/// Kelas ini memiliki beberapa properti dan metode:
/// - `data` (List<Movie>): Daftar film yang akan dicari.
///
/// Metode `buildActions` membangun daftar aksi di AppBar pencarian, seperti tombol untuk menghapus query.
/// Metode `buildLeading` membangun ikon di sebelah kiri AppBar pencarian, seperti tombol kembali.
/// Metode `buildResults` membangun tampilan hasil pencarian berdasarkan query yang dimasukkan.
/// Metode `appBarTheme` mengatur tema AppBar pencarian.
/// Metode `buildSuggestions` membangun daftar saran berdasarkan query yang dimasukkan.
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
