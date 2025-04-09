import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Last updated: April 9, 2025',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 24),
              Text(
                '1. Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This app allows you to type in conversations and receive AI-generated responses to help guide your chats in personal, romantic, or professional contexts.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Data Usage',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We do not store your typed conversations. However, the text is temporarily sent to a third-party AI API for generating appropriate responses. The generated suggestions are then displayed to you.',
              ),
              SizedBox(height: 16),
              Text(
                '3. Privacy & Security',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We do not collect or permanently store your personal messages. Your privacy is important to us. However, we recommend not entering any sensitive or personally identifiable information.',
              ),
              SizedBox(height: 16),
              Text(
                '4. Acceptance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'By creating an account and using the app, you acknowledge and agree to these terms. If you do not agree, please do not use the app.',
              ),
              SizedBox(height: 16),
              Text(
                '5. Modifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We may update these terms from time to time. You will be notified in-app or via email of any significant changes.',
              ),
              SizedBox(height: 24),
              Text(
                'If you have any questions about these Terms, please contact support.',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
