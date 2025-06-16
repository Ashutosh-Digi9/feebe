import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_notice_widget.dart' show EditNoticeWidget;
import 'package:flutter/material.dart';

class EditNoticeModel extends FlutterFlowModel<EditNoticeWidget> {
  ///  Local state fields for this component.

  String eventName = 'w';

  List<String> images87 = [];
  void addToImages87(String item) => images87.add(item);
  void removeFromImages87(String item) => images87.remove(item);
  void removeAtIndexFromImages87(int index) => images87.removeAt(index);
  void insertAtIndexInImages87(int index, String item) =>
      images87.insert(index, item);
  void updateImages87AtIndex(int index, Function(String) updateFn) =>
      images87[index] = updateFn(images87[index]);

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in edit_notice widget.
  SchoolRecord? school;
  // State field(s) for Eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  String? _eventnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the title name';
    }

    return null;
  }

  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  bool isDataUploading_uploadDataCwz = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataCwz = [];
  List<String> uploadedFileUrls_uploadDataCwz = [];

  bool isDataUploading_camera1 = false;
  FFUploadedFile uploadedLocalFile_camera1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_camera1 = '';

  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolClassRecord? classref;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<StudentsRecord>? students;

  @override
  void initState(BuildContext context) {
    eventnameTextControllerValidator = _eventnameTextControllerValidator;
  }

  @override
  void dispose() {
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
