import 'package:flutter/material.dart';
import '../widgets/app_raised_button.dart';
import './select_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 60,
          ),
          Image.asset('assets/images/logo.png'),
          SizedBox(
            height: 110,
          ),
          AppRaisedButton(
            label: 'Outpatient Clinic',
            onPressed: (){
              Navigator.of(context).pushNamed(SelectScreen.routeName);
            },
          ),
          SizedBox(
            height: 40,
          ),
          AppRaisedButton(
            label: 'Services',
            onPressed: (){},
          ),
          SizedBox(
            height: 40,
          ),
          AppRaisedButton(
            label: 'Special Rooms',
            onPressed: (){},
          ),
          SizedBox(
            height: 40,
          ),
          AppRaisedButton(
            label: 'Emergency',
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
