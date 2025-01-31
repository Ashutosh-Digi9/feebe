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

Future<bool> videoLimit(String videoUrl) async {
  // Add your function code here!
  try {
    // Send a HEAD request to get the file metadata
    final response = await http.head(Uri.parse(videoUrl));

    // Extract the content-length header to determine the file size
    if (response.headers.containsKey('content-length')) {
      final fileSizeInBytes =
          int.tryParse(response.headers['content-length'] ?? '0') ?? 0;

      // Convert the file size to MB
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      // Check if the file size is less than or equal to 40 MB
      if (fileSizeInMB <= 40) {
        return true; // File is within the limit
      }
    }
    return false; // File size exceeds the limit or content-length not found
  } catch (e) {
    // Handle errors (e.g., invalid URL, network issues)
    debugPrint('Error checking video size: $e');
    return false;
  }
}
