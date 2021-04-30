import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './auth_screen.dart' show AuthMode;
import './info_screen.dart';
import './password_screen.dart';
import '../api/accounts.dart';
import '../localizations/app_localizations.dart';
import '../utils/dialogs.dart';
import '../widgets/background_image.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = '/verify';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List _controllers = List.generate(4, (_) => TextEditingController());
  final List _focusNodes = List.generate(3, (_) => FocusNode());
  TapGestureRecognizer _resendCode;

  @override
  void initState() {
    super.initState();
    _resendCode = TapGestureRecognizer()
      ..onTap = () async {
        prompt(
          context,
          'Are you sure you want us to send a new code to your email?',
          onYes: () async {
            final args = ModalRoute.of(context).settings.arguments as Map;
            final email = args['email'];
            final mode = args['mode'];
            final response = mode == AuthMode.signUp
                ? await AccountAPI.registerEmail(context, email)
                : await AccountAPI.passwordEmail(context, email);
            if (response) {
              alert(context, getText('resend_message'));
            }
          },
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

  Future<void> _verify() async {
    String strCode = '';
    for (TextEditingController num in _controllers) {
      strCode += num.text;
    }

    final code = int.tryParse(strCode);
    if (code == null) {
      alert(context, 'Code must consist of exactly 4 digits!');
      return;
    }

    final args = ModalRoute.of(context).settings.arguments as Map;
    final email = args['email'];
    final mode = args['mode'];
    if (mode == AuthMode.signUp) {
      final response = await AccountAPI.registerCode(context, email, code);
      if (response == true) {
        Navigator.of(context).pushNamed(InfoScreen.routeName, arguments: email);
      }
    } else {
      final response = await AccountAPI.passwordCode(context, email, code);
      if (response == true) {
        Navigator.of(context)
            .pushNamed(PasswordScreen.routeName, arguments: email);
      }
    }
  }

  Widget _codeInputField(ThemeData theme) {
    final side = (MediaQuery.of(context).size.width - 140) / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [0, 1, 2, 3].map((index) {
          return SizedBox(
            width: side,
            height: side,
            child: TextField(
              onChanged: index == 3
                  ? (num) {
                      if (num.isNotEmpty) {
                        if (num.length == 2) {
                          _controllers[3].text = num[1];
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
                        _focusNodes[index].requestFocus();
                      }
                      setState(() {});
                    },
              onTap: () {
                _controllers[index].selection = TextSelection.collapsed(
                  offset: _controllers[index].text.length,
                );
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
              focusNode: index == 0 ? null : _focusNodes[index - 1],
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
    setAppLocalization(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BackgroundImage(
        child: GestureDetector(
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
                        getText('verify'),
                        style: theme.textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      _codeInputField(theme),
                      RichText(
                        text: TextSpan(
                          text: getText('no_code'),
                          style: theme.textTheme.subtitle1
                              .copyWith(color: theme.hintColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: getText('resend'),
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
                  child: Text(getText('continue')),
                  onPressed: () {
                    bool isFilled = true;
                    for (var controller in _controllers) {
                      if (controller.text.isEmpty) {
                        isFilled = false;
                        break;
                      }
                    }
                    if (isFilled) {
                      _verify();
                    } else {
                      alert(context, getText('code_error'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
