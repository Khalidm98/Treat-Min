import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './tabs_screen.dart';
import './verification_screen.dart';
import '../api/accounts.dart';
import '../localizations/app_localizations.dart';
import '../utils/dialogs.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _mode = AuthMode.signUp;
  AnimationController _controller;
  Animation<double> _opacity;
  bool _passObscure = true;
  TapGestureRecognizer _switchMode;
  Map<String, String> _data = Map();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _switchMode = TapGestureRecognizer()
      ..onTap = () {
        _formKey.currentState.reset();
        if (_mode == AuthMode.signUp) {
          setState(() => _mode = AuthMode.logIn);
          _controller.forward();
        } else {
          setState(() => _mode = AuthMode.signUp);
          _controller.reverse();
        }
      };
  }

  @override
  void dispose() {
    _controller.dispose();
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

  Future<void> _signUp() async {
    if (_submit()) {
      Navigator.of(context).pushNamed(
        VerificationScreen.routeName,
        arguments: _data['email'],
      );
      // loading(context);
      // final response = await AccountAPI.sendEmail(_data['email']);
      // Navigator.pop(context);
      //
      // if (response == true) {
      //   Navigator.of(context).pushNamed(
      //     VerificationScreen.routeName,
      //     arguments: _data['email'],
      //   );
      // } else {
      //   alert(context, response);
      // }
    }
  }

  Future<void> _logIn() async {
    if (_submit()) {
      loading(context);
      final response = await AccountAPI.login(context, _data);
      Navigator.pop(context);

      if (response == true) {
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      } else {
        alert(context, response);
      }
    }
  }

  // Widget _socialButton(Social social) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: ElevatedButton.icon(
  //       onPressed: () {},
  //       icon: Image.asset(
  //         'assets/icons/${social == Social.google ? 'google' : 'facebook'}.png',
  //         height: 30,
  //       ),
  //       label: Text(
  //         '${getText(_mode == AuthMode.signUp ? 'sign_up' : 'log_in')} '
  //         '${getText(social == Social.google ? 'google' : 'facebook')}',
  //       ),
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all<Color>(
  //           social == Social.google ? Colors.white : Colors.indigo[600],
  //         ),
  //         foregroundColor: MaterialStateProperty.all<Color>(
  //           social == Social.google ? Colors.black : Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setAppLocalization(context);

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
              Align(
                alignment: Localizations.localeOf(context).languageCode == 'en'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  },
                  splashRadius: 25,
                  splashColor: theme.primaryColorLight,
                ),
              ),
              Text(
                getText(_mode == AuthMode.signUp ? 'sign_up' : 'log_in'),
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
                        label: getText('email'),
                        textFormField: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'address@example.com',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) => _data['email'] = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return getText('email_empty');
                            } else if (!value.contains('.') ||
                                !value.contains('@') ||
                                value.indexOf('@') != value.lastIndexOf('@') ||
                                value.indexOf('@') > value.lastIndexOf('.')) {
                              return getText('email_valid');
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(
                        maxHeight: _mode == AuthMode.signUp ? 0 : 150,
                      ),
                      child: FadeTransition(
                        opacity: _opacity,
                        child: InputField(
                          label: getText('password'),
                          textFormField: TextFormField(
                            decoration: InputDecoration(
                              hintText: '********',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() => _passObscure = !_passObscure);
                                },
                                child: Icon(_passObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            obscureText: _passObscure,
                            onSaved: (value) {
                              if (_mode == AuthMode.logIn) {
                                _data['password'] = value;
                              }
                            },
                            validator: (value) {
                              if (_mode == AuthMode.signUp) {
                                return null;
                              } else if (value.isEmpty) {
                                return getText('password_empty');
                              } else if (value.length < 8) {
                                return getText('password_length');
                              } else if (int.tryParse(value) != null) {
                                return getText('password_numbers');
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          child: Text(
                            getText(
                              _mode == AuthMode.signUp ? 'sign_up' : 'log_in',
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _mode == AuthMode.signUp ? _signUp() : _logIn();
                          }),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   thickness: 3,
              //   height: 30,
              //   indent: 10,
              //   endIndent: 10,
              //   color: Colors.grey,
              // ),
              // _socialButton(Social.google),
              // _socialButton(Social.facebook),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: RichText(
                  text: TextSpan(
                    text: getText(_mode == AuthMode.signUp
                        ? 'already_registered'
                        : 'not_registered'),
                    style: theme.textTheme.subtitle1
                        .copyWith(color: theme.hintColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: getText(
                          _mode == AuthMode.signUp ? 'log_in' : 'sign_up',
                        ),
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
    );
  }
}
