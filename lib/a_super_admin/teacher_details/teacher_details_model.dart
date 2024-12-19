import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'teacher_details_widget.dart' show TeacherDetailsWidget;
import 'package:flutter/material.dart';

class TeacherDetailsModel extends FlutterFlowModel<TeacherDetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (deleteUser)] action in Icon widget.
  ApiCallResponse? apiResult41a;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<SchoolClassRecord>? classes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
