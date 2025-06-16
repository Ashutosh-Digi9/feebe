import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'class_notice_admin_teacher_widget.dart'
    show ClassNoticeAdminTeacherWidget;
import 'package:flutter/material.dart';

class ClassNoticeAdminTeacherModel
    extends FlutterFlowModel<ClassNoticeAdminTeacherWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  String noticename = 'General';

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  bool last = false;

  int? id;

  List<DocumentReference> classref = [];
  void addToClassref(DocumentReference item) => classref.add(item);
  void removeFromClassref(DocumentReference item) => classref.remove(item);
  void removeAtIndexFromClassref(int index) => classref.removeAt(index);
  void insertAtIndexInClassref(int index, DocumentReference item) =>
      classref.insert(index, item);
  void updateClassrefAtIndex(int index, Function(DocumentReference) updateFn) =>
      classref[index] = updateFn(classref[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
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
  bool isDataUploading_uploadDataTse = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataTse = [];
  List<String> uploadedFileUrls_uploadDataTse = [];

  bool isDataUploading_uploadData8yc = false;
  FFUploadedFile uploadedLocalFile_uploadData8yc =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData8yc = '';

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<StudentsRecord>? students;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolRecord? school;

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
