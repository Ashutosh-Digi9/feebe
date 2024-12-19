import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_teacher_admin_widget.dart' show SearchTeacherAdminWidget;
import 'package:flutter/material.dart';

class SearchTeacherAdminModel
    extends FlutterFlowModel<SearchTeacherAdminWidget> {
  ///  Local state fields for this component.

  bool search = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Teachers widget.
  FocusNode? teachersFocusNode;
  TextEditingController? teachersTextController;
  String? Function(BuildContext, String?)? teachersTextControllerValidator;
  List<TeachersRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    teachersFocusNode?.dispose();
    teachersTextController?.dispose();
  }
}
