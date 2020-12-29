import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './tabs_screen.dart';
import '../widgets/app_raised_button.dart';
import '../widgets/input_field.dart';
import '../screens/verification_screen.dart';

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
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: social == Social.google ? Colors.white : Colors.indigo[600],
      onPressed: () {},
      icon: Image.asset(
        'assets/icons/${social == Social.google ? 'google' : 'facebook'}.png',
        height: 30,
      ),
      label: AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        crossFadeState: _mode == AuthMode.signUp
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Text(
          'Sign Up with ${social == Social.google ? 'Google' : 'Facebook'}',
          textScaleFactor: 1.3,
          style: TextStyle(
            color: social == Social.google ? Colors.black : Colors.white,
          ),
        ),
        secondChild: Text(
          'Log In with ${social == Social.google ? 'Google' : 'Facebook'}',
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
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 500),
                      crossFadeState: _mode == AuthMode.signUp
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Text(
                        'Sign Up',
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      secondChild: Text(
                        'Log In',
                        textScaleFactor: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 500),
                      crossFadeState: _mode == AuthMode.signUp
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Form(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InputField(
                                label: 'User name ',
                                hintText: 'Someone',
                                keyboardType: TextInputType.name,
                                onFieldSubmitted: (_) {
                                  _passNode.requestFocus();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InputField(
                                label: 'Email Address',
                                hintText: 'test@example.com',
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (_) {
                                  _passNode.requestFocus();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InputField(
                                label: 'Password',
                                hintText: '********',
                                obscureText: true,
                                focusNode: _passNode,
                                onFieldSubmitted: (_) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 500),
                                crossFadeState: _mode == AuthMode.signUp
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                firstChild: AppRaisedButton(
                                  label: 'Sign Up',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, VerificationScreen.routeName);
                                  },
                                ),
                                secondChild: AppRaisedButton(
                                  label: 'Log In',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, TabsScreen.routeName);
                                  },
                                ),
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
                                hintText: 'test@example.com',
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (_) {
                                  _passNode.requestFocus();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InputField(
                                label: 'Password',
                                hintText: '********',
                                obscureText: true,
                                focusNode: _passNode,
                                onFieldSubmitted: (_) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 500),
                                crossFadeState: _mode == AuthMode.signUp
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                firstChild: AppRaisedButton(
                                  label: 'Sign Up',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, VerificationScreen.routeName);
                                  },
                                ),
                                secondChild: AppRaisedButton(
                                  label: 'Log In',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, TabsScreen.routeName);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 3, height: 30, indent: 10, endIndent: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: _buildSocialButton(Social.google),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: _buildSocialButton(Social.facebook),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            '${_mode == AuthMode.signUp ? 'Already' : 'Don\'t'} have an account? ',
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
