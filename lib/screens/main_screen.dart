import 'package:flutter/material.dart';

import './select_screen.dart';
import '../widgets/app_raised_button.dart';

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
            AppRaisedButton(
              label: 'Outpatient Clinic',
              onPressed: () {
                Navigator.of(context).pushNamed(SelectScreen.routeName);
              },
            ),
            SizedBox(height: 30),
            AppRaisedButton(
              label: 'Services',
              onPressed: () {},
            ),
            SizedBox(height: 30),
            AppRaisedButton(
              label: 'Special Rooms',
              onPressed: () {},
            ),
            SizedBox(height: 30),
            AppRaisedButton(
              label: 'Emergency',
              onPressed: () {},
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
