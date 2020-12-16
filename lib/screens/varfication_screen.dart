
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../screens/signup_sreen.dart';
import '../screens/setup_screen.dart';

class VerficationScreen extends StatefulWidget {
  static const routeName = '/Verfication_screen';
  @override
  __verficationScreenState createState() => __verficationScreenState();
}


class __verficationScreenState extends State<VerficationScreen> {
  bool _onEditing = true;
  String _code;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('verify code')),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 2,
                selectedColor: Colors.greenAccent,
                unselectedColor: Colors.blueGrey,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Enter your code',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Center(
                child: VerificationCode(
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.greenAccent[900]),
                  keyboardType: TextInputType.number,
                  // in case underline color is null it will use primaryColor: Colors.red from Theme
                  underlineColor: Colors.amber,
                  length: 4,
                  // clearAll is NOT required, you can delete it
                  // takes any widget, so you can implement your design
                  clearAll: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'clear all',
                      style: TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.underline,
                          color: Colors.blue[700]),
                    ),
                  ),
                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: _onEditing
                      ? Text('Please enter full code')
                      : Text('Your code: $_code'),
                ),


                ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: ClipOval(
                    child: Material(
                      color: Colors.green, // button color
                      child: InkWell(
                        splashColor: Colors.teal, // inkwell color
                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.check , color: Colors.white,)),
                        onTap: () {Navigator.pushReplacementNamed(context, SetupScreen.routeName);},
                      ),
                    ),
                  )
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }
}