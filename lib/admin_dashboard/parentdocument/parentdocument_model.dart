import '/flutter_flow/flutter_flow_util.dart';
import 'parentdocument_widget.dart' show ParentdocumentWidget;
import 'package:flutter/material.dart';

class ParentdocumentModel extends FlutterFlowModel<ParentdocumentWidget> {
  ///  Local state fields for this component.

  bool uploaded = false;

  String? url;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataYpr = false;
  FFUploadedFile uploadedLocalFile_uploadDataYpr =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataYpr = '';

  bool isDataUploading_uploadData30r = false;
  FFUploadedFile uploadedLocalFile_uploadData30r =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData30r = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
