import 'dart:convert';

ClinicCardData clinicCardFromJson(String str) =>
    ClinicCardData.fromJson(json.decode(str));

SORCardData sorCardFromJson(String str) =>
    SORCardData.fromJson(json.decode(str));

class ClinicCardData {
  ClinicCardData({
    this.entity,
    this.details,
  });

  String entity;
  List<ClinicDetail> details;

  factory ClinicCardData.fromJson(Map<String, dynamic> json) => ClinicCardData(
        entity: json["entity"],
        details: List<ClinicDetail>.from(
            json["details"].map((x) => ClinicDetail.fromJson(x))),
      );
}

class SORCardData {
  SORCardData({
    this.entity,
    this.details,
  });

  String entity;
  List<SORDetail> details;

  factory SORCardData.fromJson(Map<String, dynamic> json) => SORCardData(
        entity: json["entity"],
        details: List<SORDetail>.from(
            json["details"].map((x) => SORDetail.fromJson(x))),
      );
}

class ClinicDetail {
  ClinicDetail({
    this.id,
    this.hospital,
    this.price,
    this.ratingTotal,
    this.ratingUsers,
    this.doctor,
  });

  int id;
  String hospital;
  int price;
  int ratingTotal;
  int ratingUsers;
  Doctor doctor;

  factory ClinicDetail.fromJson(Map<String, dynamic> json) => ClinicDetail(
        id: json["id"],
        hospital: json["hospital"],
        price: json["price"],
        ratingTotal: json["rating_total"],
        ratingUsers: json["rating_users"],
        doctor: Doctor.fromJson(json["doctor"]),
      );
}

class SORDetail {
  SORDetail({
    this.id,
    this.hospital,
    this.price,
    this.ratingTotal,
    this.ratingUsers,
  });

  int id;
  String hospital;
  int price;
  int ratingTotal;
  int ratingUsers;

  factory SORDetail.fromJson(Map<String, dynamic> json) => SORDetail(
        id: json["id"],
        hospital: json["hospital"],
        price: json["price"],
        ratingTotal: json["rating_total"],
        ratingUsers: json["rating_users"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospital": hospital,
        "price": price,
        "rating_total": ratingTotal,
        "rating_users": ratingUsers,
      };
}

class Doctor {
  Doctor({
    this.id,
    this.name,
    this.title,
  });
  int id;
  String name;
  String title;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        title: json["title"],
      );
}
