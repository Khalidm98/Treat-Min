import 'package:flutter/material.dart';
import '../models/clinic_schedule.dart';
import '../widgets/booknow_dropdown_list.dart';
import 'package:provider/provider.dart';
import '../providers/provider_class.dart';
import '../models/reserved_schedule.dart';
import '../widgets/doctor_card.dart';
import '../widgets/rating_hearts.dart';
import '../widgets/review_box.dart';
import 'dart:ui';

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
    showDialog(
      context: context,
      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
    DoctorCard receivedDoctorCard = ModalRoute.of(context).settings.arguments;

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
        ReservedSchedule scheduleModel = ReservedSchedule(
            DateTime.now().toIso8601String(),
            receivedDoctorCard.doctorName,
            receivedDoctorCard.doctorSpecialty,
            dropDownValue,
            receivedDoctorCard.hospitalName);
        Provider.of<ProviderClass>(context).addReservation(scheduleModel);
        _bookSuccess(theme, context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Book Now')),
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
                      child: Image.asset('assets/icons/tooth.png'),
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height / 14,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    receivedDoctorCard.doctorName,
                    style: theme.textTheme.headline4,
                  ),
                ),
                FittedBox(
                  child: Text(
                    receivedDoctorCard.doctorSpecialty,
                    style: theme.textTheme.headline5
                        .copyWith(fontWeight: FontWeight.w500),
                    textScaleFactor: 0.9,
                  ),
                ),
                RatingHearts(
                    iconHeight: 30,
                    iconWidth: 30,
                    rating: receivedDoctorCard.rating),
                Text(
                  "Rating from 5 visitors",
                  style: theme.textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  child: BookNowDropDownList(
                    dropDownValueGetter: updateDropDownValue,
                    scheduleList: receivedDoctorCard.schedule,
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
                    checkToBook();
                  },
                ),
                if (!ableToBook) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('Please choose an appointment date.',
                        style: theme.textTheme.subtitle2
                            .copyWith(color: Colors.red)),
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
                      title: !expansionListChanger
                          ? Text('View patients reviews')
                          : Text('Hide patients reviews'),
                      leading: Icon(
                        Icons.stars_rounded,
                        color: theme.accentColor,
                      ),
                      children: [
                        ReviewBox(),
                        ReviewBox(),
                        ReviewBox(),
                        ReviewBox(),
                        ReviewBox(),
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
