import 'package:flutter/material.dart';
import 'package:treat_min/widgets/translated_text.dart';
import 'rating_hearts.dart';

class ReviewBox extends StatefulWidget {
  @override
  _ReviewBoxState createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<ReviewBox> {
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
                      'Ahmed Khaled Sayed',
                      style: theme.textTheme.subtitle1
                          .copyWith(fontWeight: FontWeight.w700),
                      textScaleFactor: 0.9,
                    ),
                    TranslatedText(
                      jsonKey: 'Months ago',
                      style: theme.textTheme.subtitle2
                          .copyWith(color: Colors.grey),
                      textScaleFactor: 0.7,
                    ),
                    RatingHearts(rating: 4, iconWidth: 10, iconHeight: 10),
                  ],
                ),
              ),
            ],
          ),
          Card(
            color: theme.primaryColorLight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'The doctor is very helpful he helped me alot, he is highly recommended if you want a better treatment.',
                style: theme.textTheme.subtitle2.copyWith(color: Colors.white),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.thumb_up_alt,
                    color: theme.accentColor,
                  ),
                  onPressed: () {}),
              Text('0'),
              IconButton(
                  icon: Icon(
                    Icons.thumb_down_alt,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
              Text('0'),
            ],
          ),
        ],
      ),
    );
  }
}
