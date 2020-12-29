import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './auth_screen.dart';
import '../widgets/app_raised_button.dart';

class GetStartedScreen extends StatelessWidget {
  static const routeName = '/get-started';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/logo.png'),
              Text(
                'Care close to home',
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/images/doctor.png',
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              AppRaisedButton(
                label: 'GET STARTED',
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
