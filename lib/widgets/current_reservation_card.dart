import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider_class.dart';
import '../models/reserved_schedule.dart';

class CurrentReservationCard extends StatelessWidget {
  final ReservedSchedule sched;
  CurrentReservationCard(this.sched);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sched.doctorName,
              style: theme.textTheme.headline6
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              sched.doctorSpecialty,
              style: theme.textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sched.schedule.day),
                Text(sched.schedule.time),
                SizedBox(
                  height: 30,
                  width: 85,
                  child: OutlinedButton(
                    onPressed: () {
                      Provider.of<ProviderClass>(context)
                          .removeReservation(sched.id);
                    },
                    child: Text('Cancel', maxLines: 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
