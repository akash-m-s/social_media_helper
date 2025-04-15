import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HashtagProvider with ChangeNotifier {
  final ApiService _api = ApiService();
  List<String> _hashtags = [];
  bool _loading = false;

  List<String> get hashtags => _hashtags;
  bool get isLoading => _loading;

  Future<void> fetchHashtags(String text) async {
    _loading = true;
    notifyListeners();
    try {
      _hashtags = await _api.suggestHashtags(text);
    } catch (e) {
      _hashtags = ["Error: ${e.toString()}"];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
