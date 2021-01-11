import 'package:flutter/material.dart';

import './auth_screen.dart';
import './tabs_screen.dart';

class GetStartedScreen extends StatelessWidget {
  static const String routeName = '/get-started';

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
              // ElevatedButton(
              //   child: Text('Log In'),
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(
              //       Theme.of(context).accentColor,
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.of(context)
              //         .pushReplacementNamed(AuthScreen.routeName);
              //   },
              // ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Log In'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).accentColor,
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(0, 40),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AuthScreen.routeName);
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Explore'),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(0, 40),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(TabsScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
