import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'addimagesstudent_widget.dart' show AddimagesstudentWidget;
import 'package:flutter/material.dart';

class AddimagesstudentModel extends FlutterFlowModel<AddimagesstudentWidget> {
  ///  Local state fields for this component.

  bool uploaded = false;

  String? url;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataCu4cam13 = false;
  FFUploadedFile uploadedLocalFile_uploadDataCu4cam13 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataCu4cam13 = '';

  bool isDataUploading_uploadDataZ3jgal345 = false;
  FFUploadedFile uploadedLocalFile_uploadDataZ3jgal345 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataZ3jgal345 = '';

  // Stores action output result for [Backend Call - Read Document] action in Image widget.
  StudentsRecord? student;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
