// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Schedules schedulesFromJson(String str) => Schedules.fromJson(json.decode(str));

String schedulesToJson(Schedules data) => json.encode(data.toJson());

class Schedules {
  Schedules({
    this.schedules,
  });

  List<Schedule> schedules;

  factory Schedules.fromJson(Map<String, dynamic> json) => Schedules(
        schedules: List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
      };
}

class Schedule {
  Schedule({
    this.id,
    this.day,
    this.start,
    this.end,
  });

  int id;
  String day;
  String start;
  String end;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        day: json["day"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "start": start,
        "end": end,
      };
}

// class ClinicSchedule {
//   final String day;
//   final String time;
//   ClinicSchedule({@required this.day, @required this.time});
//
//   String toString() {
//     String dateAndTime = '$day' + '  ' + '$time';
//     return dateAndTime;
//   }
// }
