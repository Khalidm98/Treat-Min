import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart';

import '../localizations/app_localizations.dart';
import '../utils/location.dart';
import '../utils/maps.dart';
import '../widgets/rating_hearts.dart';

class EmergencyScreen extends StatefulWidget {
  static const String routeName = '/emergency';

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final _controller = Completer<GoogleMapController>();
  LocationData _currentLocation;
  LatLng _location;
  Set<Marker> _markers = {};
  Widget _hospitalDetails = SizedBox();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      _currentLocation = await getLocation();
      if (_currentLocation == null) {
        Navigator.of(context).pop();
      } else {
        _location = LatLng(
          _currentLocation.latitude,
          _currentLocation.longitude,
        );
        _setMarkers(_location);
      }
    });
  }

  Future<void> _animate(LatLng location) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: location, zoom: 16),
    ));
    setState(() {
      _location = location;
    });
  }

  Future<void> _setMarkers(LatLng location) async {
    _markers.clear();
    final hospitals = await nearbyHospitals(location);
    hospitals.forEach((hospital) {
      _markers.add(Marker(
        markerId: MarkerId(hospital.name),
        position: LatLng(
          hospital.geometry.location.lat,
          hospital.geometry.location.lng,
        ),
        infoWindow: InfoWindow(title: hospital.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () => _setHospitalDetails(hospital),
      ));
    });
    setState(() {});
    _animate(location);
  }

  void _setHospitalDetails(PlacesSearchResult hospital) {
    setState(() {
      _hospitalDetails = Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(child: Text(hospital.name)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _hospitalDetails = SizedBox();
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(hospital.vicinity),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      hospital.rating == null
                          ? SizedBox()
                          : RatingHearts(
                              rating: (hospital.rating).round(),
                              iconHeight: 20,
                            ),
                      hospital.openingHours == null
                          ? SizedBox()
                          : Text(hospital.openingHours.openNow
                              ? t('open')
                              : t('closed')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
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
      appBar: AppBar(
        title: Text(t('emergency')),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final location = await searchPlace(context);
              if (location != null) {
                _setMarkers(location);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
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
            onTap: _animate,
            markers: _markers,
            myLocationEnabled: true,
            buildingsEnabled: false,
            tiltGesturesEnabled: false,
          ),
          _hospitalDetails
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: t('first_aid'),
        child: const Icon(Icons.healing),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
