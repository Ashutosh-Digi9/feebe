import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'search_page_s_a_widget.dart' show SearchPageSAWidget;
import 'package:flutter/material.dart';

class SearchPageSAModel extends FlutterFlowModel<SearchPageSAWidget> {
  ///  Local state fields for this page.

  int pagevariable = 0;

  bool? recentsearchboolschool = false;

  String? recentsearchitem;

  bool recentsearchadmin = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for SearchFiledSchool widget.
  FocusNode? searchFiledSchoolFocusNode;
  TextEditingController? searchFiledSchoolTextController;
  String? Function(BuildContext, String?)?
      searchFiledSchoolTextControllerValidator;
  List<SchoolRecord> simpleSearchResults = [];
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFiledSchoolFocusNode?.dispose();
    searchFiledSchoolTextController?.dispose();

    tabBarController?.dispose();
  }
}
