import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const EWasteApp());
}

class EWasteApp extends StatelessWidget {
  const EWasteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Waste Hub',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
      routes: {
        '/main': (context) => const MainScreen(),
        '/splash': (context) => const SplashScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/main') {
          // Handle different types of arguments
          if (settings.arguments == null) {
            return MaterialPageRoute(
              builder: (context) => const MainScreen(),
            );
          } else if (settings.arguments is int) {
            // If argument is an integer, it's just the tab index
            return MaterialPageRoute(
              builder: (context) => MainScreen(initialIndex: settings.arguments as int),
            );
          } else if (settings.arguments is Map) {
            // If argument is a map, it contains both index and category
            final args = settings.arguments as Map;
            return MaterialPageRoute(
              builder: (context) => MainScreen(
                initialIndex: args['index'] as int,
                browseCategory: args['category'] as String,
              ),
            );
          }
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
} 