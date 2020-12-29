import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './setup_screen.dart';
import '../widgets/app_raised_button.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verify';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> _controllers = List();
  List<FocusNode> _focusNodes = List();
  TapGestureRecognizer _resendCode;
  double _side;
  Color _color;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
    _controllers.add(TextEditingController());
    _resendCode = TapGestureRecognizer()
      ..onTap = () {
        print('Resend');
      };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_side == null) {
      _side = (MediaQuery.of(context).size.width - 140) / 4;
      _color = Theme.of(context).primaryColor;
    }
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _resendCode.dispose();
    super.dispose();
  }

  Widget _codeInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [3, 2, 1, 0].map((index) {
          return SizedBox(
            width: _side,
            height: _side,
            child: TextField(
              onChanged: index == 0
                  ? (num) {
                      if (num.isNotEmpty) {
                        if (num.length == 2) {
                          _controllers[0].text = num[1];
                        }
                        FocusScope.of(context).unfocus();
                      }
                      setState(() {});
                    }
                  : (num) {
                      if (num.isNotEmpty) {
                        if (num.length == 2) {
                          _controllers[index].text = num[1];
                        }
                        _focusNodes[index - 1].requestFocus();
                      }
                      setState(() {});
                    },
              controller: _controllers[index],
              cursorColor:
                  _controllers[index].text.isEmpty ? Colors.green : Colors.white,
              decoration: InputDecoration(
                counterText: '',
                fillColor: _color,
                filled: _controllers[index].text.isNotEmpty,
              ),
              focusNode: index == 3 ? null : _focusNodes[index],
              keyboardType: TextInputType.number,
              maxLength: 2,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    SizedBox(height: 50),
                    Text(
                      'Verify your email address\nwith the code sent to you',
                      textScaleFactor: 1.25,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _codeInputField(),
                    RichText(
                      text: TextSpan(
                        text: 'Didn\'t receive the code? ',
                        style: const TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Resend',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                            recognizer: _resendCode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppRaisedButton(
                label: 'Continue',
                onPressed: () {
                  Navigator.of(context).pushNamed(SetupScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          child: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          splashColor: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
