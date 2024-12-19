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

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<LatLng?> fetchlatlng(String address) async {
  // Add your function code here!
  final apiKey =
      'AIzaSyA3sykyw5oxGgj5b496sYl-EaihK1S9ru8'; // Replace with your API key
  final encodedAddress = Uri.encodeComponent(address);
  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == 'OK') {
        final location = jsonResponse['results'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        print('Latitude: $lat, Longitude: $lng');
        return LatLng(lat, lng);
      } else {
        throw Exception(
            'Error from Google Geocoding API: ${jsonResponse['status']}');
      }
    } else {
      throw Exception('Failed to load geocoding data');
    }
  } catch (e) {
    print('Error in convertaddresstolatlng: $e');
    return null;
  }
}
