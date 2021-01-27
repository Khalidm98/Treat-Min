import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treat_min/widgets/translated_text.dart';
import '../providers/provider_class.dart';
import '../models/reserved_schedule.dart';

class CurrentReservationCard extends StatelessWidget {
  final ReservedSchedule sched;
  CurrentReservationCard(this.sched);

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
                    Provider.of<ProviderClass>(context)
                        .removeReservation(sched.id);
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
                sched.hospitalName,
                style: theme.textTheme.headline5.copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Text(
                sched.doctorName,
                style: theme.textTheme.headline6
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                sched.doctorSpecialty,
                style: theme.textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(
                    jsonKey: sched.schedule.day,
                  ),
                  Text(
                    sched.schedule.time,
                  ),
                  SizedBox(
                    height: 30,
                    width: 85,
                    child: OutlinedButton(
                      onPressed: () {
                        confirmReservationCancellation(context);
                      },
                      child: TranslatedText(jsonKey: 'Cancel', maxLines: 1),
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
