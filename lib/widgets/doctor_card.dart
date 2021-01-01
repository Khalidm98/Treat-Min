import 'dart:ui';
import 'rating_hearts.dart';
import 'package:flutter/material.dart';
import 'package:treat_min/widgets/booknow_dropdown_list.dart';

const EdgeInsetsGeometry doctorCardIconsPadding = const EdgeInsets.all(2.0);
const double doctorCardIconsWidth = 12.0;
const double doctorCardIconsHeight = 12.0;

class DoctorCard extends StatefulWidget {
  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  void _selectBookingDetails(ThemeData theme) {
    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.symmetric(horizontal: 22),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 13,
                    backgroundColor: theme.accentColor,
                    child: CircleAvatar(
                      child: Image.asset(
                        'assets/icons/tooth.png',

                        // fit: BoxFit.scaleDown,
                      ),
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height / 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Dr.Ahmed Khaled",
                      style: theme.textTheme.headline5,
                      //textScaleFactor: 1.7,
                    ),
                  ),
                  Text(
                    "ORTHODONTIC SPECIALIST",
                    style: theme.textTheme.subtitle2,
                  ),
                  RatingHearts(iconWidth: 30, iconHeight: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "Rating from 22 visitors",
                      style: theme.textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    child: BookNowDropDownList(),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF205072),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: (MediaQuery.of(context).size.width) / 1.15,
                    child: RaisedButton(
                      child: Text('Book Now'),
                      color: theme.accentColor,
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (_) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    insetPadding: EdgeInsets.all(0),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        /*    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  radius: 65,
                                                                  child:*/
                                        CircleAvatar(
                                          backgroundColor: theme.accentColor,
                                          radius: 60,
                                          child: Image.asset(
                                            'assets/images/correct_icon.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        // ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 20),
                                            child: Text(
                                                'Your Appointment Has Been Reserved Successfully! ',
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.headline5
                                                    .copyWith(
                                                        color: Colors.white))),
                                      ],
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFF205072),
                    width: 6,
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: theme.primaryColor),
            padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
            margin: EdgeInsets.symmetric(horizontal: 7),
            width: double.infinity,
            child: Text(
              "Dar Elfouad",
              style: theme.textTheme.headline6.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(color: theme.primaryColorLight),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr.Ahmed Khaled",
                      style: theme.textTheme.headline5,
                    ),
                    Text(
                      "ORTHODONTIC SPECIALIST",
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                ),
                RatingHearts(
                  iconHeight: doctorCardIconsHeight,
                  iconWidth: doctorCardIconsWidth,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: theme.primaryColorLight),
                right: BorderSide(color: theme.primaryColorLight),
                bottom: BorderSide(color: theme.primaryColorLight),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColorLight.withOpacity(0.1),
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
                            Text("Monday"),
                            Text("12:00 - 05:00"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Saturday"),
                            Text("01:00 - 08:00"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Column(
                    children: [
                      Text(
                        "350 EGP",
                        style: theme.textTheme.subtitle1,
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        height: 25,
                        child: RaisedButton(
                          color: theme.primaryColor,
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              "Book Now",
                              style: theme.textTheme.headline5
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _selectBookingDetails(theme);
                          },
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
