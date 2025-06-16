import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'total_student_listss_widget.dart' show TotalStudentListssWidget;
import 'package:flutter/material.dart';

class TotalStudentListssModel
    extends FlutterFlowModel<TotalStudentListssWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool selectall = false;

  bool dontdisplay = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in totalStudentListss widget.
  SchoolClassRecord? schoolclassDocument;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
