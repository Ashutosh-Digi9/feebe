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

import '/flutter_flow/lat_lng.dart'; // Import FlutterFlow LatLng

Future<LatLng> convertStringToLatLng(String latLngString) async {
  // Split the string by comma
  List<String> parts = latLngString.split(',');

  // Use only the first two parts for latitude and longitude
  if (parts.length >= 2) {
    double latitude = double.tryParse(parts[0].trim()) ?? 0.0;
    double longitude = double.tryParse(parts[1].trim()) ?? 0.0;

    return LatLng(latitude, longitude); // Return FlutterFlow LatLng
  } else {
    throw FormatException(
        "Invalid format. The string must contain at least latitude and longitude.");
  }
}
