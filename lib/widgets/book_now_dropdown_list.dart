import 'package:flutter/material.dart';

import '../localizations/app_localizations.dart';
import '../models/schedule.dart';

class BookNowDropDownList extends StatefulWidget {
  final List<Schedule> scheduleList;
  final Function(Schedule) dropDownValueGetter;
  BookNowDropDownList({this.scheduleList, this.dropDownValueGetter});
  @override
  _BookNowDropDownListState createState() =>
      _BookNowDropDownListState(scheduleList, dropDownValueGetter);
}

class _BookNowDropDownListState extends State<BookNowDropDownList> {
  Function dropDownValueGetter;
  List<Schedule> scheduleList;
  Schedule dropDownValue;
  _BookNowDropDownListState(this.scheduleList, this.dropDownValueGetter);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    setAppLocalization(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(getText('choose_date')),
        ),
        value: dropDownValue,
        icon: Icon(
          Icons.arrow_drop_down_sharp,
          color: theme.accentColor,
        ),
        iconSize: 40,
        elevation: 1,
        style: theme.textTheme.headline6,
        onChanged: (newValue) {
          dropDownValueGetter(newValue);
          setState(() {
            dropDownValue = newValue;
          });
        },
        items: scheduleList.map<DropdownMenuItem>((Schedule schedule) {
          return DropdownMenuItem(
            value: schedule,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                    "${schedule.day} - ( From ${schedule.start.substring(0, 5)} to ${schedule.end.substring(0, 5)} ) "),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
