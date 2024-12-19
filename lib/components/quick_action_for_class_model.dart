import '/flutter_flow/flutter_flow_util.dart';
import 'quick_action_for_class_widget.dart' show QuickActionForClassWidget;
import 'package:flutter/material.dart';

class QuickActionForClassModel
    extends FlutterFlowModel<QuickActionForClassWidget> {
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
