import 'package:flutter/cupertino.dart';

class ClinicSchedule {
  final String day;
  final String time;
  ClinicSchedule({@required this.day, @required this.time});

  String toString() {
    String dateAndTime = '$day' + '  ' + '$time';
    return dateAndTime;
  }
}
