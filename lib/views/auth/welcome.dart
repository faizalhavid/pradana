import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pradana/models/colors.dart';
import 'package:pradana/providers/controllers/auth.dart';
import 'package:pradana/providers/services/auth_api.dart';

class Welcomescreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bool loading = ref.watch(loadingProvider);
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
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Color.fromARGB(202, 255, 255, 255),
                        Color.fromARGB(0, 255, 255, 255)
                      ],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      stops: [0.0, 0.8, 1.0],
                    ),
                  ),
                ),
              ],
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
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    loading
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
                const Image(
                  image: AssetImage('assets/images/logo.png'),
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
                      Navigator.pushNamed(context, '/auth/login');
                    },
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorResources.neutral0,
                          ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: ColorResources.neutral100,
                      foregroundColor: ColorResources.secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorResources.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
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
      ref.read(loadingProvider.notifier).state = true;

      // Step 1: Create request token
      final requestToken = await ref.read(createRequestTokenProvider.future);

      if (requestToken != null) {
        ref.read(requesttokenProvider.notifier).state = requestToken;

        // Step 2: Create session ID
        final sessionId = await ref.read(createSessionIdProvider.future);

        if (sessionId != null) {
          ref.read(sessionIdProvider.notifier).state = sessionId;

          // Step 3: Create session
          final session = await ref.read(createSessionProvider.future);

          if (session != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Session created until ${requestToken.expires_at}')),
            );
            Navigator.pushReplacementNamed(context, '/dashboard');
            ref.read(loadingProvider.notifier).state = false;
          } else {
            ref.read(loadingProvider.notifier).state = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create session')),
            );
          }
        } else {
          ref.read(loadingProvider.notifier).state = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create session ID')),
          );
        }
      } else {
        ref.read(loadingProvider.notifier).state = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create request token')),
        );
      }
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
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
      ref.read(loadingProvider.notifier).state = true;
      final requestToken = await ref.read(createRequestTokenProvider.future);

      if (requestToken != null) {
        final guestSession = await ref.read(createGuestSessionProvider.future);

        if (guestSession != null) {
          ref.read(guestSessionProvider.notifier).state = guestSession;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Guest session created')),
          );
          Navigator.pushReplacementNamed(context, '/dashboard');
          ref.read(loadingProvider.notifier).state = false;
        }
      } else {
        ref.read(loadingProvider.notifier).state = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create guest session')),
        );
      }
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
