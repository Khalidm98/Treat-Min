import 'package:flutter/cupertino.dart';
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
  final int entityId;
  final int entityDetailId;
  final int appointmentId;
  final VoidCallback onCancel;

  ReservationCard(
      {this.reservedEntityDetails,
      this.isCurrentRes,
      this.onCancel,
      this.entity,
      this.entityId,
      this.entityDetailId,
      this.appointmentId});

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
                    await ActionAPI.cancelAppointment(context,
                        entityToString(widget.entity), widget.appointmentId);
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
                    onPressed: () async {
                      await ActionAPI.rateAppointment(
                          context,
                          entityToString(widget.entity),
                          widget.entityId.toString(),
                          widget.entityDetailId.toString(),
                          ratingVal.toString(),
                          myController.text);
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
      margin: EdgeInsets.only(bottom: 15),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: RotatedBox(
                child: Text(
                  widget.reservedEntityDetails.status == "W"
                      ? "Waiting"
                      : widget.reservedEntityDetails.status == "R"
                          ? "Rejected"
                          : "Accepted",
                  style: theme.textTheme.button.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                quarterTurns: 3,
              ),
              decoration: BoxDecoration(
                color: widget.reservedEntityDetails.status == "W"
                    ? Colors.grey[500]
                    : widget.reservedEntityDetails.status == "R"
                        ? Colors.red
                        : theme.primaryColorLight,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.accentColor,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(4)),
                    ),
                    child: Text(
                      widget.reservedEntityDetails.hospital,
                      style: theme.textTheme.headline5
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.reservedEntityDetails.clinic != null)
                              Text(
                                widget.reservedEntityDetails.doctor,
                                style: theme.textTheme.headline5
                                    .copyWith(fontSize: 18),
                              ),
                            Text(
                              widget.reservedEntityDetails.clinic != null
                                  ? widget.reservedEntityDetails.clinic
                                  : widget.reservedEntityDetails.service != null
                                      ? widget.reservedEntityDetails.service
                                      : widget.reservedEntityDetails.room,
                              style: widget.reservedEntityDetails.clinic != null
                                  ? theme.textTheme.button
                                  : theme.textTheme.headline5
                                      .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        widget.isCurrentRes
                            ? SizedBox(
                                height: 50,
                                width: 85,
                                child: OutlinedButton(
                                  onPressed: () {
                                    confirmReservationCancellation(context);
                                  },
                                  child: Text(getText('cancel'), maxLines: 1),
                                ),
                              )
                            : SizedBox(
                                height: 50,
                                width: 85,
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(color: theme.primaryColor),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      theme.primaryColor.withOpacity(0.2),
                                    ),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                      theme.primaryColor.withOpacity(0.4),
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            theme.primaryColor),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
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
                              )
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //   right: BorderSide(color: theme.accentColor, width: 2),
                    // )),
                  ),
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                              ),
                              Text(
                                widget.reservedEntityDetails.appointmentDate,
                                style: theme.textTheme.headline6.copyWith(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.access_time_outlined,
                                  color: theme.primaryColorLight,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "${widget.reservedEntityDetails.schedule.start.substring(0, 5)} to ${widget.reservedEntityDetails.schedule.end.substring(0, 5)}",
                                style: theme.textTheme.headline6.copyWith(
                                    fontSize: 14, color: Colors.white),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.lightGreen,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "${widget.reservedEntityDetails.price} EGP",
                                style: theme.textTheme.headline6.copyWith(
                                    fontSize: 14, color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.accentColor,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(4)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
