import 'package:flutter/material.dart';

import './emergency_screen.dart';
import './select_screen.dart';
import '../localizations/app_localizations.dart';
import '../utils/enumerations.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setAppLocalization(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 80),
            ElevatedButton(
              child: Text(getText(entityToString(Entity.clinic))),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Entity.clinic,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text(getText(entityToString(Entity.service))),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Entity.service,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text(getText(entityToString(Entity.room))),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectScreen.routeName,
                  arguments: Entity.room,
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EmergencyScreen.routeName);
              },
              child: Text(getText('emergency')),
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
