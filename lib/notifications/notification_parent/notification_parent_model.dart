import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbar_parent/navbar_parent_widget.dart';
import '/index.dart';
import 'notification_parent_widget.dart' show NotificationParentWidget;
import 'package:flutter/material.dart';

class NotificationParentModel
    extends FlutterFlowModel<NotificationParentWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // Model for navbar_parent component.
  late NavbarParentModel navbarParentModel;
  // Stores action output result for [Firestore Query - Query a collection] action in CircleImage widget.
  List<StudentsRecord>? students12;

  @override
  void initState(BuildContext context) {
    navbarParentModel = createModel(context, () => NavbarParentModel());
  }

  @override
  void dispose() {
    navbarParentModel.dispose();
  }
}
