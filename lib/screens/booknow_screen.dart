import 'package:flutter/material.dart';
import 'package:treat_min/widgets/rating_hearts.dart';
import 'package:treat_min/widgets/booknow_dropdown_list.dart';
import 'package:treat_min/widgets/app_raised_button.dart';
import 'dart:ui';

class BookNowScreen extends StatefulWidget {
  static const routeName = '/available';
  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Booking")),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Image.asset('assets/icons/tooth_filled.png'),
              width: (MediaQuery.of(context).size.width) / 3,
              height: (MediaQuery.of(context).size.height) / 5,
              decoration: BoxDecoration(
                color: Color(0xFF205072),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Dr.Ahmed Khaled",
              style: TextStyle(
                fontSize: 30.0,
                color: Color(0xFF205072),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "ORTHODONTIC SPECIALIST",
            style: TextStyle(
              fontSize: 15.0,
              color: Color(0xFF205072),
              fontFamily: 'Montserrat',
            ),
          ),
          RatingHearts(iconWidth: 30, iconHeight: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text(
              "Rating from 22 visitors",
              style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFF205072),
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Container(
            child: BookNowDropDownList(),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF205072),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            width: (MediaQuery.of(context).size.width) / 1.15,
            child: AppRaisedButton(
              borderRad: 100,
              label: 'Book Now',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
