import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextFormField textFormField;

  const InputField({@required this.label, @required this.textFormField});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          alignment: Alignment.bottomCenter,
          child: textFormField,
        ),
        Align(
          alignment: Alignment(-0.8, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
