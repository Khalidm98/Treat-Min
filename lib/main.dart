import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/app_data.dart';
import './providers/user_data.dart';

import './screens/auth_screen.dart';
import './screens/available_screen.dart';
import './screens/emergency_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppData()),
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: MaterialApp(
        title: 'Treat-min',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primaryColor: green,
          primaryColorDark: greenDark,
          primaryColorLight: greenLight,
          accentColor: blue,
          errorColor: red,
          dividerColor: blue,
          colorScheme: ColorScheme.light(primary: green),
          appBarTheme: const AppBarTheme(centerTitle: true),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(greenDark),
              overlayColor: MaterialStateProperty.all<Color>(
                greenLight.withOpacity(0.2),
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(double.infinity, 50),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(color: red),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                red.withOpacity(0.2),
              ),
              overlayColor: MaterialStateProperty.all<Color>(
                red.withOpacity(0.4),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(red),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                blue.withOpacity(0.2),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: red),
            ),
          ),
          textTheme: const TextTheme(
            button: const TextStyle(fontWeight: FontWeight.w700),
            headline4:
                const TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
            headline5: const TextStyle(fontWeight: FontWeight.w700, color: blue),
            subtitle1: const TextStyle(fontWeight: FontWeight.w700),
            bodyText2: const TextStyle(fontWeight: FontWeight.w500),
            caption: const TextStyle(fontWeight: FontWeight.w500),
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
          EmergencyScreen.routeName: (_) => EmergencyScreen(),
          GetStartedScreen.routeName: (_) => GetStartedScreen(),
          SelectScreen.routeName: (_) => SelectScreen(),
          SetupScreen.routeName: (_) => SetupScreen(),
          TabsScreen.routeName: (_) => TabsScreen(),
          VerificationScreen.routeName: (_) => VerificationScreen(),
        },
      ),
    );
  }
}
