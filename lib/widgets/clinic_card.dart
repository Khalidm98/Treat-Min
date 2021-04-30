import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat_min/models/screens_data.dart';
import 'package:treat_min/utils/enumerations.dart';
import './rating_hearts.dart';
import '../screens/auth_screen.dart';
import '../models/card_data.dart';
import '../localizations/app_localizations.dart';
import '../screens/booking_screen.dart';

const EdgeInsetsGeometry doctorCardIconsPadding = const EdgeInsets.all(2.0);
const double doctorCardIconsWidth = 12.0;
const double doctorCardIconsHeight = 12.0;

class ClinicCard extends StatefulWidget {
  final ClinicDetail clinicCardData;
  final Entity entity;
  final int entityId;
  ClinicCard({@required this.clinicCardData, this.entity, this.entityId});

  @override
  _ClinicCardState createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard> {
  checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text(getText('must_log_in')),
          actions: [
            TextButton(
              child: Text(getText('cancel')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(getText('log_in')),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AuthScreen.routeName,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      );
    } else {
      Navigator.pushNamed(
        context,
        BookNowScreen.routeName,
        arguments: BookNowScreenData(
            entityId: widget.entityId.toString(),
            entity: widget.entity,
            cardDetail: ClinicDetail(
                doctor: widget.clinicCardData.doctor,
                id: widget.clinicCardData.id,
                hospital: widget.clinicCardData.hospital,
                price: widget.clinicCardData.price,
                ratingTotal: widget.clinicCardData.ratingTotal,
                ratingUsers: widget.clinicCardData.ratingUsers)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setAppLocalization(context);

    print(widget.clinicCardData.ratingTotal);
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
              widget.clinicCardData.hospital,
              style: theme.textTheme.headline6.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(color: theme.primaryColorLight),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    widget.clinicCardData.doctor.name,
                    style: theme.textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  width: double.infinity,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.clinicCardData.doctor.title,
                    style: theme.textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
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
                Container(
                  color: theme.primaryColor,
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Text(
                          "Rating",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${widget.clinicCardData.price} EGP',
                        style: theme.textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Center(
                        child: RatingHearts(
                          iconHeight: doctorCardIconsHeight,
                          iconWidth: doctorCardIconsWidth,
                          rating: (widget.clinicCardData.ratingTotal ~/
                              widget.clinicCardData.ratingUsers),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
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
                          getText('book_now'),
                          textScaleFactor: 0.7,
                          style: theme.textTheme.headline5
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      onPressed: checkLoggedIn,
                    ),
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
