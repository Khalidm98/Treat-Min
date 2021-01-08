import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './tabs_screen.dart';
import './verification_screen.dart';
import '../widgets/input_field.dart';

enum AuthMode { signUp, logIn }
enum Social { google, facebook }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _mode = AuthMode.signUp;
  bool _passObscure = true;
  TapGestureRecognizer _switchMode;
  Map<String, String> _data = Map();

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
    super.dispose();
  }

  bool _submit() {
    if (!_formKey.currentState.validate()) {
      return false;
    }
    _formKey.currentState.save();
    return true;
  }

  // Future<void> _signUp() async {
  void _signUp() {
    if (_submit()) {
      // post data to server
      // get and store the response
      Navigator.of(context).pushNamed(VerificationScreen.routeName);
    }
  }

  // Future<void> _logIn() async {
  void _logIn() {
    if (_submit()) {
      // post data to server
      // get and store the response
      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
    }
  }

  Widget _buildSocialButton(Social social) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/icons/${social == Social.google ? 'google' : 'facebook'}.png',
          height: 30,
        ),
        label: Text(
          '${_mode == AuthMode.signUp ? 'Sign Up' : 'Log In'} with '
          '${social == Social.google ? 'Google' : 'Facebook'}',
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            social == Social.google ? Colors.white : Colors.indigo[600],
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            social == Social.google ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(TabsScreen.routeName);
                      },
                      splashRadius: 25,
                      splashColor: theme.primaryColorLight,
                    ),
                  ),
                  Text(
                    _mode == AuthMode.signUp ? 'Sign Up' : 'Log In',
                    style: theme.textTheme.headline4,
                  ),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InputField(
                            label: 'Email Address',
                            textFormField: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'address@example.com',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) => _data['email'] = value,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email address cannot be empty!';
                                } else if (!value.contains('.') ||
                                    !value.contains('@') ||
                                    value.indexOf('@') !=
                                        value.lastIndexOf('@')) {
                                  return 'Email address must be valid!';
                                }
                                return null;
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
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passObscure = !_passObscure;
                                    });
                                  },
                                  child: Icon(_passObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              obscureText: _passObscure,
                              onSaved: (value) => _data['pass'] = value,
                              validator: (value) {
                                if (value.length < 8) {
                                  return 'Password must contain at least 8 characters!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            child: Text(
                              _mode == AuthMode.signUp ? 'Sign Up' : 'Log In',
                            ),
                            onPressed:
                                _mode == AuthMode.signUp ? _signUp : _logIn,
                          ),
                        ),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: RichText(
                      text: TextSpan(
                        text:
                            '${_mode == AuthMode.signUp ? 'Already' : 'Don\'t'}'
                            ' have an account? ',
                        style: theme.textTheme.subtitle1
                            .copyWith(color: theme.hintColor),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                _mode == AuthMode.signUp ? 'Log In' : 'Sign Up',
                            style: TextStyle(color: theme.primaryColorDark),
                            recognizer: _switchMode,
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
