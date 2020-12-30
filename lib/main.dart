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
    const Color greenLight = const Color(0xFF60C0A0);
    const Color green = const Color(0xFF40B080);
    const Color greenDark = const Color(0xFF20A060);
    const Color blue = const Color(0xFF205070);
    const Color red = const Color(0xFFA01010);
    return MaterialApp(
      title: 'Treat-Min',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: green,
        primaryColorDark: greenDark,
        primaryColorLight: greenLight,
        accentColor: blue,
        errorColor: red,
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(centerTitle: true),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          buttonColor: greenDark,
          height: 50,
          minWidth: double.infinity,
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: greenDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: greenDark),
          ),
        ),
        textTheme: const TextTheme(
          button: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          headline4:
          const TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
          headline5: const TextStyle(fontWeight: FontWeight.w700, color: blue),
          subtitle1: const TextStyle(fontWeight: FontWeight.w500),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: greenLight,
          selectionColor: greenLight,
          selectionHandleColor: greenLight,
        ),
        useTextSelectionTheme: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        AuthScreen.routeName: (_) => AuthScreen(),
        AvailableScreen.routeName: (_) => AvailableScreen(),
        GetStartedScreen.routeName: (_) => GetStartedScreen(),
        SelectScreen.routeName: (_) => SelectScreen(),
        SetupScreen.routeName: (_) => SetupScreen(),
        TabsScreen.routeName: (_) => TabsScreen(),
        VerificationScreen.routeName: (_) => VerificationScreen(),
      },
    );
  }
}
