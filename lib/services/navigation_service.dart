import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navigate to a new route
  Future<dynamic> navigateTo(String routeName) async {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  // Go back
  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
