import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'class_calendar_edit_widget.dart' show ClassCalendarEditWidget;
import 'package:flutter/material.dart';

class ClassCalendarEditModel extends FlutterFlowModel<ClassCalendarEditWidget> {
  ///  Local state fields for this component.

  List<String> images12 = [];
  void addToImages12(String item) => images12.add(item);
  void removeFromImages12(String item) => images12.remove(item);
  void removeAtIndexFromImages12(int index) => images12.removeAt(index);
  void insertAtIndexInImages12(int index, String item) =>
      images12.insert(index, item);
  void updateImages12AtIndex(int index, Function(String) updateFn) =>
      images12[index] = updateFn(images12[index]);

  String? eventname1278;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in class_calendar_edit widget.
  SchoolClassRecord? classes;
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
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the description';
    }

    return null;
  }

  DateTime? datePicked;
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
