import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'search_page_admin_widget.dart' show SearchPageAdminWidget;
import 'package:flutter/material.dart';

class SearchPageAdminModel extends FlutterFlowModel<SearchPageAdminWidget> {
  ///  Local state fields for this page.

  int pagevariable = 0;

  bool? recentsearchbool = false;

  String? recentsearchitem;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TrySearchingforStudent widget.
  FocusNode? trySearchingforStudentFocusNode;
  TextEditingController? trySearchingforStudentTextController;
  String? Function(BuildContext, String?)?
      trySearchingforStudentTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in TrySearchingforStudent widget.
  List<StudentsRecord>? studnets;
  List<StudentsRecord> simpleSearchResults = [];
  // Stores action output result for [Backend Call - Read Document] action in Text widget.
  StudentsRecord? studentsrecent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    trySearchingforStudentFocusNode?.dispose();
    trySearchingforStudentTextController?.dispose();
  }
}
