import 'package:flutter/material.dart';
import 'doctor_card.dart';

class RatingHearts extends StatelessWidget {
  final double iconWidth;
  final double iconHeight;
  RatingHearts({@required this.iconHeight, @required this.iconWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            "assets/icons/filled_heart.png",
            width: iconWidth,
            height: iconHeight,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            "assets/icons/filled_heart.png",
            width: iconWidth,
            height: iconHeight,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            "assets/icons/filled_heart.png",
            width: iconWidth,
            height: iconHeight,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            "assets/icons/filled_heart.png",
            width: iconWidth,
            height: iconHeight,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            "assets/icons/empty_heart.png",
            width: iconWidth,
            height: iconHeight,
          ),
        ),
      ],
    );
  }
}
