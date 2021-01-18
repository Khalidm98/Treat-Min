import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './rating_hearts.dart';
import '../models/clinic_schedule.dart';
import '../screens/booknow_screen.dart';

const EdgeInsetsGeometry doctorCardIconsPadding = const EdgeInsets.all(2.0);
const double doctorCardIconsWidth = 12.0;
const double doctorCardIconsHeight = 12.0;

class DoctorCard extends StatefulWidget {
  final String hospitalName;
  final String doctorName;
  final String doctorSpecialty;
  final int rating;
  final List<ClinicSchedule> schedule;
  final double examinationFee;
  final double hospitalDistance;

  DoctorCard(
      {@required this.hospitalName,
      @required this.doctorName,
      @required this.doctorSpecialty,
      @required this.schedule,
      @required this.examinationFee,
      this.rating = 0,
      @required this.hospitalDistance});

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
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
              widget.hospitalName,
              style: theme.textTheme.headline6.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(color: theme.primaryColorLight),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctorName,
                          style: theme.textTheme.headline5,
                        ),
                        Text(
                          widget.doctorSpecialty,
                          style: theme.textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                RatingHearts(
                  iconHeight: doctorCardIconsHeight,
                  iconWidth: doctorCardIconsWidth,
                  rating: widget.rating,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Colors.white,
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
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: widget.schedule.length,
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              widget.schedule[index].day,
                              style: theme.textTheme.subtitle2
                                  .copyWith(fontWeight: FontWeight.w700),
                              textScaleFactor: 0.8,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              widget.schedule[index].time,
                              style: theme.textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              textScaleFactor: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(10, 10, 15, 10),
                  child: Column(
                    children: [
                      Text(
                        '${widget.examinationFee} EGP',
                        style: theme.textTheme.subtitle1,
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 100,
                        height: 25,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor,
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(5),
                            ),
                          ),
                          child: FittedBox(
                            child: Text(
                              "Book Now",
                              style: theme.textTheme.headline5
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            if (!prefs.containsKey('userData')) {
                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text(
                                    'You must log in to book an appointment',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                BookNowScreen.routeName,
                                arguments: DoctorCard(
                                  hospitalName: widget.hospitalName,
                                  doctorName: widget.doctorName,
                                  doctorSpecialty: widget.doctorSpecialty,
                                  schedule: widget.schedule,
                                  examinationFee: widget.examinationFee,
                                  hospitalDistance: widget.hospitalDistance,
                                  rating: widget.rating,
                                ),
                              );
                            }
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
