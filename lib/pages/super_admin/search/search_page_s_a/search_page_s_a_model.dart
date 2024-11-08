import '/flutter_flow/flutter_flow_util.dart';
import '/pages/super_admin/search/nosearchresults/nosearchresults_widget.dart';
import 'search_page_s_a_widget.dart' show SearchPageSAWidget;
import 'package:flutter/material.dart';

class SearchPageSAModel extends FlutterFlowModel<SearchPageSAWidget> {
  ///  Local state fields for this page.

  int? pagevariable = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for nosearchresults component.
  late NosearchresultsModel nosearchresultsModel;

  @override
  void initState(BuildContext context) {
    nosearchresultsModel = createModel(context, () => NosearchresultsModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    nosearchresultsModel.dispose();
  }
}
