import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/auth_screen.dart';
import './screens/get_started_screen.dart';
import './screens/main_screen.dart';
import './screens/splash_screen.dart';

void main() {
  // Set device orientation to only Portrait up
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treat-Min',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        GetStartedScreen.routeName: (ctx) => GetStartedScreen(),
        MainScreen.routeName: (ctx) => MainScreen(),
      },
    );
  }
}
