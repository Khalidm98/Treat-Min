import 'package:flutter/foundation.dart';

class Hospital {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Hospital({
    this.id,
    @required this.name,
    this.address,
    this.latitude,
    this.longitude,
  });
}
