import 'package:flutter/material.dart';

class ClickableRatingHearts extends StatefulWidget {
  final double iconWidth;
  final double iconHeight;
  final Function(int) ratingGetter;

  static const EdgeInsetsGeometry IconsPadding = const EdgeInsets.all(2.0);

  ClickableRatingHearts({this.iconHeight, this.iconWidth, this.ratingGetter});

  @override
  _ClickableRatingHeartsState createState() => _ClickableRatingHeartsState();
}

class _ClickableRatingHeartsState extends State<ClickableRatingHearts> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: ClickableRatingHearts.IconsPadding,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (rating == 1) {
                  rating = 0;
                } else {
                  rating = 1;
                }
                widget.ratingGetter(rating);
              });
            },
            child: Image.asset(
              rating > 0
                  ? "assets/icons/rate_filled.png"
                  : "assets/icons/rate_outlined.png",
              height: widget.iconHeight,
              width: widget.iconWidth,
            ),
          ),
        ),
        Padding(
          padding: ClickableRatingHearts.IconsPadding,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (rating == 2) {
                  rating = 0;
                } else {
                  rating = 2;
                }
                widget.ratingGetter(rating);
              });
            },
            child: Image.asset(
              rating > 1
                  ? "assets/icons/rate_filled.png"
                  : "assets/icons/rate_outlined.png",
              height: widget.iconHeight,
              width: widget.iconWidth,
            ),
          ),
        ),
        Padding(
          padding: ClickableRatingHearts.IconsPadding,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (rating == 3) {
                  rating = 0;
                } else {
                  rating = 3;
                }
                widget.ratingGetter(rating);
              });
            },
            child: Image.asset(
              rating > 2
                  ? "assets/icons/rate_filled.png"
                  : "assets/icons/rate_outlined.png",
              height: widget.iconHeight,
              width: widget.iconWidth,
            ),
          ),
        ),
        Padding(
          padding: ClickableRatingHearts.IconsPadding,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (rating == 4) {
                  rating = 0;
                } else {
                  rating = 4;
                }
                widget.ratingGetter(rating);
              });
            },
            child: Image.asset(
              rating > 3
                  ? "assets/icons/rate_filled.png"
                  : "assets/icons/rate_outlined.png",
              height: widget.iconHeight,
              width: widget.iconWidth,
            ),
          ),
        ),
        Padding(
          padding: ClickableRatingHearts.IconsPadding,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (rating == 5) {
                  rating = 0;
                } else {
                  rating = 5;
                }
                widget.ratingGetter(rating);
              });
            },
            child: Image.asset(
              rating > 4
                  ? "assets/icons/rate_filled.png"
                  : "assets/icons/rate_outlined.png",
              height: widget.iconHeight,
              width: widget.iconWidth,
            ),
          ),
        ),
      ],
    );
  }
}
