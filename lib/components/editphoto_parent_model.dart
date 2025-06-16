import '/flutter_flow/flutter_flow_util.dart';
import 'editphoto_parent_widget.dart' show EditphotoParentWidget;
import 'package:flutter/material.dart';

class EditphotoParentModel extends FlutterFlowModel<EditphotoParentWidget> {
  ///  Local state fields for this component.

  bool uploaded = false;

  String? url;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataPtt = false;
  FFUploadedFile uploadedLocalFile_uploadDataPtt =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataPtt = '';

  bool isDataUploading_uploadDataDy7 = false;
  FFUploadedFile uploadedLocalFile_uploadDataDy7 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataDy7 = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
