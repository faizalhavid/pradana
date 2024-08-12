import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/data/Movie.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:pradana/providers/services/auth_api.dart';
import 'package:pradana/providers/theme.dart';
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
/// Kelas ini memiliki beberapa properti dan metode:
/// - `build` (Widget): Metode untuk membangun tampilan aplikasi.
/// - `_navigatorKey` (GlobalKey<NavigatorState>): Kunci navigator untuk mengelola navigasi.
/// - `_appLinks` (AppLinks): Instance dari kelas `AppLinks` untuk menangani deep links.
/// - `initialRouteAsync` (AsyncValue<String>): Nilai async untuk menentukan rute awal.
/// - `openAppLink` (void): Metode untuk membuka deep link.
/// - `initDeepLinks` (Future<void>): Metode untuk inisialisasi deep links.
/// - `initState` (void): Metode untuk inisialisasi state.
/// - `dispose` (void): Metode untuk membersihkan state.
/// - `handleDeepLink` (void): Metode untuk menangani deep link.
/// - `build` (Widget): Metode untuk membangun tampilan aplikasi.

class MyApp extends ConsumerStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class _MyAppState extends ConsumerState<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  void handleDeepLink(Uri uri) async {
    // Memeriksa host dari URI deep link.
    if (uri.host == 'open.pradana') {
      final requestToken = uri.queryParameters['request_token'];
      final approved = uri.queryParameters['approved'];
      // Memeriksa apakah request token dan approval status valid.
      if (requestToken != null && approved == 'true') {
        try {
          // Memanggil metode `createSessionId` dari `AuthApi` untuk membuat session ID.
          final sessionId = await ref.read(createSessionIdProvider.future);
          ref.read(sessionIdProvider.notifier).state = sessionId;
          // Menavigasi ke halaman dashboard.
          _navigatorKey.currentState?.pushReplacementNamed('/dashboard');
          ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
            SnackBar(content: Text('You are now logged in')),
          );
        } catch (e) {
          // Menampilkan pesan kesalahan jika gagal membuat session ID.
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
                content: Text('Something went wrong, you can use as Guest')),
          );
        } finally {
          // Menghentikan loading.
          ref.read(loadingAuthSessionProvider.notifier).state = false;
        }
      } else {
        // Menampilkan pesan kesalahan jika request token atau approval status tidak valid.
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Invalid request token or approval status')),
        );
      }
    }
  }

  void initDeepLinks() {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen(handleDeepLink);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);
    final initialRouteAsync = ref.watch(initialRouteProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      navigatorKey: _navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      onGenerateRoute: (settings) {
        // Mendefinisikan rute-rute yang tersedia dalam aplikasi.
        final routes = {
          '/auth/welcome': (context) => Welcomescreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/dashboard/home': (context) => HomeScreen(),
          '/dashboard/watchlist': (context) => WatchlistScreen(),
          '/dashboard/favorite': (context) => FavoriteScreen(),
        };
        // Menangani rute khusus untuk rute yang memerlukan argumen.
        if (settings.name == '/dashboard/detail-movie') {
          final args = settings.arguments as Map<String, dynamic>;

          final Movie movie = args['movie'];
          final String tag = args['tag'];

          return MaterialPageRoute(
            builder: (context) => DetailMovieScreen(movie: movie, tag: tag),
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
              case '/dashboard':
                return DashboardScreen();
              default:
                return Welcomescreen();
            }
          },
          loading: () =>
              Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (error, stack) {
            print('Error: $error');
            return Scaffold(body: Center(child: Text('Something went wrong')));
          }),
    );
  }
}
