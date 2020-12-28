import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/auth_screen.dart';
import './screens/available_screen.dart';
import './screens/get_started_screen.dart';
import './screens/select_screen.dart';
import './screens/setup_screen.dart';
import './screens/splash_screen.dart';
import './screens/tabs_screen.dart';
import './screens/verification_screen.dart';

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
        fontFamily: 'Montserrat',
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey, height: 1.5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
      home: SplashScreen(),
      routes: {
        AuthScreen.routeName: (_) => AuthScreen(),
        AvailableScreen.routeName: (_) => AvailableScreen(),
        GetStartedScreen.routeName: (_) => GetStartedScreen(),
        SelectScreen.routeName: (_) => SelectScreen(),
        SetupScreen.routeName: (_) => SetupScreen(),
        TabsScreen.routeName: (_) => TabsScreen(),
        VerificationScreen.routeName:(_) => VerificationScreen(),
      },
    );
  }
}
