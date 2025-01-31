import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_calender_school_widget.dart' show EditCalenderSchoolWidget;
import 'package:flutter/material.dart';

class EditCalenderSchoolModel
    extends FlutterFlowModel<EditCalenderSchoolWidget> {
  ///  Local state fields for this component.

  List<String> images23 = [];
  void addToImages23(String item) => images23.add(item);
  void removeFromImages23(String item) => images23.remove(item);
  void removeAtIndexFromImages23(int index) => images23.removeAt(index);
  void insertAtIndexInImages23(int index, String item) =>
      images23.insert(index, item);
  void updateImages23AtIndex(int index, Function(String) updateFn) =>
      images23[index] = updateFn(images23[index]);

  String? eventname;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in edit_calender_school widget.
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
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter description';
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
