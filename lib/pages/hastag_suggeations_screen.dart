import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/hash_tag_provider.dart';

class HashtagSuggestionScreen extends StatefulWidget {
  const HashtagSuggestionScreen({super.key});

  @override
  State<HashtagSuggestionScreen> createState() =>
      _HashtagSuggestionScreenState();
}

class _HashtagSuggestionScreenState extends State<HashtagSuggestionScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HashtagProvider>(context);
    final hashtags = provider.hashtags.map((tag) => '#$tag').toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Hashtag Suggestions")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Enter content"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                provider.fetchHashtags(controller.text);
              },
              child: const Text("Generate Hashtags"),
            ),
            const SizedBox(height: 20),
            if (provider.isLoading)
              const CircularProgressIndicator()
            else if (hashtags.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    final allTags = hashtags.join(' ');
                    copyToClipboard(context, allTags);
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text("Copy All"),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: hashtags.map((tag) {
                  return ActionChip(
                    label: Text(tag),
                    avatar: const Icon(Icons.copy, size: 18),
                    backgroundColor: Colors.blue.shade50,
                    onPressed: () => copyToClipboard(context, tag),
                  );
                }).toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Copied to clipboard!')),
  );
}
