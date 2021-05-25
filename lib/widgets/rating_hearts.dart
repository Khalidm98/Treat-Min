import 'package:flutter/material.dart';

class RatingHearts extends StatelessWidget {
  final double iconWidth;
  final double iconHeight;
  final int rating;

  RatingHearts({this.iconHeight, this.iconWidth, @required this.rating});

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry IconsPadding =
        const EdgeInsets.symmetric(vertical: 2, horizontal: 4);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: IconsPadding,
          child: Image.asset(
            rating > 0
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: IconsPadding,
          child: Image.asset(
            rating > 1
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: IconsPadding,
          child: Image.asset(
            rating > 2
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: IconsPadding,
          child: Image.asset(
            rating > 3
                ? "assets/icons/rate_filled.png"
                : "assets/icons/rate_outlined.png",
            height: iconHeight,
            width: iconWidth,
          ),
        ),
        Padding(
          padding: IconsPadding,
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
