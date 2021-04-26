import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treat_min/api/actions.dart';
import 'package:treat_min/models/screens_data.dart';
import 'package:treat_min/utils/enumerations.dart';
import './tabs_screen.dart';
import '../localizations/app_localizations.dart';
import '../models/schedule.dart';
import '../providers/provider_class.dart';
import '../widgets/book_now_dropdown_list.dart';
import '../widgets/review_box.dart';
import '../widgets/rating_hearts.dart';

class BookNowScreen extends StatefulWidget {
  static const String routeName = '/booknow';

  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  bool expansionListChanger = false;
  bool ableToBook = true;
  Schedule dropDownValue = Schedule(day: null, start: null, end: null);
  Future<String> response;

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
  void didChangeDependencies() {
    dynamic receivedData = ModalRoute.of(context).settings.arguments;
    response = ActionAPI.getEntitySchedule(entityToString(receivedData.entity),
        receivedData.entityId, receivedData.cardDetail.id.toString());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    BookNowScreenData receivedData = ModalRoute.of(context).settings.arguments;
    setAppLocalization(context);
    void updateDropDownValue(Schedule dpv) {
      dropDownValue = dpv;
      if (dropDownValue.start != null) {
        ableToBook = true;
      }
    }

    void checkToBook() {
      if (dropDownValue.start == null) {
        setState(() {
          ableToBook = false;
        });
      } else {
        ableToBook = true;
        // if (receivedData.entity) {
        //   ReservedSchedule scheduleModel = ReservedSchedule(
        //       id: DateTime.now().toIso8601String(),
        //       hospitalName: receivedData.card.detail,
        //       isCurrentRes: true,
        //       name: receivedData.card.name,
        //       schedule: dropDownValue,
        //       doctorSpecialty: receivedData.card.title,
        //       isClinic: receivedData.entity);
        //   Provider.of<ProviderClass>(context).addReservation(
        //       scheduleModel, Provider.of<ProviderClass>(context).reservations);
        // } else {
        //   ReservedSchedule scheduleModel = ReservedSchedule(
        //       id: DateTime.now().toIso8601String(),
        //       hospitalName: receivedData.card.hospitalName,
        //       isCurrentRes: true,
        //       name: receivedData.card.name,
        //       schedule: dropDownValue,
        //       isClinic: receivedData.entity);
        //   Provider.of<ProviderClass>(context).addReservation(
        //       scheduleModel, Provider.of<ProviderClass>(context).reservations);
        // }
        // }
        _bookSuccess(theme, context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(getText('book_now'))),
      body: ListView(
        padding: EdgeInsets.all(20),
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
                    receivedData.entity == Entity.clinic
                        ? receivedData.cardDetail.doctor.name
                        : receivedData.cardDetail.hospital,
                    style: theme.textTheme.headline4,
                  ),
                ),
                if (receivedData.entity == Entity.clinic)
                  FittedBox(
                    child: Text(
                      receivedData.cardDetail.doctor.title,
                      style: theme.textTheme.headline5
                          .copyWith(fontWeight: FontWeight.w500),
                      textScaleFactor: 0.9,
                    ),
                  ),
                RatingHearts(
                    iconHeight: 30,
                    iconWidth: 30,
                    rating: receivedData.cardDetail.ratingTotal),
                Text(
                  "Rating from ${receivedData.cardDetail.ratingUsers == null ? 0 : receivedData.cardDetail.ratingUsers} visitors",
                  style: theme.textTheme.headline6,
                ),
                SizedBox(height: 20),
                FutureBuilder(
                  future: response,
                  builder: (_, response) {
                    if (response.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (response.data == "Something went wrong") {
                      return Center(
                        child: Text(
                          response.data,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6
                              .copyWith(color: theme.errorColor),
                        ),
                      );
                    }
                    Schedules schedules = schedulesFromJson(response.data);
                    return Container(
                        child: BookNowDropDownList(
                          dropDownValueGetter: updateDropDownValue,
                          scheduleList: schedules.schedules,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.accentColor),
                        ));
                  },
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
