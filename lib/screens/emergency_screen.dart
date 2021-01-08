import 'package:flutter/material.dart';
import 'package:location/location.dart';

class EmergencyScreen extends StatefulWidget {
  static const String routeName = '/emergency';

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency')),
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
        },
      ),
    );
  }
}
