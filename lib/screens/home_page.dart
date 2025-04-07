import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_helper/services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final User? user = AuthService().currentUser;
  Future<void> signOut() async {
    await AuthService().signOut();
  }

  Widget _title() {
    return const Text('Home Page');
  }

  Widget _userId() {
    return Text(user!.email ?? '');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text(
        'Sign out',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _userId(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
