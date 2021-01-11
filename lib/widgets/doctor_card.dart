import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './booknow_dropdown_list.dart';
import './rating_hearts.dart';
import '../models/clinic_schedule.dart';
import '../models/reserved_schedule.dart';
import '../providers/provider_class.dart';

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

  DoctorCard({
    @required this.hospitalName,
    @required this.doctorName,
    @required this.doctorSpecialty,
    @required this.schedule,
    @required this.examinationFee,
    this.rating = 0,
  });

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  void _selectBookingDetails(ThemeData theme, BuildContext context) {
    ClinicSchedule dropDownValue;
    void updateDropDownValue(ClinicSchedule dpv) {
      dropDownValue = dpv;
    }

    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor, width: 5),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 13,
                    backgroundColor: theme.accentColor,
                    child: CircleAvatar(
                      child: Image.asset('assets/icons/tooth.png'),
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height / 14,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      widget.doctorName,
                      style: theme.textTheme.headline5,
                    ),
                  ),
                  Text(
                    widget.doctorSpecialty,
                    style: theme.textTheme.subtitle2,
                  ),
                  RatingHearts(
                      iconHeight: 30, iconWidth: 30, rating: widget.rating),
                  Text(
                    "Rating from 22 visitors",
                    style: theme.textTheme.bodyText2,
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: BookNowDropDownList(
                      dropDownValueGetter: updateDropDownValue,
                      scheduleList: widget.schedule,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.accentColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Book Now'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        theme.accentColor,
                      ),
                    ),
                    onPressed: () {
                      print(dropDownValue);
                      ReservedSchedule scheduleModel = ReservedSchedule(
                          DateTime.now().toIso8601String(),
                          widget.doctorName,
                          widget.doctorSpecialty,
                          dropDownValue);
                      Provider.of<ProviderClass>(context)
                          .addReservation(scheduleModel);
                      Navigator.pop(context);
                      _bookSuccess(theme, context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _bookSuccess(ThemeData theme, BuildContext context) {
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
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: theme.primaryColor,
                    radius: 60,
                    child: Image.asset(
                      'assets/images/correct_icon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Text(
                      'Your Appointment Has Been Reserved Successfully!',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
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
                          onPressed: () {
                            _selectBookingDetails(theme, context);
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
