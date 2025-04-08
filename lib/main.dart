import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'models/chat_message.dart';
import 'providers/auth_providers.dart';
import 'firebase_options.dart';
import 'providers/chat_provider.dart';
import 'providers/theme_providers.dart';
import 'shared/disposible_email_domain_validator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final validator = DisposableEmailValidator();
  await validator.loadDomains();

  runApp(MyApp(
    validator: validator,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.validator,
  });
  final DisposableEmailValidator validator;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DisposableEmailValidator>.value(value: validator),
        ChangeNotifierProvider(
            create: (_) => AuthProvider(
                  validator,
                )),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()..init()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Flutter Firebase App',
            theme:
                themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            routerConfig: AppRouter.getRouter(context),
          );
        },
      ),
    );
  }
}
