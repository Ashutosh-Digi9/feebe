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

class BackButtonOverrider extends StatefulWidget {
  const BackButtonOverrider({
    super.key,
    this.width,
    this.height,
    required this.onBack,
  });

  final double? width;
  final double? height;
  final Future Function() onBack;

  @override
  State<BackButtonOverrider> createState() => _BackButtonOverriderState();
}

class _BackButtonOverriderState extends State<BackButtonOverrider> {
  bool _isBackHandled = false;

  Future<void> _handleBack() async {
    if (_isBackHandled) return;
    _isBackHandled = true;
    await widget.onBack.call();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (popAllowed) async {
        await _handleBack();
      },
      child: Scaffold(),
    );
  }
}
