import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_teacher_widget.dart' show DeleteTeacherWidget;
import 'package:flutter/material.dart';

class DeleteTeacherModel extends FlutterFlowModel<DeleteTeacherWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolRecord? school;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<SchoolClassRecord>? classes;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolClassRecord? indviclass;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
