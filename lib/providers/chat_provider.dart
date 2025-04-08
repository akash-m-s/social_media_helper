import 'dart:convert'; // for jsonEncode
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:social_media_helper/models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  late Box<ChatMessage> _chatBox;
  List<ChatMessage> _chatList = [];

  List<ChatMessage> get chatList => _chatList;

  // Initialize Hive box
  Future<void> init() async {
    _chatBox = await Hive.openBox<ChatMessage>('chat_messages');
    _chatList = _chatBox.values.toList();
    notifyListeners();
  }

  // Add a new chat bubble
  void addBubble() {
    final newBubble = ChatMessage(text: '', sender: _nextSender());
    _chatBox.add(newBubble);
    _chatList.add(newBubble);
    notifyListeners();
  }

  // Update the text of a specific bubble
  void updateBubble(int index, String newText) {
    final bubble = _chatList[index];
    bubble.text = newText;
    bubble.save();
    notifyListeners();
  }

  // Determine which sender (A or B) is next
  String _nextSender() {
    if (_chatList.isEmpty) return "A";
    return _chatList.last.sender == "A" ? "B" : "A";
  }

  // Clear all chat bubbles
  void clearAll() {
    _chatBox.clear();
    _chatList.clear();
    notifyListeners();
  }

  // Get chat data as JSON
  Future<String> getChatDataAsJson() async {
    final chatMapList = _chatList.map((bubble) {
      return {
        'text': bubble.text,
        'sender': bubble.sender,
      };
    }).toList();

    // Convert list of maps to JSON string
    return jsonEncode(chatMapList);
  }

  // Send chat data to API
  Future<void> sendChatDataToAPI() async {
    final chatDataJson = await getChatDataAsJson();
    debugPrint('Chat Data JSON: $chatDataJson');
    // await ApiService().sendChatDataToAPI(chatDataJson);
  }
}
