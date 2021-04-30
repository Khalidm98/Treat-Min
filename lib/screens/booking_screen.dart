import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:treat_min/api/actions.dart';
import 'package:treat_min/models/reviews.dart';
import 'package:treat_min/models/screens_data.dart';
import 'package:treat_min/utils/enumerations.dart';
import './tabs_screen.dart';
import '../localizations/app_localizations.dart';
import '../models/schedule.dart';
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
  bool ddvExists = true;
  bool daysMatch = true;
  bool pickedDate = false;
  Schedule dropDownValue = Schedule(day: null, start: null, end: null);
  Future<String> schedulesResponse;
  Future<String> reviewsResponse;
  String reserveResponse;
  Reviews reviews;
  Schedules schedules;
  String scheduleId;
  DateTime appointmentDate = DateTime.now();
  static const Map<int, String> weekDays = {
    1: "MON",
    2: "TUE",
    3: "WED",
    4: "THU",
    5: "FRI",
    6: "SAT",
    7: "SUN"
  };
  void _bookFail(ThemeData theme, BuildContext context,
      BookNowScreenData bookNowScreenData) {
    setAppLocalization(context);
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
                    backgroundColor: theme.errorColor,
                    radius: 60,
                    child: Image.asset(
                      'assets/images/wrong_icon.png',
                      fit: BoxFit.fitWidth,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Text(
                      "Cannot reserve the same schedule twice in the same day!",
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

  void _bookSuccess(ThemeData theme, BuildContext context,
      BookNowScreenData bookNowScreenData) {
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
                  TabsScreen.routeName, (route) => false,
                  arguments: 2);
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: appointmentDate,
        firstDate: DateTime.now(),
        lastDate: appointmentDate.add(Duration(days: 365)));
    if (picked != null)
      setState(() {
        pickedDate = true;
        appointmentDate = picked;
      });
  }

  void updateDropDownValue(Schedule dpv) {
    dropDownValue = dpv;
    if (dropDownValue.start != null) {
      ddvExists = true;
    }
  }

  void checkToBook(String entity, String entityId, String detailId,
      ThemeData theme, BookNowScreenData receivedData) async {
    if (dropDownValue.start == null) {
      setState(() {
        ddvExists = false;
      });
    } else {
      setState(() {
        ddvExists = true;
      });
      if (dropDownValue.day != weekDays[appointmentDate.weekday]) {
        setState(() {
          daysMatch = false;
          appointmentDate = DateTime.now();
        });
      } else {
        setState(() {
          daysMatch = true;
        });
        scheduleId = dropDownValue.id.toString();
        reserveResponse = await ActionAPI.reserveAppointment(
            context,
            entity,
            entityId,
            detailId,
            scheduleId,
            appointmentDate.toString().substring(0, 10));
        if (reserveResponse == "Your appointment was reserved successfully.") {
          _bookSuccess(theme, context, receivedData);
        } else if (reserveResponse ==
            "User cannot reserve the same schedule twice in the same day!") {
          _bookFail(theme, context, receivedData);
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    dynamic receivedData = ModalRoute.of(context).settings.arguments;
    String entity = entityToString(receivedData.entity);
    String entityId = receivedData.entityId;
    String detailId = receivedData.cardDetail.id.toString();
    schedulesResponse = ActionAPI.getEntitySchedule(entity, entityId, detailId);
    reviewsResponse = ActionAPI.getEntityReviews(entity, entityId, detailId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    BookNowScreenData receivedData = ModalRoute.of(context).settings.arguments;
    String entity = entityToString(receivedData.entity);
    String entityId = receivedData.entityId;
    String detailId = receivedData.cardDetail.id.toString();

    setAppLocalization(context);

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
                    rating: (receivedData.cardDetail.ratingTotal ~/
                        receivedData.cardDetail.ratingUsers)),
                Text(
                  "Rating from  ${receivedData.cardDetail.ratingUsers == null ? 0 : receivedData.cardDetail.ratingUsers}  visitors",
                  style: theme.textTheme.headline6,
                ),
                SizedBox(height: 20),
                FutureBuilder(
                  future: schedulesResponse,
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
                    schedules = schedulesFromJson(response.data);

                    return Container(
                      child: BookNowDropDownList(
                        dropDownValueGetter: updateDropDownValue,
                        scheduleList: schedules.schedules,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: theme.accentColor),
                        ),
                      ),
                    );
                  },
                ),
                if (!ddvExists)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      getText('date_error'),
                      style:
                          theme.textTheme.subtitle2.copyWith(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 10),
                Container(
                    child: ListTile(
                      leading: Text(
                        !pickedDate
                            ? "Choose an appointment date."
                            : appointmentDate.toString().substring(0, 10),
                        style: theme.textTheme.headline6.copyWith(fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.date_range,
                        size: 30,
                        color: theme.primaryColor,
                      ),
                      onTap: () async {
                        await _selectDate(context);
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: theme.accentColor),
                      ),
                    )),
                if (!daysMatch)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Your appointment date day and schedule day must match",
                      style:
                          theme.textTheme.subtitle2.copyWith(color: Colors.red),
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
                    checkToBook(
                        entity, entityId, detailId, theme, receivedData);
                  },
                ),
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
                      title: Text(
                        getText(
                          expansionListChanger
                              ? 'hide_reviews'
                              : 'view_reviews',
                        ),
                        style: theme.textTheme.button.copyWith(fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      children: [
                        FutureBuilder(
                          future: reviewsResponse,
                          builder: (_, response) {
                            if (response.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (response.data == "Something went wrong") {}
                            if (response.hasData) {
                              reviews = reviewsFromJson(response.data);
                              return reviews.reviews.length != 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: reviews.reviews.length,
                                      itemBuilder: (_, index) {
                                        return ReviewBox(
                                            reviews.reviews[index]);
                                      })
                                  : Card(
                                      margin: EdgeInsets.all(0),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        trailing: Icon(
                                          Icons.rate_review,
                                          color: theme.accentColor,
                                        ),
                                        title: Text(
                                          'There are no current reviews.',
                                          style: theme.textTheme.subtitle2
                                              .copyWith(
                                                  fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    );
                            }
                            return Center(
                              child: Text(
                                response.data,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headline6
                                    .copyWith(color: theme.errorColor),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
