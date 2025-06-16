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

// DO NOT REMOVE OR MODIFY THE CODE ABOVE!import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWithPen extends StatefulWidget {
  const CalendarWithPen({
    super.key,
    this.width,
    this.height,
    required this.allowpastdates,
    this.allowfuturedates = true,
  });
  final double? width;
  final double? height;

  final bool allowpastdates;
  final bool? allowfuturedates;

  @override
  State<CalendarWithPen> createState() => _CalendarWithPenState();
}

class _CalendarWithPenState extends State<CalendarWithPen> {
  @override
  void initState() {
    super.initState();

    // Open the calendar picker after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openDatePicker(context);
    });
  }

  Future<void> _openDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final DateTime firstDate = widget.allowpastdates ? DateTime(1900) : now;
    final DateTime lastDate =
        widget.allowfuturedates == false ? now : DateTime(2100);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('en', 'GB'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Update the global app state or pass value to parent
      FFAppState().selectedDate = picked;
    }

    // Close the dialog/component automatically
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // Invisible, only triggers the picker
  }
}
