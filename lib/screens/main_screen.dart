import 'package:flutter/material.dart';

import './select_screen.dart';

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
              child: Text('Outpatient Clinic'),
              onPressed: () {
                Navigator.of(context).pushNamed(SelectScreen.routeName);
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text('Services'),
              onPressed: () {},
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text('Special Rooms'),
              onPressed: () {},
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text('Emergency'),
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
