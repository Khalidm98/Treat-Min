import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './tabs_screen.dart';
import './verification_screen.dart';
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
  TapGestureRecognizer _switchMode;
  final FocusNode _passNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _switchMode = TapGestureRecognizer()
      ..onTap = () {
        if (_mode == AuthMode.signUp) {
          setState(() => _mode = AuthMode.logIn);
        } else {
          setState(() => _mode = AuthMode.signUp);
        }
      };
  }

  @override
  void dispose() {
    _switchMode.dispose();
    _passNode.dispose();
    super.dispose();
  }

  Widget _buildSocialButton(Social social) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/icons/${social == Social.google ? 'google' : 'facebook'}.png',
          height: 30,
        ),
        label: Text(
          '${_mode == AuthMode.signUp ? 'Sign Up' : 'Log In'} with '
          '${social == Social.google ? 'Google' : 'Facebook'}',
        ),
        color: social == Social.google ? Colors.white : Colors.indigo[600],
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _mode == AuthMode.signUp ? 'Sign Up' : 'Log In',
                style: theme.textTheme.headline4,
              ),
              SizedBox(height: 40),
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
                        child: RaisedButton(
                          child: Text('Sign Up'),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(VerificationScreen.routeName);
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
                            decoration: InputDecoration(hintText: '********'),
                            obscureText: true,
                            focusNode: _passNode,
                            onFieldSubmitted: (_) {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RaisedButton(
                          child: Text('Log In'),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(TabsScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 3,
                height: 30,
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              ),
              _buildSocialButton(Social.google),
              _buildSocialButton(Social.facebook),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: '${_mode == AuthMode.signUp ? 'Already' : 'Don\'t'}'
                      ' have an account? ',
                  style: theme.textTheme.subtitle1
                      .copyWith(color: theme.hintColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: _mode == AuthMode.signUp ? 'Log In' : 'Sign Up',
                      style: TextStyle(color: theme.primaryColorDark),
                      recognizer: _switchMode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
