import 'package:flutter/material.dart';

class Patient {
  final String id;
  final String name;
  final String phone;
  final String photo;
  final DateTime birth;

  Patient({
    @required this.id,
    @required this.name,
    @required this.phone,
    this.photo,
    @required this.birth,
  });
}
