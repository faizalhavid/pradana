import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/views/auth/login.dart';
import 'package:pradana/views/auth/welcome.dart';
import 'package:pradana/views/dashboard/dashboard.dart';
import 'package:pradana/views/dashboard/detail_movie.dart';
import 'package:pradana/views/dashboard/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
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
        };

        // Handle /dashboard/detail-movie route with arguments
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
        data: (route) => Navigator(
          initialRoute: route,
          onGenerateRoute: (settings) {
            final routes = {
              '/auth/welcome': (context) => Welcomescreen(),
              '/auth/login': (context) => LoginScreen(),
              '/dashboard': (context) => DashboardScreen(),
              '/dashboard/home': (context) => HomeScreen(),
            };

            if (settings.name == '/dashboard/detail-movie') {
              final Movie movie = settings.arguments as Movie;
              return MaterialPageRoute(
                builder: (context) => DetailMovieScreen(movie: movie),
              );
            }

            final builder =
                routes[settings.name] ?? (context) => Welcomescreen();
            return MaterialPageRoute(builder: builder);
          },
        ),
        loading: () =>
            Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) =>
            Scaffold(body: Center(child: Text('Error: $error'))),
      ),
    );
  }
}
