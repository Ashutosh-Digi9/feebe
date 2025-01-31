import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_notice_board_widget.dart' show EditNoticeBoardWidget;
import 'package:flutter/material.dart';

class EditNoticeBoardModel extends FlutterFlowModel<EditNoticeBoardWidget> {
  ///  Local state fields for this component.

  String eventName = 'd';

  List<String> images56 = [];
  void addToImages56(String item) => images56.add(item);
  void removeFromImages56(String item) => images56.remove(item);
  void removeAtIndexFromImages56(int index) => images56.removeAt(index);
  void insertAtIndexInImages56(int index, String item) =>
      images56.insert(index, item);
  void updateImages56AtIndex(int index, Function(String) updateFn) =>
      images56[index] = updateFn(images56[index]);

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in edit_notice_board widget.
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
