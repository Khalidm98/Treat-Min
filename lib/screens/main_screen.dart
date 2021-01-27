import 'package:flutter/material.dart';
import 'package:treat_min/widgets/translated_text.dart';

import './emergency_screen.dart';
import './select_screen.dart';
import '../utils/enumerations.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 80),
            ElevatedButton(
              child: TranslatedText(
                jsonKey: 'Outpatient Clinics',
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Book.clinic,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: TranslatedText(
                jsonKey: 'Services',
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Book.service,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: TranslatedText(
                jsonKey: 'Special Rooms',
              ),
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
              child: TranslatedText(
                jsonKey: 'Emergency',
              ),
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
