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

/// The entry point of the application.
///
/// This function ensures that the Flutter framework is properly initialized,
/// loads environment variables from a `.env` file, and then runs the application
/// using the `ProviderScope` and `MyApp` widgets.
void main() async {
  // Ensures that the Flutter framework is properly initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Loads environment variables from the .env file.
  await dotenv.load(fileName: ".env");

  // Runs the application with ProviderScope and MyApp widgets.
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);
    final initialRouteAsync = ref.watch(initialRouteProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      onGenerateRoute: (settings) {
        final routes = {
          '/auth/welcome': (context) => Welcomescreen(),
          '/auth/login': (context) => LoginScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/dashboard/home': (context) => HomeScreen(),
          '/dashboard/watchlist': (context) => WatchlistScreen(),
          '/dashboard/favorite': (context) => FavoriteScreen(),
        };
        if (settings.name == '/dashboard/detail-movie') {
          final Movie movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (context) => DetailMovieScreen(movie: movie),
          );
        }

        final builder = routes[settings.name] ?? (context) => Welcomescreen();
        return MaterialPageRoute(builder: builder);
      },
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
