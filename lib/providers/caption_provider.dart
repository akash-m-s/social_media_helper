import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CaptionProvider with ChangeNotifier {
  final ApiService _api = ApiService();

  String _caption = '';
  bool _isLoading = false;
  Uint8List? _imageBytes;

  String get caption => _caption;
  bool get isLoading => _isLoading;
  Uint8List? get imageBytes => _imageBytes;

  Future<void> generateCaption(Uint8List imageBytes) async {
    _isLoading = true;
    _imageBytes = imageBytes;
    _caption = '';
    notifyListeners();

    try {
      final generatedCaption = await _api.generateCaption(imageBytes);
      _caption = generatedCaption;
    } catch (e) {
      _caption = 'Error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _caption = '';
    _imageBytes = null;
    notifyListeners();
  }
}
