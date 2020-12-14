import 'dart:ui';

import 'package:flutter/material.dart';

class DoctorCard extends StatefulWidget {
  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(2.0),
          ),
          margin: EdgeInsets.fromLTRB(37, 15, 37, 0),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
            child: Text(
              "Hospital 1",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.yellow,
          ),
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: Text(
                        "Orthodontic Specialist",
                        style: TextStyle(fontSize: 13.0),
                        textAlign: TextAlign.left,
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
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          "assets/icons/filled_heart.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          "assets/icons/filled_heart.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          "assets/icons/filled_heart.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          "assets/icons/filled_heart.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          "assets/icons/empty_heart.png",
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
          margin: EdgeInsets.fromLTRB(37, 0, 37, 0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(1.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Monday"),
                          SizedBox(
                            width: 15,
                          ),
                          Text("12:00 - 05:00"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Saturday"),
                          SizedBox(
                            width: 15,
                          ),
                          Text("01:00 - 08:00"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 1, 0, 0),
                child: Column(
                  children: [
                    Text("350 EGP"),
                    SizedBox(height: 6),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: RaisedButton(
                        color: Colors.lightGreen.shade400,
                        onPressed: () {},
                        child: Text("Book Now!"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
