import 'package:flutter/material.dart';
import 'package:treat_min/utils/enumerations.dart';
import '../localizations/app_localizations.dart';
import '../models/reservations.dart';
import '../api/actions.dart';
import 'clickable_rating_hearts.dart';

class ReservationCard extends StatefulWidget {
  final ReservedEntityDetails reservedEntityDetails;
  final bool isCurrentRes;
  final Entity entity;
  final int id;
  final VoidCallback onCancel;

  ReservationCard(
      {this.reservedEntityDetails,
      this.isCurrentRes,
      this.onCancel,
      this.entity,
      this.id});

  @override
  _ReservationCardState createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  final myController = TextEditingController();
  int ratingVal = 1;
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
            title: Text(getText('cancel_message')),
            actions: [
              TextButton(
                  onPressed: () async {
                    await ActionAPI.cancelAppointment(
                        context, entityToString(widget.entity), widget.id);
                    widget.onCancel();
                    Navigator.pop(context);
                  },
                  child: Text(getText('yes'))),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(getText('no')),
              )
            ],
          );
        });
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
            title: Text(getText('Rate Your Appointment'),
                textAlign: TextAlign.center),
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
                  OutlinedButton(
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
                      foregroundColor:
                          MaterialStateProperty.all<Color>(theme.primaryColor),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      //todo:get rate api data?
                      // ActionAPI.rateAppointment(
                      //     context,
                      //     entityToString(widget.entity),
                      //     entityId,
                      //     entityDetailId,
                      //     rating,
                      //     review);
                      Navigator.pop(context);
                    },
                    child: Text(getText('Submit Review'), maxLines: 1),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(getText('cancel'), maxLines: 1),
                  )
                ],
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setAppLocalization(context);

    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
              child: Text(
                widget.reservedEntityDetails.hospital,
                style: theme.textTheme.headline5.copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              child: Text(
                widget.reservedEntityDetails.clinic != null
                    ? widget.reservedEntityDetails.clinic
                    : widget.reservedEntityDetails.service != null
                        ? widget.reservedEntityDetails.service
                        : widget.reservedEntityDetails.room,
                style: theme.textTheme.headline6
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Price : ${widget.reservedEntityDetails.price}",
                style: theme.textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.reservedEntityDetails.appointmentDate),
                      Text(
                          "${widget.reservedEntityDetails.schedule.start.substring(0, 5)} - ${widget.reservedEntityDetails.schedule.end.substring(0, 5)}")
                    ],
                  ),
                  widget.isCurrentRes
                      ? SizedBox(
                          height: 30,
                          width: 85,
                          child: OutlinedButton(
                            onPressed: () {
                              confirmReservationCancellation(context);
                            },
                            child: Text(getText('cancel'), maxLines: 1),
                          ),
                        )
                      : SizedBox(
                          height: 30,
                          width: 105,
                          child: OutlinedButton(
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
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  theme.primaryColor),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            onPressed: () {
                              rateBox(context, theme);
                            },
                            child: Text(getText('rate'), maxLines: 1),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
