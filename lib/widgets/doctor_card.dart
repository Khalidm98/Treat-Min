import 'dart:ui';

import 'package:flutter/material.dart';

const String doctorCardFontFamily = 'Montserrat';
const Color doctorCardFontColor = Color(0xff335f7e);
const EdgeInsetsGeometry doctorCardIconsPadding = const EdgeInsets.all(2.0);
const double doctorCardIconsWidth = 12.0;
const double doctorCardIconsHeight = 12.0;

class DoctorCard extends StatefulWidget {
  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff56c596),
              borderRadius: BorderRadius.circular(2.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 7),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
              child: Text(
                "Hospital 1",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: doctorCardFontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white,
                border: Border.all(color: Color(0xffe0f0ee))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          10,
                          0,
                          0,
                        ),
                        child: Text(
                          "Dr.Ahmed Khaled",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: doctorCardFontColor,
                            fontFamily: doctorCardFontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Text(
                          "ORTHODONTIC SPECIALIST",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: doctorCardFontColor,
                            fontFamily: doctorCardFontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: doctorCardIconsPadding,
                          child: Image.asset(
                            "assets/icons/rate_filled.png",
                            width: doctorCardIconsWidth,
                            height: doctorCardIconsHeight,
                          ),
                        ),
                        Padding(
                          padding: doctorCardIconsPadding,
                          child: Image.asset(
                            "assets/icons/rate_filled.png",
                            width: doctorCardIconsWidth,
                            height: doctorCardIconsHeight,
                          ),
                        ),
                        Padding(
                          padding: doctorCardIconsPadding,
                          child: Image.asset(
                            "assets/icons/rate_filled.png",
                            width: doctorCardIconsWidth,
                            height: doctorCardIconsHeight,
                          ),
                        ),
                        Padding(
                          padding: doctorCardIconsPadding,
                          child: Image.asset(
                            "assets/icons/rate_filled.png",
                            width: doctorCardIconsWidth,
                            height: doctorCardIconsHeight,
                          ),
                        ),
                        Padding(
                          padding: doctorCardIconsPadding,
                          child: Image.asset(
                            "assets/icons/rate_outlined.png",
                            width: doctorCardIconsWidth,
                            height: doctorCardIconsHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffdfefef).withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(0, 20), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Monday",
                              style: TextStyle(
                                color: doctorCardFontColor,
                                fontFamily: doctorCardFontFamily,
                              ),
                            ),
                            Text("12:00 - 05:00",
                                style: TextStyle(
                                  color: doctorCardFontColor,
                                  fontFamily: doctorCardFontFamily,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Saturday",
                                style: TextStyle(
                                  color: doctorCardFontColor,
                                  fontFamily: doctorCardFontFamily,
                                )),
                            Text("01:00 - 08:00",
                                style: TextStyle(
                                  color: doctorCardFontColor,
                                  fontFamily: doctorCardFontFamily,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Column(
                    children: [
                      Text(
                        "350 EGP",
                        style: TextStyle(
                          color: doctorCardFontColor,
                          fontFamily: doctorCardFontFamily,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        height: 23,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Color(0xff61c556),
                          onPressed: () {},
                          child: Text(
                            "Book Now!",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: doctorCardFontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
