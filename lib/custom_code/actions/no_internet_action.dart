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

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

Future noInternetAction() async {
  bool isToastVisible = false;
  Timer? toastTimer;

  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      // Start showing persistent toast if there's no internet
      if (!isToastVisible) {
        isToastVisible = true;
        toastTimer = Timer.periodic(Duration(seconds: 3), (timer) {
          Fluttertoast.showToast(
            msg: "No internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
          );
        });
      }
    } else {
      // Stop the toast when internet is restored
      if (isToastVisible) {
        isToastVisible = false;
        toastTimer?.cancel();
        Fluttertoast.cancel(); // Ensures that any active toast is dismissed
      }
    }
  });
}
