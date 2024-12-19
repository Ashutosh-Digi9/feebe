import '/flutter_flow/flutter_flow_util.dart';
import 'quick_action_widget.dart' show QuickActionWidget;
import 'package:flutter/material.dart';

class QuickActionModel extends FlutterFlowModel<QuickActionWidget> {
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
