import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Send chat data as JSON to the API
  Future<void> sendChatDataToAPI(String chatDataJson) async {
    // Your API URL
    final url = Uri.parse('https://your-api-endpoint.com/chat-data');

    // Set up the headers
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token_here', // If you need an auth token
    };

    // Make the POST request to your API
    final response = await http.post(
      url,
      headers: headers,
      body: chatDataJson,
    );

    // Check for response status
    if (response.statusCode == 200) {
      debugPrint('Data sent successfully!');
    } else {
      debugPrint('Failed to send data: ${response.statusCode}');
    }
  }
}
