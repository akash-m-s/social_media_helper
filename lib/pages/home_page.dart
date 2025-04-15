import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Social Media Helper")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Social Media Helper!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "This app assists you with crafting thoughtful conversations, "
              "writing better captions, and discovering the best hashtags for your posts. "
              "Whether you're chatting with someone special or posting to grow your audience, we've got you!",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildFeatureTile(
              context,
              title: "💬 Chat Helper",
              description:
                  "Craft personalized messages in social, dating, or professional contexts.",
              route: '/chat',
            ),
            _buildFeatureTile(
              context,
              title: "🖼️ Caption Generator",
              description:
                  "Generate smart, catchy captions for your images using AI.",
              route: '/caption-generator',
            ),
            _buildFeatureTile(
              context,
              title: "🏷️ Hashtag Suggestions",
              description:
                  "Get trending and relevant hashtags based on your content.",
              route: '/hashtag-helper',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context,
      {required String title,
      required String description,
      required String route}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => context.push(route),
      ),
    );
  }
}
