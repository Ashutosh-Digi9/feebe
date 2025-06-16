import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'class_attendence_history_widget.dart' show ClassAttendenceHistoryWidget;
import 'package:flutter/material.dart';

class ClassAttendenceHistoryModel
    extends FlutterFlowModel<ClassAttendenceHistoryWidget> {
  ///  Local state fields for this page.

  DateTime? currentmonthandyear;

  int pageindex = 0;

  ///  State fields for stateful widgets in this page.

  DateTime? datePicked;
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
