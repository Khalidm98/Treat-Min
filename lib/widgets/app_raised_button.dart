import 'package:flutter/material.dart';

class AppRaisedButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color color;

  const AppRaisedButton({
    @required this.label,
    @required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: color == null
                ? [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorDark,
                  ]
                : [
                    Colors.red,
                    Colors.red[800],
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.7, 1],
          ),
        ),
        child: Text(
          label,
          textScaleFactor: 1.5,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
