import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_helper/services/auth_service.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  String? errorMessage = '';
  bool doesUserAlreadyExisit = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthService().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _pwdController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _pwdController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _enterTextField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text('hummmm... $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: doesUserAlreadyExisit
          ? signInWithEmailAndPassword
          : createUserWithEmailAndPassword,
      child: Text(
        doesUserAlreadyExisit ? 'Login' : 'Register',
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          doesUserAlreadyExisit = !doesUserAlreadyExisit;
        });
      },
      child: Text(doesUserAlreadyExisit ? 'Login instead' : 'Register instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _enterTextField('email', _emailController),
            _enterTextField('password', _pwdController),
            errorMessage != '' ? _errorMessage() : const SizedBox.shrink(),
            _submitButton(),
            _loginOrRegisterButton()
          ],
        ),
      ),
    );
  }
}
