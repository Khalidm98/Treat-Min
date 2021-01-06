import 'package:flutter/foundation.dart';
import './speciality.dart';

class Doctor {
  final String id;
  final String name;
  final String title;
  final String phone;
  final String photo;
  final Speciality speciality;

  Doctor({
    this.id,
    @required this.name,
    this.title,
    this.phone,
    this.photo,
    @required this.speciality,
  });
}
