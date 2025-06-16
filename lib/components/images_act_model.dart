import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'images_act_widget.dart' show ImagesActWidget;
import 'package:flutter/material.dart';

class ImagesActModel extends FlutterFlowModel<ImagesActWidget> {
  ///  Local state fields for this component.

  bool uploaded = false;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataCu4cam = false;
  FFUploadedFile uploadedLocalFile_uploadDataCu4cam =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataCu4cam = '';

  bool isDataUploading_uploadDataZ3jgal = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataZ3jgal = [];
  List<String> uploadedFileUrls_uploadDataZ3jgal = [];

  // Stores action output result for [Backend Call - Read Document] action in Image widget.
  TeachersRecord? teacher;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
