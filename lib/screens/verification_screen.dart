import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './info_screen.dart';
import '../localizations/app_localizations.dart';

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
      ..onTap = () {
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text(getText('resend_message')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(getText('ok')),
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
        textDirection: TextDirection.ltr,
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
    setAppLocalization(context);

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
                    Navigator.of(context).pushNamed(InfoScreen.routeName);
                  } else {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text(getText('code_error')),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(getText('ok')),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
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
