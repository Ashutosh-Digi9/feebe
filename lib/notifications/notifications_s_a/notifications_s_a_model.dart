import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/nav_bar_s_a/nav_bar_s_a_widget.dart';
import '/index.dart';
import 'notifications_s_a_widget.dart' show NotificationsSAWidget;
import 'package:flutter/material.dart';

class NotificationsSAModel extends FlutterFlowModel<NotificationsSAWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // Model for NavBarSA component.
  late NavBarSAModel navBarSAModel;
  // Stores action output result for [Firestore Query - Query a collection] action in CircleImage widget.
  List<StudentsRecord>? students12;

  @override
  void initState(BuildContext context) {
    navBarSAModel = createModel(context, () => NavBarSAModel());
  }

  @override
  void dispose() {
    navBarSAModel.dispose();
  }
}
