import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'class_notice_admin_teacher_widget.dart'
    show ClassNoticeAdminTeacherWidget;
import 'package:flutter/material.dart';

class ClassNoticeAdminTeacherModel
    extends FlutterFlowModel<ClassNoticeAdminTeacherWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  String? noticename = '';

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  DateTime? datePicked;
  // State field(s) for Eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  String? _eventnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add title';
    }

    if (val.length > 50) {
      return 'The event name can only contain up to 50 characters.';
    }

    return null;
  }

  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add Description ';
    }

    return null;
  }

  bool isDataUploading1 = false;
  List<FFUploadedFile> uploadedLocalFiles1 = [];
  List<String> uploadedFileUrls1 = [];

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<StudentsRecord>? students;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolRecord? school;

  @override
  void initState(BuildContext context) {
    eventnameTextControllerValidator = _eventnameTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
  }

  @override
  void dispose() {
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
