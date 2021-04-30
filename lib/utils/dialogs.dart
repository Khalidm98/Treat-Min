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

void alert(BuildContext context, String message, {void Function() onOk}) {
  showDialog(
    context: context,
    child: AlertDialog(
      title: Text(message),
      actions: [
        TextButton(
          child: Text(getText('ok')),
          onPressed: onOk == null
              ? () => Navigator.pop(context)
              : () {
            Navigator.pop(context);
            onOk();
          },
        ),
      ],
    ),
  );
}

void prompt(BuildContext context, String message,
    {void Function() onYes, void Function() onNo}) {
  showDialog(
    context: context,
    child: AlertDialog(
      title: Text(message),
      actions: [
        TextButton(
          child: Text(getText('no')),
          onPressed: onNo == null
              ? () => Navigator.pop(context)
              : () {
                  Navigator.pop(context);
                  onNo();
                },
        ),
        TextButton(
          child: Text(getText('yes')),
          onPressed: onYes == null
              ? () => Navigator.pop(context)
              : () {
                  Navigator.pop(context);
                  onYes();
                },
        ),
      ],
    ),
  );
}
