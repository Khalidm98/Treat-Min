import 'package:flutter/material.dart';
import 'doctor_card.dart';

class RatingHearts extends StatelessWidget {
  final double iconWidth;
  final double iconHeight;
  final int rating;

  RatingHearts({this.iconHeight, this.iconWidth, @required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            rating > 0
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            rating > 1
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            rating > 2
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            rating > 3
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: doctorCardIconsPadding,
          child: Image.asset(
            rating > 4
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
      ],
    );
  }
}
