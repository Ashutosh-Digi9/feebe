import '/flutter_flow/flutter_flow_util.dart';
import 'attendence_parent_widget.dart' show AttendenceParentWidget;
import 'package:flutter/material.dart';

class AttendenceParentModel extends FlutterFlowModel<AttendenceParentWidget> {
  ///  Local state fields for this page.

  DateTime? monthYear;

  int pageindex = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
