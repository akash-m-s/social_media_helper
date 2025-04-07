// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_providers.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkUserAuth();
  }

  Future<void> _checkUserAuth() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkAuthStatus();

    if (!mounted) return; // Ensure the widget is still in the widget tree

    if (authProvider.isAuthenticated) {
      // Navigate to the home page after checking auth status
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/home'); // Navigate to Home
      });
    } else {
      // If not authenticated, navigate to login page
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/login'); // Navigate to Login
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
