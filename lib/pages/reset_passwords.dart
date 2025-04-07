// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_providers.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Enter your email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isProcessing ? null : _resetPassword,
              child: _isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Send Password Reset Email'),
            ),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text(
                'Back to Login',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    setState(() {
      _isProcessing = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.resetPassword(emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Password reset email sent. Please check your inbox.')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }
}
