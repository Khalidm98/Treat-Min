import 'package:flutter/material.dart';

import './emergency_screen.dart';
import './select_screen.dart';
import '../localizations/app_localizations.dart';
import '../utils/enumerations.dart';
import '../widgets/background_image.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setAppLocalization(context);
    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(height: 80),
              ElevatedButton(
                child: Text(t(entityToString(Entity.clinic))),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    SelectScreen.routeName,
                    arguments: Entity.clinic,
                  );
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text(t(entityToString(Entity.service))),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    SelectScreen.routeName,
                    arguments: Entity.service,
                  );
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EmergencyScreen.routeName);
                },
                child: Text(t('emergency')),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).errorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
