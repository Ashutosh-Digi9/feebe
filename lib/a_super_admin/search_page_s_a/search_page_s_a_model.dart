import '/flutter_flow/flutter_flow_util.dart';
import 'search_page_s_a_widget.dart' show SearchPageSAWidget;
import 'package:flutter/material.dart';

class SearchPageSAModel extends FlutterFlowModel<SearchPageSAWidget> {
  ///  Local state fields for this page.

  int pagevariable = 0;

  bool? recentsearchboolschool = false;

  String? recentsearchitem;

  bool recentsearchadmin = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for SearchFiledSchool widget.
  FocusNode? searchFiledSchoolFocusNode;
  TextEditingController? searchFiledSchoolTextController;
  String? Function(BuildContext, String?)?
      searchFiledSchoolTextControllerValidator;
  List<String> simpleSearchResults1 = [];
  // State field(s) for SerachFiledPrinci widget.
  FocusNode? serachFiledPrinciFocusNode;
  TextEditingController? serachFiledPrinciTextController;
  String? Function(BuildContext, String?)?
      serachFiledPrinciTextControllerValidator;
  List<String> simpleSearchResults2 = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    searchFiledSchoolFocusNode?.dispose();
    searchFiledSchoolTextController?.dispose();

    serachFiledPrinciFocusNode?.dispose();
    serachFiledPrinciTextController?.dispose();
  }
}
