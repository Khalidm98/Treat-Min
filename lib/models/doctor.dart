import './clinic.dart';

class Doctor {
  final String id;
  final String name;
  final String title;
  final String phone;
  final String photo;
  final Clinic speciality;

  Doctor({
    this.id,
    this.name,
    this.title,
    this.phone,
    this.photo,
    this.speciality,
  });
}
