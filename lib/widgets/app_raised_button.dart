import 'package:flutter/material.dart';

class AppRaisedButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final double borderRad;

  const AppRaisedButton(
      {@required this.onPressed, @required this.label, this.borderRad = 10});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRad)),
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRad),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
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
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
