import 'package:flutter/material.dart';
import '../models/clinic_schedule.dart';

class BookNowDropDownList extends StatefulWidget {
  final List<ClinicSchedule> scheduleList;
  final Function(ClinicSchedule) dropDownValueGetter;
  BookNowDropDownList({this.scheduleList, this.dropDownValueGetter});
  @override
  _BookNowDropDownListState createState() =>
      _BookNowDropDownListState(scheduleList, dropDownValueGetter);
}

class _BookNowDropDownListState extends State<BookNowDropDownList> {
  Function dropDownValueGetter;
  List<ClinicSchedule> scheduleList;
  ClinicSchedule dropDownValue;
  _BookNowDropDownListState(this.scheduleList, this.dropDownValueGetter);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Choose a date'),
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
        items: scheduleList.map<DropdownMenuItem>((ClinicSchedule schedule) {
          return DropdownMenuItem(
            value: schedule,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FittedBox(
                child: Text(
                  schedule.toString(),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
