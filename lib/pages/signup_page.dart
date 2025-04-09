// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordValid = true;
  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: _agreedToTerms,
              onChanged: (val) {
                setState(() => _agreedToTerms = val ?? false);
              },
              title: Row(
                children: [
                  const Text("I agree to the "),
                  GestureDetector(
                    onTap: () => context.push('/terms'),
                    child: const Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (!_isPasswordValid)
              const Text(
                'Passwords do not match!',
                style: TextStyle(color: Colors.red),
              ),
            if (!_agreedToTerms)
              const Text(
                'You must agree to the terms.',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        setState(() => _isPasswordValid = false);
                        return;
                      }
                      if (!_agreedToTerms) return;

                      setState(() {
                        _isPasswordValid = true;
                        _isLoading = true;
                      });

                      try {
                        await authProvider.signUp(
                            emailController.text, passwordController.text);
                        context.go('/verify-email');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      } finally {
                        setState(() => _isLoading = false);
                      }
                    },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
