import 'package:flutter/material.dart';

class BookNowDropDownList extends StatefulWidget {
  @override
  _BookNowDropDownListState createState() => _BookNowDropDownListState();
}

class _BookNowDropDownListState extends State<BookNowDropDownList> {
  static List<String> schedule = [
    'Sunday 18:00-22:00',
    'Monday 17:00-21:00',
    'Tuesday 12:00-15:00'
  ];
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Choose a date'),
        ),
        value: dropdownValue,
        icon: Icon(
          Icons.arrow_drop_down_sharp,
          color: theme.accentColor,
        ),
        iconSize: 40,
        elevation: 1,
        style: theme.textTheme.headline6,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: schedule.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
