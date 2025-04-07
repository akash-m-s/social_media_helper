import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/login_register_page.dart';
import '../services/auth_service.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  WidgetTreeState createState() => WidgetTreeState();
}

class WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().authStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginRegisterPage();
          }
        });
  }
}
