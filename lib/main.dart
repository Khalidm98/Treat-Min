import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/MainScreen.dart';
import './screens/SplashScreen.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
      },
    );
  }
}
