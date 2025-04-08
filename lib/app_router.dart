import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_helper/pages/reset_passwords.dart';
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
            return const HomePage();
          },
        ),

        GoRoute(
          path: '/verify-email',
          builder: (context, state) {
            return const VerifyEmailPage();
          },
        ),
      ],
    );
  }
}
