import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reviews.dart';
import 'package:treat_min/widgets/translated_text.dart';
import '../providers/provider_class.dart';
import '../models/reserved_schedule.dart';
import 'clickable_rating_hearts.dart';

class CurrentReservationCard extends StatefulWidget {
  final int currentOrHistory; //Current = 1 , History = 0
  final ReservedSchedule sched;
  CurrentReservationCard(this.sched, this.currentOrHistory);

  @override
  _CurrentReservationCardState createState() => _CurrentReservationCardState();
}

class _CurrentReservationCardState extends State<CurrentReservationCard> {
  int ratingVal = 0;
  bool rated = false;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void confirmReservationCancellation(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: TranslatedText(
                jsonKey:
                    'Are you sure that you want to cancel this reservation?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Provider.of<ProviderClass>(context).removeReservation(
                        widget.sched.id,
                        Provider.of<ProviderClass>(context).reservations);
                    Navigator.pop(context);
                  },
                  child: TranslatedText(jsonKey: 'Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: TranslatedText(jsonKey: 'No'))
            ],
          );
        });
  }

  ratingButton(ThemeData theme, onPressed(), String buttonText) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: theme.primaryColor),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          theme.primaryColor.withOpacity(0.2),
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          theme.primaryColor.withOpacity(0.4),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(theme.primaryColor),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: TranslatedText(jsonKey: buttonText, maxLines: 1),
    );
  }

  void updateRatingValue(int ratingValue) {
    ratingVal = ratingValue;
  }

  void rateBox(BuildContext context, ThemeData theme) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                side: BorderSide(width: 4.0, color: theme.primaryColor),
              ),
              title: Center(
                  child: TranslatedText(jsonKey: 'Rate Your Appointment')),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                ClickableRatingHearts(
                    iconHeight: 40,
                    iconWidth: 40,
                    ratingGetter: updateRatingValue),
                TextField(
                  controller: myController,
                  keyboardType: TextInputType.multiline,
                  minLines: 4, //Normal textInputField will be displayed
                  maxLines: 5, // when user presses enter it will adapt to it
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ratingButton(theme, () {
                      Reviews review = Reviews(DateTime.now().toIso8601String(),
                          'Username', myController.text, ratingVal);
                      Provider.of<ProviderClass>(context).addReview(review);
                      rated = true;
                      Navigator.pop(context);
                    }, "Submit Review"),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: TranslatedText(jsonKey: 'Cancel', maxLines: 1),
                    )
                  ],
                )
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
              child: Text(
                widget.sched.hospitalName,
                style: theme.textTheme.headline5.copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Text(
                widget.sched.doctorName,
                style: theme.textTheme.headline6
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.sched.doctorSpecialty,
                style: theme.textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(
                    jsonKey: widget.sched.schedule.day,
                  ),
                  Text(
                    widget.sched.schedule.time,
                  ),
                  //currentOrHistory here is = 1 but for now set to 0 for debugging
                  widget.currentOrHistory == 1
                      ? SizedBox(
                          height: 30,
                          width: 85,
                          child: OutlinedButton(
                            onPressed: () {
                              confirmReservationCancellation(context);
                            },
                            child:
                                TranslatedText(jsonKey: 'Cancel', maxLines: 1),
                          ),
                        )
                      : SizedBox(
                          height: 30,
                          width: rated ? 115 : 85,
                          child: ratingButton(
                              theme,
                              () => rateBox(context, theme),
                              rated ? "Edit Rating" : "Rate"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
