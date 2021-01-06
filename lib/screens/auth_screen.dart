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

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AuthMode _mode = AuthMode.signUp;
  TapGestureRecognizer _switchMode;
  AnimationController _controller;
  Animation<double> _opacity;
  bool _passObscure = true;

  @override
  void initState() {
    super.initState();
    _switchMode = TapGestureRecognizer()
      ..onTap = () {
        if (_mode == AuthMode.signUp) {
          setState(() => _mode = AuthMode.logIn);
          _controller.forward();
        } else {
          setState(() => _mode = AuthMode.signUp);
          _controller.reverse();
        }
      };

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _switchMode.dispose();
    _controller.dispose();
    super.dispose();
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
              Form(
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
                          textInputAction: _mode == AuthMode.logIn
                              ? TextInputAction.next
                              : null,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(
                        maxHeight: _mode == AuthMode.signUp ? 0 : 100,
                      ),
                      child: FadeTransition(
                        opacity: _opacity,
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        child: Text(
                          _mode == AuthMode.signUp ? 'Sign Up' : 'Log In',
                        ),
                        onPressed: _mode == AuthMode.signUp
                            ? () {
                                Navigator.of(context)
                                    .pushNamed(VerificationScreen.routeName);
                              }
                            : () {
                                Navigator.of(context)
                                    .pushReplacementNamed(TabsScreen.routeName);
                              },
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FloatingActionButton(
          child: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
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
