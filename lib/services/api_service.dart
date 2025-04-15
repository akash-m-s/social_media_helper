import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = 'YOUR_API_KEY';
  final String endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<String> generateCaption(Uint8List imageBytes) async {
    // Simulate response since OpenAI Vision isn't directly supported here
    return "A stunning sunset over the ocean.";
  }

  Future<List<String>> suggestHashtags(String text) async {
    // final prompt = "Suggest 10 hashtags for the following content: $text";
    // final response = await _askGPT(prompt);
    final response = [
      "sunset",
      "ocean",
      "nature",
      "photography",
      "travel",
      "beautiful",
      "landscape",
      "sky",
      "beach",
      "vacation"
    ].join('\n');
    return _extractList(response);
  }

  Future<List<String>> generateKeywords(String text) async {
    final prompt = "Generate SEO-friendly keywords for this topic: $text";
    final response = await _askGPT(prompt);
    return _extractList(response);
  }

  Future<String> _askGPT(String prompt) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": prompt}
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception("API call failed: ${response.body}");
    }
  }

  List<String> _extractList(String response) {
    return response
        .split(RegExp(r'\d+\.|\n|- '))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}
