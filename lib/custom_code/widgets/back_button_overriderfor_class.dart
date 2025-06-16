// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:fluttertoast/fluttertoast.dart'; // Add this for toast
import 'package:flutter/services.dart'; // For SystemNavigator.pop()

class BackButtonOverriderforClass extends StatefulWidget {
  const BackButtonOverriderforClass({
    super.key,
    this.width,
    this.height,
    required this.onBack,
    this.pageIndex,
  });

  final double? width;
  final double? height;
  final Future Function() onBack;
  final int? pageIndex;

  @override
  State<BackButtonOverriderforClass> createState() =>
      _BackButtonOverriderforClassState();
}

class _BackButtonOverriderforClassState
    extends State<BackButtonOverriderforClass> {
  DateTime? _lastBackPressed;

  Future<void> _handleBack() async {
    if (widget.pageIndex == 0) {
      final now = DateTime.now();
      if (_lastBackPressed == null ||
          now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
        _lastBackPressed = now;
        Fluttertoast.showToast(msg: 'Press back again to exit');
      } else {
        SystemNavigator.pop(); // Exit the app
      }
    } else {
      await widget.onBack.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (popAllowed) async {
        await _handleBack();
      },
      child: Scaffold(), // Replace this with your actual widget tree
    );
  }
}
