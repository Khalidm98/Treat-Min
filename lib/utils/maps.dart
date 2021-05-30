import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import './google_api_key.dart';
import '../localizations/app_localizations.dart';

Future<LatLng> searchPlace(BuildContext context) async {
  final place = await PlacesAutocomplete.show(
    context: context,
    apiKey: GOOGLE_API_KEY,
    mode: Mode.overlay,
    language: Localizations.localeOf(context).languageCode,
    logo: const SizedBox(),
    region: 'eg',
    hint: t('find_hospitals'),
  );
  if (place == null) {
    return null;
  }

  final places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);
  final details = await places.getDetailsByPlaceId(place.placeId);
  places.dispose();
  return LatLng(
    details.result.geometry.location.lat,
    details.result.geometry.location.lng,
  );
}

Future<List<PlacesSearchResult>> nearbyHospitals(LatLng location) async {
  final places = GoogleMapsPlaces(apiKey: GOOGLE_API_KEY);
  final response = await places.searchNearbyWithRadius(
    Location(location.latitude, location.longitude),
    800,
    type: 'hospital',
  );
  places.dispose();
  return response.results;
}
