import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/views/auth/login.dart';
import 'package:pradana/views/auth/welcome.dart';
import 'package:pradana/views/dashboard/dashboard.dart';
import 'package:pradana/views/dashboard/detail_movie.dart';
import 'package:pradana/views/dashboard/favorite.dart';
import 'package:pradana/views/dashboard/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pradana/views/dashboard/watchlist.dart';

/// Entry point aplikasi.
///
/// Fungsi ini memastikan bahwa kerangka Flutter diinisialisasi dengan benar.
/// Memuat variabel lingkungan dari file `.env` dan kemudian menjalankan aplikasi
/// menggunakan `ProviderScope` dan widget `MyApp`.
///
/// Langkah-langkah:
/// 1. Memastikan inisialisasi kerangka Flutter menggunakan `WidgetsFlutterBinding.ensureInitialized`.
/// 2. Memuat variabel lingkungan dari file `.env` menggunakan `dotenv.load`.
/// 3. Menjalankan aplikasi dengan `runApp` dan membungkusnya dalam `ProviderScope` untuk
///    mengaktifkan state management berbasis provider.
void main() async {
  // Memastikan bahwa kerangka Flutter diinisialisasi dengan benar.
  WidgetsFlutterBinding.ensureInitialized();

  // Memuat variabel lingkungan dari file `.env`.
  await dotenv.load(fileName: ".env");

  // Menjalankan aplikasi menggunakan `ProviderScope` dan widget `MyApp`.
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Kelas MyApp yang merupakan widget utama aplikasi.
///
/// Kelas ini menggunakan `ConsumerWidget` dari paket Riverpod untuk mengelola
/// state dan tema aplikasi. Widget ini membangun aplikasi dengan menggunakan
/// `MaterialApp` dan mendefinisikan rute-rute yang tersedia dalam aplikasi.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mengambil tema aplikasi dari provider.
    final theme = ref.watch(themeControllerProvider);
    // Mengambil rute awal dari provider.
    final initialRouteAsync = ref.watch(initialRouteProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      onGenerateRoute: (settings) {
        // Mendefinisikan rute-rute yang tersedia dalam aplikasi.
        final routes = {
          '/auth/welcome': (context) => Welcomescreen(),
          '/auth/login': (context) => LoginScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/dashboard/home': (context) => HomeScreen(),
          '/dashboard/watchlist': (context) => WatchlistScreen(),
          '/dashboard/favorite': (context) => FavoriteScreen(),
        };
        // Menangani rute khusus untuk rute yang memerlukan argumen.
        if (settings.name == '/dashboard/detail-movie') {
          final Movie movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (context) => DetailMovieScreen(movie: movie),
          );
        }

        // Mengembalikan rute yang sesuai atau rute default.
        final builder = routes[settings.name] ?? (context) => Welcomescreen();
        return MaterialPageRoute(builder: builder);
      },
      // Menentukan widget awal berdasarkan hasil dari `initialRouteAsync`.
      home: initialRouteAsync.when(
        data: (route) {
          switch (route) {
            case '/auth/welcome':
              return Welcomescreen();
            case '/auth/login':
              return LoginScreen();
            case '/dashboard':
              return DashboardScreen();
            case '/dashboard/home':
              return HomeScreen();
            default:
              return Welcomescreen();
          }
        },
        loading: () =>
            Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) =>
            Scaffold(body: Center(child: Text('Error: $error'))),
      ),
    );
  }
}
