// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool _resend = false;

  bool _isLoading = false;

  void _sendVerificationEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Verification email sent. Please check your inbox')),
      );
      setState(() {
        _resend = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = Provider.of<AuthProvider>(context).user?.email ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('You are signed in with:',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(userEmail,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendVerificationEmail,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(_resend
                      ? 'Resend Verification Email'
                      : 'Send Verification Email'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
