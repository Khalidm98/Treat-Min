import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './setup_screen.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verify';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> _controllers = List();
  List<FocusNode> _focusNodes = List();
  TapGestureRecognizer _resendCode;

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
        showDialog(
          context: context,
          child: AlertDialog(
            title: const Text('We will send a new code to your email address'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      };
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _resendCode.dispose();
    super.dispose();
  }

  Widget _codeInputField(ThemeData theme) {
    final side = (MediaQuery.of(context).size.width - 140) / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [3, 2, 1, 0].map((index) {
          return SizedBox(
            width: side,
            height: side,
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
              cursorColor: _controllers[index].text.isEmpty
                  ? theme.primaryColorLight
                  : Colors.white,
              decoration: InputDecoration(
                counterText: '',
                fillColor: theme.primaryColor,
                filled: _controllers[index].text.isNotEmpty,
              ),
              focusNode: index == 3 ? null : _focusNodes[index],
              keyboardType: TextInputType.number,
              maxLength: 2,
              style: theme.textTheme.headline5.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      'Verify your email\nwith code sent to you',
                      style: theme.textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    _codeInputField(theme),
                    RichText(
                      text: TextSpan(
                        text: 'Didn\'t receive the code? ',
                        style: theme.textTheme.subtitle1
                            .copyWith(color: theme.hintColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Resend',
                            style: TextStyle(color: theme.accentColor),
                            recognizer: _resendCode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text('Continue'),
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
          splashColor: theme.primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
