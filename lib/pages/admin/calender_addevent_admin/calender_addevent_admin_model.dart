import '/flutter_flow/flutter_flow_util.dart';
import 'calender_addevent_admin_widget.dart' show CalenderAddeventAdminWidget;
import 'package:flutter/material.dart';

class CalenderAddeventAdminModel
    extends FlutterFlowModel<CalenderAddeventAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Title_notice widget.
  FocusNode? titleNoticeFocusNode;
  TextEditingController? titleNoticeTextController;
  String? Function(BuildContext, String?)? titleNoticeTextControllerValidator;
  // State field(s) for Description_notice widget.
  FocusNode? descriptionNoticeFocusNode;
  TextEditingController? descriptionNoticeTextController;
  String? Function(BuildContext, String?)?
      descriptionNoticeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleNoticeFocusNode?.dispose();
    titleNoticeTextController?.dispose();

    descriptionNoticeFocusNode?.dispose();
    descriptionNoticeTextController?.dispose();
  }
}
