import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/auth_screen.dart';
import './screens/available_screen.dart';
import './screens/get_started_screen.dart';
import './screens/select_screen.dart';
import './screens/setup_screen.dart';
import './screens/splash_screen.dart';
import './screens/tabs_screen.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.green,
        accentColor: Colors.indigo,
      ),
      home: SplashScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        AvailableScreen.routeName: (ctx) => AvailableScreen(),
        GetStartedScreen.routeName: (ctx) => GetStartedScreen(),
        SelectScreen.routeName: (ctx) => SelectScreen(),
        SetupScreen.routeName: (ctx) => SetupScreen(),
        TabsScreen.routeName: (ctx) => TabsScreen(),
      },
    );
  }
}
