// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui' as ui; // Import for path metrics and Tangent

class DottedLine extends StatefulWidget {
  const DottedLine({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<DottedLine> createState() => _DottedLineState();
}

class _DottedLineWithCurvePainter extends CustomPainter {
  final Color color = Color(0xFF9C27B0); // Set to #9C27B0 color
  final double dashWidth = 6.0;
  final double dashSpacing = 4.0;
  final double curveStartYOffset =
      100.0; // Adjust to position curve in the middle

  @override
  void paint(Canvas canvas, Size size) {
    // Ensure the same paint object is used for consistent stroke width
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.0 // Set consistent stroke width
      ..strokeCap = StrokeCap.round;

    // Draw the initial vertical dashed line up to the curve start point
    double startY = 0;
    while (startY < curveStartYOffset) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpacing;
    }

    // Draw the rounded corner
    ui.Path path = ui.Path();
    path.moveTo(0, curveStartYOffset);
    path.quadraticBezierTo(
        0, curveStartYOffset + 20, 20, curveStartYOffset + 20);

    // Draw dashes along the curved path
    for (ui.PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        ui.Tangent? tangent = pathMetric.getTangentForOffset(distance);
        if (tangent != null) {
          Offset start = tangent.position;
          Offset end = tangent.position +
              Offset(
                dashWidth * tangent.vector.dx,
                dashWidth * tangent.vector.dy,
              );
          canvas.drawLine(start, end, paint);
        }
        distance += dashWidth + dashSpacing;
      }
    }

    // Draw the horizontal dashed line after the rounded corner
    double startX = 20; // Start after the corner
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, curveStartYOffset + 20),
        Offset(startX + dashWidth, curveStartYOffset + 20),
        paint,
      );
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _DottedLineState extends State<DottedLine> {
  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? 2.0; // Default width for the line
    double height = widget.height ?? double.infinity; // Default height

    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _DottedLineWithCurvePainter(),
      ),
    );
  }
}
