import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbarteacher/navbarteacher_widget.dart';
import '/index.dart';
import 'notification_teacher_widget.dart' show NotificationTeacherWidget;
import 'package:flutter/material.dart';

class NotificationTeacherModel
    extends FlutterFlowModel<NotificationTeacherWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navbarteacher component.
  late NavbarteacherModel navbarteacherModel;
  // Stores action output result for [Firestore Query - Query a collection] action in CircleImage widget.
  List<StudentsRecord>? students12;

  @override
  void initState(BuildContext context) {
    navbarteacherModel = createModel(context, () => NavbarteacherModel());
  }

  @override
  void dispose() {
    navbarteacherModel.dispose();
  }
}
