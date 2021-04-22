import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/screens_data.dart';
import './tabs_screen.dart';
import '../localizations/app_localizations.dart';
import '../models/clinic_schedule.dart';
import '../models/reserved_schedule.dart';
import '../providers/provider_class.dart';
import '../widgets/booknow_dropdown_list.dart';
import '../widgets/rating_hearts.dart';
import '../widgets/review_box.dart';

class BookNowScreen extends StatefulWidget {
  static const String routeName = '/booknow';

  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  bool expansionListChanger = false;
  bool ableToBook = true;
  ClinicSchedule dropDownValue = ClinicSchedule(day: null, time: null);

  void _bookSuccess(ThemeData theme, BuildContext context) {
    setAppLocalization(context);
    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                TabsScreen.routeName,
                (route) => false,
                arguments: 2,
              );
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
                      getText('reserved_successfully'),
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
    BookNowScreenData receivedData = ModalRoute.of(context).settings.arguments;
    setAppLocalization(context);

    void updateDropDownValue(ClinicSchedule dpv) {
      setState(() {
        dropDownValue = dpv;
        if (dropDownValue.time != null) {
          ableToBook = true;
        }
      });
    }

    void checkToBook() {
      if (dropDownValue.time == null) {
        setState(() {
          ableToBook = false;
        });
      } else {
        ableToBook = true;
        if (receivedData.entity) {
          ReservedSchedule scheduleModel = ReservedSchedule(
              id: DateTime.now().toIso8601String(),
              hospitalName: receivedData.card.hospitalName,
              isCurrentRes: true,
              name: receivedData.card.name,
              schedule: dropDownValue,
              doctorSpecialty: receivedData.card.title,
              isClinic: receivedData.entity);
          Provider.of<ProviderClass>(context).addReservation(
              scheduleModel, Provider.of<ProviderClass>(context).reservations);
        } else {
          ReservedSchedule scheduleModel = ReservedSchedule(
              id: DateTime.now().toIso8601String(),
              hospitalName: receivedData.card.hospitalName,
              isCurrentRes: true,
              name: receivedData.card.name,
              schedule: dropDownValue,
              isClinic: receivedData.entity);
          Provider.of<ProviderClass>(context).addReservation(
              scheduleModel, Provider.of<ProviderClass>(context).reservations);
        }
        _bookSuccess(theme, context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(getText('book_now'))),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 13,
                    backgroundColor: theme.accentColor,
                    child: CircleAvatar(
                      child: Image.asset('assets/icons/default.png'),
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height / 14,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    receivedData.card.name,
                    style: theme.textTheme.headline4,
                  ),
                ),
                if (receivedData.entity)
                  FittedBox(
                    child: Text(
                      receivedData.card.title,
                      style: theme.textTheme.headline5
                          .copyWith(fontWeight: FontWeight.w500),
                      textScaleFactor: 0.9,
                    ),
                  ),
                RatingHearts(
                    iconHeight: 30,
                    iconWidth: 30,
                    rating: receivedData.card.rating),
                Text(
                  "Rating from 5 visitors",
                  style: theme.textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  child: BookNowDropDownList(
                    dropDownValueGetter: updateDropDownValue,
                    scheduleList: [
                      ClinicSchedule(
                          day: 'Wednesday', time: '9:00 PM - 12:00 PM'),
                      ClinicSchedule(
                          day: 'Monday', time: '12:00 PM - 14:00 PM'),
                      ClinicSchedule(day: 'Friday', time: '11:00 PM - 12:00 PM')
                    ],
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.accentColor),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(getText('book_now')),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      theme.accentColor,
                    ),
                  ),
                  onPressed: () {
                    checkToBook();
                  },
                ),
                if (!ableToBook) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      getText('date_error'),
                      style:
                          theme.textTheme.subtitle2.copyWith(color: Colors.red),
                    ),
                  )
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: !expansionListChanger
                          ? theme.primaryColorLight
                          : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryColorLight
                              .withOpacity(!expansionListChanger ? 0.5 : 0),
                          blurRadius: !expansionListChanger ? 3 : 0,
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      onExpansionChanged: (bool) {
                        setState(() {
                          expansionListChanger = bool;
                        });
                      },
                      title: Text(getText(
                        expansionListChanger ? 'hide_reviews' : 'view_reviews',
                      )),
                      leading: Icon(
                        Icons.stars_rounded,
                        color: theme.accentColor,
                      ),
                      children: [
                        Provider.of<ProviderClass>(context).reviews.length != 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: Provider.of<ProviderClass>(context)
                                    .reviews
                                    .length,
                                itemBuilder: (context, i) => ReviewBox(
                                    Provider.of<ProviderClass>(context)
                                        .reviews[i]),
                              )
                            : Card(
                                margin: EdgeInsets.all(0),
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  trailing: Icon(
                                    Icons.rate_review,
                                    color: theme.accentColor,
                                  ),
                                  title: Text(
                                    'There are no current reviews.',
                                    style: theme.textTheme.subtitle2
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
