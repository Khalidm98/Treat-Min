import 'dart:convert';
import 'schedule.dart';

Reservations reservationsFromJson(String str) =>
    Reservations.fromJson(json.decode(str));

class Reservations {
  Reservations({
    this.current,
    this.past,
  });

  CurrentOrPast current;
  CurrentOrPast past;

  factory Reservations.fromJson(Map<String, dynamic> json) => Reservations(
        current: CurrentOrPast.fromJson(json["current"]),
        past: CurrentOrPast.fromJson(json["past"]),
      );
}

class CurrentOrPast {
  CurrentOrPast({
    this.clinics,
    this.rooms,
    this.services,
  });

  List<ReservedEntityDetails> clinics;
  List<ReservedEntityDetails> rooms;
  List<ReservedEntityDetails> services;

  factory CurrentOrPast.fromJson(Map<String, dynamic> json) => CurrentOrPast(
        clinics: List<ReservedEntityDetails>.from(
            json["clinics"].map((x) => ReservedEntityDetails.fromJson(x))),
        rooms: List<ReservedEntityDetails>.from(
            json["rooms"].map((x) => ReservedEntityDetails.fromJson(x))),
        services: List<ReservedEntityDetails>.from(
            json["services"].map((x) => ReservedEntityDetails.fromJson(x))),
      );
}

class ReservedEntityDetails {
  ReservedEntityDetails({
    this.id,
    this.room,
    this.hospital,
    this.price,
    this.schedule,
    this.status,
    this.appointmentDate,
    this.service,
    this.doctor,
    this.clinic,
  });

  int id;
  String room;
  String hospital;
  int price;
  Schedule schedule;
  String status;
  String appointmentDate;
  String service;
  String doctor;
  String clinic;

  factory ReservedEntityDetails.fromJson(Map<String, dynamic> json) =>
      ReservedEntityDetails(
        id: json["id"],
        room: json["room"] == null ? null : json["room"],
        hospital: json["hospital"],
        price: json["price"],
        schedule: Schedule.fromJson(json["schedule"]),
        status: json["status"],
        appointmentDate: json["appointment_date"],
        service: json["service"] == null ? null : json["service"],
        doctor: json["doctor"] == null ? null : json["doctor"],
        clinic: json["clinic"] == null ? null : json["clinic"],
      );
}
