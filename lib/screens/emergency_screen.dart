import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../localizations/app_localizations.dart';
import '../utils/location.dart';

class EmergencyScreen extends StatefulWidget {
  static const String routeName = '/emergency';

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData _currentLocation;
  LatLng _location;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      _currentLocation = await getLocation();
      if (_currentLocation == null) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _location = LatLng(
            _currentLocation.latitude,
            _currentLocation.longitude,
          );
        });
      }
    });
  }

  Future<void> _animate(LatLng latLng) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latLng, zoom: 16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    setAppLocalization(context);

    if (_location == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t('emergency'))),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(t('emergency'))),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _location, zoom: 16),
        minMaxZoomPreference: const MinMaxZoomPreference(10, 18),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            northeast: const LatLng(32, 36),
            southwest: const LatLng(22, 25),
          ),
        ),
        tiltGesturesEnabled: false,
        onTap: _animate,
        // markers: {
        //   Marker(
        //     markerId: MarkerId('m1'),
        //     position: LatLng(latitude, longitude),
        //   ),
        // },
      ),
    );
  }
}
