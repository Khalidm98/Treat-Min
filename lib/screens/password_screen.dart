import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './auth_screen.dart';
import '../api/accounts.dart';
import '../localizations/app_localizations.dart';
import '../providers/user_data.dart';
import '../utils/dialogs.dart';
import '../widgets/background_image.dart';
import '../widgets/input_field.dart';

class PasswordScreen extends StatefulWidget {
  static const String routeName = '/password';

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _data = Map();
  final _passObscure = [true, true, true];

  String _validator(value) {
    if (value.isEmpty) {
      return getText('password_empty');
    } else if (value.length < 8) {
      return getText('password_length');
    } else if (int.tryParse(value) != null) {
      return getText('password_numbers');
    }
    return null;
  }

  Future<void> _save(bool isLoggedIn) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (_data['password'] != _data['confirm']) {
      alert(context, 'New password and confirm password must match!');
      return;
    }

    if (isLoggedIn) {
      final response = await AccountAPI.changePassword(
          context, _data['old'], _data['password']);
      if (response) {
        alert(context, 'Your password was changed successfully.', onOk: () {
          Navigator.pop(context);
        });
      }
    } else {
      final email = ModalRoute.of(context).settings.arguments;
      final response =
          await AccountAPI.passwordReset(context, email, _data['password']);
      if (response) {
        alert(context, 'Your password was reset successfully.', onOk: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AuthScreen.routeName, (route) => false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoggedIn = Provider.of<UserData>(context, listen: false).isLoggedIn;
    setAppLocalization(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BackgroundImage(
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      isLoggedIn ? 'Change Password' : 'Password Reset',
                      style: theme.textTheme.headline4,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        !isLoggedIn
                            ? SizedBox()
                            : InputField(
                                label: 'Current Password',
                                textFormField: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: '********',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _passObscure[0] = !_passObscure[0];
                                        });
                                      },
                                      child: Icon(_passObscure[0]
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                  ),
                                  obscureText: _passObscure[0],
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) => _data['old'] = value,
                                  validator: _validator,
                                ),
                              ),
                        SizedBox(height: !isLoggedIn ? 0 : 30),
                        InputField(
                          label: 'New Password',
                          textFormField: TextFormField(
                            decoration: InputDecoration(
                              hintText: '********',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passObscure[1] = !_passObscure[1];
                                  });
                                },
                                child: Icon(_passObscure[1]
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            obscureText: _passObscure[1],
                            textInputAction: TextInputAction.next,
                            onSaved: (value) => _data['password'] = value,
                            validator: _validator,
                          ),
                        ),
                        const SizedBox(height: 30),
                        InputField(
                          label: 'Confirm Password',
                          textFormField: TextFormField(
                            decoration: InputDecoration(
                              hintText: '********',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passObscure[2] = !_passObscure[2];
                                  });
                                },
                                child: Icon(_passObscure[2]
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            obscureText: _passObscure[2],
                            onSaved: (value) => _data['confirm'] = value,
                            validator: _validator,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    child: Text('Save'),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _save(isLoggedIn);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
