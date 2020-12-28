import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './tabs_screen.dart';
import './verification_screen.dart';
import '../widgets/app_raised_button.dart';
import '../widgets/input_field.dart';

enum AuthMode { signUp, logIn }
enum Social { google, facebook }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _mode = AuthMode.signUp;
  final FocusNode _passNode = FocusNode();

  @override
  void dispose() {
    _passNode.dispose();
    super.dispose();
  }

  void _switchMode() {
    if (_mode == AuthMode.signUp) {
      setState(() => _mode = AuthMode.logIn);
    } else {
      setState(() => _mode = AuthMode.signUp);
    }
  }

  Widget _buildSocialButton(Social social) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: social == Social.google ? Colors.white : Colors.indigo[600],
        onPressed: () {},
        icon: Image.asset(
          'assets/icons/${social == Social.google ? 'google' : 'facebook'}.png',
          height: 30,
        ),
        label: Text(
          '${_mode == AuthMode.signUp ? 'Sign Up' : 'Log In'} with '
          '${social == Social.google ? 'Google' : 'Facebook'}',
          textScaleFactor: 1.3,
          style: TextStyle(
            color: social == Social.google ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      _mode == AuthMode.signUp ? 'Sign Up' : 'Log In',
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 500),
                    crossFadeState: _mode == AuthMode.signUp
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InputField(
                              label: 'Email Address',
                              textFormField: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'test@example.com',
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: AppRaisedButton(
                              label: 'Sign Up',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, VerificationScreen.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    secondChild: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InputField(
                              label: 'Email Address',
                              textFormField: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'test@example.com',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (_) {
                                  _passNode.requestFocus();
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InputField(
                              label: 'Password',
                              textFormField: TextFormField(
                                decoration: InputDecoration(
                                  hintText: '********',
                                ),
                                obscureText: true,
                                focusNode: _passNode,
                                onFieldSubmitted: (_) {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: AppRaisedButton(
                              label: 'Log In',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, TabsScreen.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 3, height: 30, indent: 10, endIndent: 10),
                  _buildSocialButton(Social.google),
                  _buildSocialButton(Social.facebook),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            '${_mode == AuthMode.signUp ? 'Already' : 'Don\'t '} '
                            'have an account? ',
                        style: TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                _mode == AuthMode.signUp ? 'Log In' : 'Sign Up',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _switchMode,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
