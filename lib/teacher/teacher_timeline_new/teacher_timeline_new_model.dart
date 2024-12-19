import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'teacher_timeline_new_widget.dart' show TeacherTimelineNewWidget;
import 'package:flutter/material.dart';

class TeacherTimelineNewModel
    extends FlutterFlowModel<TeacherTimelineNewWidget> {
  ///  Local state fields for this page.

  DateTime? updatedDate;

  ///  State fields for stateful widgets in this page.

  // Model for Empty component.
  late EmptyModel emptyModel;

  @override
  void initState(BuildContext context) {
    emptyModel = createModel(context, () => EmptyModel());
  }

  @override
  void dispose() {
    emptyModel.dispose();
  }
}
