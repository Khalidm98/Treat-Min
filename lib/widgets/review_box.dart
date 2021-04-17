import 'package:flutter/material.dart';
import 'package:treat_min/widgets/translated_text.dart';
import '../models/reviews.dart';
import 'rating_hearts.dart';

class ReviewBox extends StatefulWidget {
  final Reviews review;
  int likes;
  int dislikes;

  ReviewBox(this.review, this.likes, this.dislikes);
  @override
  _ReviewBoxState createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<ReviewBox> {
  int likeFlag = 2; // 0 = liked / 1 = disliked / 2 = none
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: theme.primaryColor),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColorLight.withOpacity(0.5),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Image.asset('assets/images/placeholder.png'),
                radius: 20,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.username,
                      style: theme.textTheme.subtitle1
                          .copyWith(fontWeight: FontWeight.w700),
                      textScaleFactor: 0.9,
                    ),
                    TranslatedText(
                      //needs to be updated
                      jsonKey: 'Months ago',
                      style: theme.textTheme.subtitle2
                          .copyWith(color: Colors.grey),
                      textScaleFactor: 0.7,
                    ),
                    RatingHearts(
                        rating: widget.review.rating,
                        iconWidth: 10,
                        iconHeight: 10),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Card(
              color: theme.primaryColorLight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.review.reviewText,
                  style:
                      theme.textTheme.subtitle2.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    likeFlag == 2 || likeFlag == 1
                        ? Icons.thumb_up_alt_outlined
                        : Icons.thumb_up_alt,
                    color: theme.accentColor,
                  ),
                  onPressed: () {
                    if (likeFlag == 2) {
                      setState(() {
                        widget.likes += 1;
                      });
                      likeFlag = 0;
                    } else if (likeFlag == 0) {
                      setState(() {
                        widget.likes -= 1;
                      });
                      likeFlag = 2;
                    } else {
                      setState(() {
                        widget.likes += 1;
                        widget.dislikes -= 1;
                      });
                      likeFlag = 0;
                    }
                  }),
              Text("${widget.likes}"),
              IconButton(
                  icon: Icon(
                    likeFlag == 2 || likeFlag == 0
                        ? Icons.thumb_down_alt_outlined
                        : Icons.thumb_down_alt,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    if (likeFlag == 2) {
                      setState(() {
                        widget.dislikes += 1;
                      });
                      likeFlag = 1;
                    } else if (likeFlag == 1) {
                      setState(() {
                        widget.dislikes -= 1;
                      });
                      likeFlag = 2;
                    } else {
                      setState(() {
                        widget.likes -= 1;
                        widget.dislikes += 1;
                      });
                      likeFlag = 1;
                    }
                  }),
              Text("${widget.dislikes}"),
            ],
          ),
        ],
      ),
    );
  }
}
