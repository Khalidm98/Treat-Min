import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './tabs_screen.dart';
import './verification_screen.dart';
import '../api/accounts.dart';
import '../localizations/app_localizations.dart';
import '../widgets/input_field.dart';
import '../utils/dialogs.dart';
import '../widgets/background_image.dart';
// import '../widgets/social_button.dart';

enum AuthMode { signUp, login }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _data = Map();
  AuthMode _mode = AuthMode.login;
  AnimationController _controller;
  Animation<double> _animation;
  bool _passObscure = true;
  TapGestureRecognizer _switchMode;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();

    _switchMode = TapGestureRecognizer()
      ..onTap = () {
        if (_mode == AuthMode.signUp) {
          setState(() => _mode = AuthMode.login);
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

  Future<void> _signUp() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    final response = await AccountAPI.registerEmail(context, _data['email']);
    if (response) {
      Navigator.of(context).pushNamed(
        VerificationScreen.routeName,
        arguments: {'mode': _mode, 'email': _data['email']},
      );
    }
  }

  Future<void> _logIn() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    final response = await AccountAPI.login(context, _data);
    if (response) {
      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
    }
  }

  Future<void> _forgotPassword() async {
    _mode = AuthMode.signUp;
    if (!_formKey.currentState.validate()) {
      _mode = AuthMode.login;
      return;
    }
    _formKey.currentState.save();
    _mode = AuthMode.login;

    prompt(context, t('forgot_password_message'), onYes: () async {
      final response = await AccountAPI.passwordEmail(context, _data['email']);
      if (response) {
        Navigator.of(context).pushNamed(
          VerificationScreen.routeName,
          arguments: {'mode': _mode, 'email': _data['email']},
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setAppLocalization(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BackgroundImage(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t(_mode == AuthMode.signUp ? 'sign_up' : 'log_in'),
                  style: theme.textTheme.headline4,
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InputField(
                          label: t('email'),
                          textFormField: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'address@example.com',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onSaved: (value) => _data['email'] = value,
                            validator: (value) {
                              if (value.isEmpty) {
                                return t('email_empty');
                              } else if (!value.contains('.') ||
                                  !value.contains('@') ||
                                  value.indexOf('@') !=
                                      value.lastIndexOf('@') ||
                                  value.indexOf('@') > value.lastIndexOf('.')) {
                                return t('email_valid');
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: _animation,
                        child: FadeTransition(
                          opacity: _animation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InputField(
                                  label: t('password'),
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
                                    onSaved: (value) {
                                      if (_mode == AuthMode.login) {
                                        _data['password'] = value;
                                      }
                                    },
                                    validator: (value) {
                                      if (_mode == AuthMode.signUp) {
                                        return null;
                                      } else if (value.isEmpty) {
                                        return t('password_empty');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: _forgotPassword,
                                  child: Text(
                                    t('forgot_password'),
                                    style: theme.textTheme.subtitle1
                                        .copyWith(color: theme.hintColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    child: Text(
                      t(
                        _mode == AuthMode.signUp ? 'sign_up' : 'log_in',
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _mode == AuthMode.signUp ? _signUp() : _logIn();
                    },
                  ),
                ),
                // Divider(
                //   thickness: 3,
                //   height: 30,
                //   indent: 10,
                //   endIndent: 10,
                //   color: Colors.grey,
                // ),
                // SocialButton(_mode, Social.google),
                // SocialButton(_mode, Social.facebook),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RichText(
                    text: TextSpan(
                      text: t(_mode == AuthMode.signUp
                          ? 'already_registered'
                          : 'not_registered'),
                      style: theme.textTheme.subtitle1
                          .copyWith(color: theme.hintColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: t(
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FloatingActionButton(
          child: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          splashColor: theme.primaryColor,
          elevation: 0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
