import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'addnotice_all_schools_widget.dart' show AddnoticeAllSchoolsWidget;
import 'package:flutter/material.dart';

class AddnoticeAllSchoolsModel
    extends FlutterFlowModel<AddnoticeAllSchoolsWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> selectschoolref = [];
  void addToSelectschoolref(DocumentReference item) =>
      selectschoolref.add(item);
  void removeFromSelectschoolref(DocumentReference item) =>
      selectschoolref.remove(item);
  void removeAtIndexFromSelectschoolref(int index) =>
      selectschoolref.removeAt(index);
  void insertAtIndexInSelectschoolref(int index, DocumentReference item) =>
      selectschoolref.insert(index, item);
  void updateSelectschoolrefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      selectschoolref[index] = updateFn(selectschoolref[index]);

  String noticename = 'General';

  EventsNoticeStruct? noticedetails;
  void updateNoticedetailsStruct(Function(EventsNoticeStruct) updateFn) {
    updateFn(noticedetails ??= EventsNoticeStruct());
  }

  bool enable = false;

  DateTime? dateOfnotice;

  bool last = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in addnoticeAllSchools widget.
  List<SchoolRecord>? school;
  // State field(s) for Eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  String? _eventnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add event name ';
    }

    return null;
  }

  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  bool isDataUploading_uploadDataXk7 = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataXk7 = [];
  List<String> uploadedFileUrls_uploadDataXk7 = [];

  bool isDataUploading_camera = false;
  FFUploadedFile uploadedLocalFile_camera =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_camera = '';

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
