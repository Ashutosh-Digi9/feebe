import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'selectedstudents_sadmin_widget.dart' show SelectedstudentsSadminWidget;
import 'package:flutter/material.dart';

class SelectedstudentsSadminModel
    extends FlutterFlowModel<SelectedstudentsSadminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool selectall = false;

  bool dontdisplay = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in selectedstudents_sadmin widget.
  SchoolClassRecord? schoolclassDocument;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
