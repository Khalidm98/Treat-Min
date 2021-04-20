import 'package:flutter/material.dart';
import '../localizations/app_localizations.dart';

void loading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    child: WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(title: Center(child: CircularProgressIndicator())),
    ),
  );
}

void alert(BuildContext context, String message) {
  showDialog(
    context: context,
    child: AlertDialog(
      title: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(getText('ok')),
        ),
      ],
    ),
  );
}
