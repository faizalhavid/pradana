import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/providers/theme.dart';
import 'package:pradana/views/auth/login.dart';
import 'package:pradana/views/auth/welcome.dart';
import 'package:pradana/views/dashboard/dashboard.dart';
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
    final ThemeData theme = ref.watch(themeControllerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/auth/welcome',
      routes: {
        '/auth/welcome': (context) => Welcomescreen(),
        '/auth/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/dashboard/home': (context) => HomeScreen(),
      },
    );
  }
}
