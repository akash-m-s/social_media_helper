import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; // For clipboard functionality
import '../providers/caption_provider.dart';
import 'hastag_suggeations_screen.dart';

class CaptionGeneratorScreen extends StatelessWidget {
  const CaptionGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CaptionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Caption Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centering content
          children: [
            // Description Section
            const Text(
              "Want the perfect caption for your image? Select an image, and we will help you generate a catchy caption using AI!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            // Image Preview Section
            provider.imageBytes != null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        provider.imageBytes!,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      "No image selected. Please pick an image from your gallery.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ),
            const SizedBox(height: 20),

            // Pick Image Button
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  final bytes = await image.readAsBytes();
                  await provider.generateCaption(bytes);
                }
              },
              child: const Text("Pick Image from Gallery"),
            ),
            const SizedBox(height: 20),

            // Loading Indicator or Generated Caption
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.caption.isNotEmpty
                    ? Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // Center the text
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Generated Caption:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            provider.caption,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          ActionChip(
                            label: const Text('Copy caption'),
                            avatar: const Icon(Icons.copy, size: 18),
                            backgroundColor: Colors.blue.shade50,
                            onPressed: () =>
                                copyToClipboard(context, provider.caption),
                          ),
                        ],
                      )
                    : const SizedBox
                        .shrink(), // Empty space if no caption is generated
          ],
        ),
      ),
    );
  }
}
