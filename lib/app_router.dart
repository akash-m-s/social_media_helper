import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_helper/pages/caption_generator_screen.dart';
import 'package:social_media_helper/pages/reset_passwords.dart';
import 'package:social_media_helper/pages/terms_page.dart';
import 'pages/chat_simulation_page.dart';
import 'pages/hastag_suggeations_screen.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/splash_screen.dart';
import 'pages/verify_email_page.dart';

class AppRouter {
  static GoRouter getRouter(BuildContext context) {
    return GoRouter(
      initialLocation: '/splash', // Start with splash page
      routes: [
        // Splash screen
        GoRoute(
          path: '/splash',
          builder: (context, state) {
            return const SplashPage();
          },
        ),

        // Login screen
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return const LoginPage();
          },
        ),

        GoRoute(
            path: '/reset-password',
            builder: (context, state) {
              return const ResetPasswordPage();
            }),

        // Sign up screen
        GoRoute(
          path: '/signup',
          builder: (context, state) {
            return const SignupPage();
          },
        ),

        // Home screen
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomeScreen();
          },
        ),

        GoRoute(
          path: '/verify-email',
          builder: (context, state) {
            return const VerifyEmailPage();
          },
        ),
        // Chat simulation screen
        GoRoute(
          path: '/chat',
          builder: (context, state) {
            return const ChatSimulationPage();
          },
        ),
        GoRoute(
          path: '/terms',
          builder: (context, state) {
            return const TermsPage();
          },
        ),

        GoRoute(
          path: '/caption-generator',
          builder: (context, state) => const CaptionGeneratorScreen(),
        ),
        GoRoute(
          path: '/hashtag-helper',
          builder: (context, state) => const HashtagSuggestionScreen(),
        ),
      ],
    );
  }
}
