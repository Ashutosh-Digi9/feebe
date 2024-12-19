import '/flutter_flow/flutter_flow_util.dart';
import 'quick_action_teacher_widget.dart' show QuickActionTeacherWidget;
import 'package:flutter/material.dart';

class QuickActionTeacherModel
    extends FlutterFlowModel<QuickActionTeacherWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
