import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'images_act_widget.dart' show ImagesActWidget;
import 'package:flutter/material.dart';

class ImagesActModel extends FlutterFlowModel<ImagesActWidget> {
  ///  Local state fields for this component.

  bool uploaded = false;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  List<FFUploadedFile> uploadedLocalFiles2 = [];
  List<String> uploadedFileUrls2 = [];

  // Stores action output result for [Backend Call - Read Document] action in Image widget.
  TeachersRecord? teacher;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
