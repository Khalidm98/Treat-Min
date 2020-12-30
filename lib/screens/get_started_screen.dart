import 'package:flutter/material.dart';

import './auth_screen.dart';

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
                style: Theme.of(context).textTheme.headline5,
              ),
              Image.asset(
                'assets/images/doctor.png',
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              RaisedButton(
                child: Text('GET STARTED'),
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
