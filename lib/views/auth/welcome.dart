import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:pradana/providers/services/auth_api.dart';
import 'package:pradana/providers/theme.dart';
import 'package:url_launcher/url_launcher.dart';

/// Kelas `Welcomescreen` untuk merepresentasikan layar selamat datang aplikasi.
///
/// Kelas ini menggunakan `ConsumerWidget` untuk memungkinkan konsumsi state dari provider.
///
/// Kelas ini memiliki beberapa properti dan metode:
/// - `size` (Size): Ukuran layar perangkat.
/// - `loading` (bool): Menunjukkan apakah sedang dalam proses loading.
/// - `isDarkMode` (bool): Menunjukkan apakah mode gelap sedang aktif.
/// - `gradientColors` (List<Color>): Daftar warna untuk gradient background.
/// - `isDark` (bool): Menunjukkan apakah mode gelap sedang aktif.
/// Kelas ini juga menyediakan metode `handleTMDBAuthentification` dan `handleTMDBGuest`
/// untuk menangani autentikasi dengan TMDB.

class Welcomescreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bool loadingAuth = ref.watch(loadingAuthSessionProvider);
    final bool loadingGuest = ref.watch(loadingGuestSessionProvider);

    final bool isDarkMode =
        ref.watch(themeControllerProvider).brightness == Brightness.dark;
    final List<Color> gradientColors = isDarkMode
        ? [
            ColorResources.neutral900,
            const Color.fromARGB(181, 33, 33, 33),
            Color.fromARGB(0, 0, 0, 0)
          ]
        : [
            Colors.white,
            Color.fromARGB(202, 255, 255, 255),
            Color.fromARGB(0, 255, 255, 255)
          ];
    final isDark =
        ref.watch(themeControllerProvider).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  child: Image.asset(
                    height: size.height * 0.5,
                    'assets/images/welcome_bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      stops: const [0.0, 0.8, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: -10,
            child: SizedBox(
              width: 130,
              child: IconButton(
                onPressed: () {
                  ref.read(themeControllerProvider.notifier).toggleTheme();
                },
                icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark
                      ? ColorResources.neutral0
                      : ColorResources.neutral900,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: SizedBox(
              width: 130,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.neutral0,
                  foregroundColor: ColorResources.primaryColor,
                ),
                onPressed: () {
                  handleTMDBGuest(ref: ref, context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'AS Guest',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorResources.primaryColor,
                          ),
                    ),
                    loadingGuest
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: ColorResources.primaryColor,
                            ),
                          )
                        : const SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(
                              Icons.arrow_forward,
                              color: ColorResources.primaryColor,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(
                  width: 200,
                  image: AssetImage(
                      'assets/images/${isDark ? 'logo_dark' : 'logo'}.png'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    textAlign: TextAlign.center,
                    'By Creating an account you access to an unlimited number of exercises',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorResources.neutral400,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      handleTMDBAuthentification(ref: ref, context: context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign in',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorResources.neutral0,
                                  ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        loadingAuth
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  color: ColorResources.neutral0,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 10),
                //   width: size.width,
                //   height: 50,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       shadowColor: Colors.transparent,
                //       backgroundColor: ColorResources.neutral100,
                //       foregroundColor: ColorResources.secondaryColor,
                //     ),
                //     onPressed: () {
                //       Navigator.pushNamed(context, '/register');
                //     },
                //     child: Text(
                //       'Sign up',
                //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //             color: ColorResources.secondaryColor,
                //             fontWeight: FontWeight.bold,
                //           ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleTMDBAuthentification({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      ref.read(loadingAuthSessionProvider.notifier).state = true;

      final requestToken = await ref.read(createRequestTokenProvider.future);
      if (requestToken != null && requestToken.request_token != null) {
        ref.read(requesttokenProvider.notifier).state = requestToken;

        final Uri authUrl = Uri.parse(
            'https://www.themoviedb.org/authenticate/${requestToken.request_token}?redirect_to=redirect://open.pradana');
        if (await canLaunchUrl(authUrl)) {
          await launchUrl(authUrl, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('Could not launch $authUrl');
        }
      } else {
        throw Exception('Failed to create request token, you can use as Guest');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void handleTMDBGuest({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      final guestSession = await ref.read(createGuestSessionProvider.future);

      if (guestSession != null) {
        ref.read(guestSessionProvider.notifier).state = guestSession;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Guest session created')),
        );
        Navigator.pushReplacementNamed(context, '/dashboard');
        ref.read(loadingGuestSessionProvider.notifier).state = false;
      } else {
        ref.read(loadingGuestSessionProvider.notifier).state = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create guest session')),
        );
      }
    } catch (e) {
      ref.read(loadingGuestSessionProvider.notifier).state = false;
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
