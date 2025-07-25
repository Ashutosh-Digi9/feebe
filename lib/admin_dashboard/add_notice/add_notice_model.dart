import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_notice_widget.dart' show AddNoticeWidget;
import 'package:flutter/material.dart';

class AddNoticeModel extends FlutterFlowModel<AddNoticeWidget> {
  ///  Local state fields for this component.

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  String? eventName;

  int? id;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Evnettitile widget.
  FocusNode? evnettitileFocusNode;
  TextEditingController? evnettitileTextController;
  String? Function(BuildContext, String?)? evnettitileTextControllerValidator;
  String? _evnettitileTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add event name ';
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
  DateTime? datePicked;
  bool isDataUploading_uploadData5a4 = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadData5a4 = [];
  List<String> uploadedFileUrls_uploadData5a4 = [];

  bool isDataUploading_uploadCamera = false;
  FFUploadedFile uploadedLocalFile_uploadCamera =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadCamera = '';

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<StudentsRecord>? students;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolClassRecord? classes;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  SchoolRecord? school;

  @override
  void initState(BuildContext context) {
    evnettitileTextControllerValidator = _evnettitileTextControllerValidator;
  }

  @override
  void dispose() {
    evnettitileFocusNode?.dispose();
    evnettitileTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
