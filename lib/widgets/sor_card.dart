import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treat_min/utils/enumerations.dart';
import './rating_hearts.dart';
import '../screens/auth_screen.dart';
import '../models/card_data.dart';
import '../models/screens_data.dart';
import '../localizations/app_localizations.dart';
import '../screens/booking_screen.dart';

const EdgeInsetsGeometry doctorCardIconsPadding = const EdgeInsets.all(2.0);
const double doctorCardIconsWidth = 12.0;
const double doctorCardIconsHeight = 12.0;

class SORCard extends StatefulWidget {
  final SORDetail sorCardData;
  final Entity entity;
  final int entityId;

  SORCard({@required this.sorCardData, this.entity, this.entityId});

  @override
  _SORCardState createState() => _SORCardState();
}

class _SORCardState extends State<SORCard> {
  checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text(t('must_log_in')),
          actions: [
            TextButton(
              child: Text(t('cancel')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(t('log_in')),
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
            cardDetail: SORDetail(
                id: widget.sorCardData.id,
                hospital: widget.sorCardData.hospital,
                price: widget.sorCardData.price,
                ratingTotal: widget.sorCardData.ratingTotal,
                ratingUsers: widget.sorCardData.ratingUsers)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setAppLocalization(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
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
                    widget.sorCardData.hospital.name,
                    style: theme.textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  width: double.infinity,
                ),
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
                          t("price"),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Text(
                          t("rating"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.sorCardData.price} ',
                            style: theme.textTheme.subtitle1,
                          ),
                          Text(
                            t("egp"),
                            style: theme.textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Center(
                        child: RatingHearts(
                          iconHeight: doctorCardIconsHeight,
                          iconWidth: doctorCardIconsWidth,
                          rating: widget.sorCardData.ratingTotal,
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
                          t('book_now'),
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
