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

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';

Future generateClassAttendancePdf(
  String className,
  DateTime filterdate,
  List<ClassAttendanceStruct> attendanceRecord,
) async {
  // Add your function code here!
  List<ClassAttendanceStruct> filteredRecords =
      attendanceRecord.where((attendance) {
    if (attendance.date == null) return false;
    return attendance.date!.month == filterdate.month &&
        attendance.date!.year == filterdate.year;
  }).toList();

  // Create a PDF document
  final PdfDocument document = PdfDocument();

  // Add a page to the document
  final PdfPage page = document.pages.add();

  // Define the standard font
  final PdfFont standardFont = PdfStandardFont(PdfFontFamily.helvetica, 14);

  // Draw a header section with a background color
  page.graphics.drawRectangle(
    brush: PdfSolidBrush(PdfColor(91, 126, 215)),
    bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, 90),
  );

  // Draw the title
  page.graphics.drawString(
    'Class Attendance Record',
    PdfStandardFont(PdfFontFamily.helvetica, 36),
    brush: PdfBrushes.white,
    bounds: Rect.fromLTWH(0, 15, page.getClientSize().width, 90),
    format: PdfStringFormat(
      lineAlignment: PdfVerticalAlignment.middle,
      alignment: PdfTextAlignment.left,
    ),
  );

  // Add class details
  page.graphics.drawString(
    'Class: $className\nMonth: ${DateFormat.yMMMM().format(filterdate)}',
    standardFont,
    bounds: Rect.fromLTWH(0, 120, page.getClientSize().width, 100),
  );

  // Create a PDF grid with columns for Date, Present, Absent, Total Students
  PdfGrid grid = PdfGrid();
  grid.columns.add(count: 4);

  // Add headers to the grid
  PdfGridRow header = grid.headers.add(1)[0];
  header.cells[0].value = 'Date';
  header.cells[1].value = 'Present';
  header.cells[2].value = 'Absent';
  header.cells[3].value = 'Total Students';

  // Style the header
  header.style.backgroundBrush = PdfSolidBrush(PdfColor(0, 0, 255));
  header.style.textBrush = PdfBrushes.white;
  header.style.font =
      PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold);

  // Add filtered attendance details to the grid
  for (final attendance in filteredRecords) {
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = attendance.date != null
        ? DateFormat('yyyy-MM-dd').format(attendance.date!)
        : "N/A";
    row.cells[1].value = attendance.totalPresent.toString();
    row.cells[2].value = attendance.totalAbsent?.toString() ?? "N/A";
    row.cells[3].value = attendance.totalStudents?.toString() ?? "N/A";
  }

  // Draw the grid on the PDF page
  grid.draw(
    page: page,
    bounds: Rect.fromLTWH(
        0, 200, page.getClientSize().width, page.getClientSize().height - 200),
  );

  // Save the document as bytes
  List<int> bytes = await document.save();

  // Save the PDF to device storage
  Directory? directory = await getExternalStorageDirectory();
  String path = directory!.path;
  File file = File('$path/Class_Attendance_Record.pdf');
  await file.writeAsBytes(bytes, flush: true);

  // Open the saved PDF
  OpenFile.open(file.path);

  // Dispose of the document
  document.dispose();
}
