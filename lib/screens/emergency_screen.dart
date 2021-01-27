import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:treat_min/widgets/translated_text.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// don't forget to edit android and ios files

class EmergencyScreen extends StatefulWidget {
  static const String routeName = '/emergency';

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  // static const String GOOGLE_API_KEY = '';

  // you may need to add '&' after 'center='
  // adjust zoom and size as suits you
  // this function returns only a snapshot of the map (I guess we won't use it)
  // String _getMapURL(double latitude, double longitude) {
  //   return 'https://maps.googleapis.com/maps/api/staticmap?'
  //       'center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'
  //       '&markers=color:blue%7Clabel:S%7C$latitude,$longitude'
  //       '&markers=color:green%7Clabel:G%7C${latitude + 1},${longitude + 1}'
  //       '&markers=color:red%7Clabel:C%7C${latitude - 1},${longitude - 1}'
  //       '&key=$GOOGLE_API_KEY';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TranslatedText(jsonKey: 'Emergency')),
      body: FutureBuilder(
        future: Location().getLocation(),
        builder: (_, location) {
          if (location.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('lat: ${(location.data as LocationData).latitude}'),
                Text('long: ${(location.data as LocationData).longitude}'),
              ],
            ),
          );
          // final double latitude = (location.data as LocationData).latitude;
          // final double longitude = (location.data as LocationData).longitude;
          // return GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(latitude, longitude),
          //     zoom: 16,
          //   ),
          //   onTap: () {},
          //   markers: {
          //     Marker(
          //       markerId: MarkerId('m1'),
          //       position: LatLng(latitude, longitude),
          //     ),
          //   },
          // );
        },
      ),
    );
  }
}
