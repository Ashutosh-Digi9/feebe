// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geocoding/geocoding.dart';

// Custom action to fetch LatLng from an address
Future<LatLng> fetchLatLngFromAddress(
  String? locality,
  String? city,
  String? state,
  String? pincode,
  String? country,
) async {
  try {
    // Construct the full address from the parameters
    String fullAddress = '';

    if (locality != null) fullAddress += '$locality, ';
    if (city != null) fullAddress += '$city, ';
    if (state != null) fullAddress += '$state, ';
    if (country != null) fullAddress += '$country, ';
    if (pincode != null) fullAddress += '$pincode';

    // Remove trailing comma and space
    fullAddress = fullAddress.trim().replaceAll(RegExp(r',\s*$'), '');

    // Use the geocoding package to get the coordinates
    List<Location> locations = await locationFromAddress(fullAddress);

    if (locations.isNotEmpty) {
      // Return the first location found
      return LatLng(locations[0].latitude, locations[0].longitude);
    } else {
      // Return a default LatLng in case of no result
      return LatLng(0.0, 0.0); // Default to coordinates 0, 0
    }
  } catch (e) {
    print("Error fetching latitude and longitude: $e");
    // Return a default LatLng in case of an error
    return LatLng(0.0, 0.0); // Default to coordinates 0, 0
  }
}
