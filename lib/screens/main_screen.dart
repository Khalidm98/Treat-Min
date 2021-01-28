import 'package:flutter/material.dart';

import './emergency_screen.dart';
import './select_screen.dart';
import '../localizations/app_localization.dart';
import '../utils/enumerations.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appText = AppLocalization.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 80),
            ElevatedButton(
              child: Text(appText.getText(bookToString(Book.clinic))),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Book.clinic,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text(appText.getText(bookToString(Book.service))),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Book.service,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text(appText.getText(bookToString(Book.room))),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Book.room,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EmergencyScreen.routeName);
              },
              child: Text(appText.getText('emergency')),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).errorColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
