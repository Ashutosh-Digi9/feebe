import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'addnotice_all_schools_widget.dart' show AddnoticeAllSchoolsWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddnoticeAllSchoolsModel
    extends FlutterFlowModel<AddnoticeAllSchoolsWidget> {
  ///  Local state fields for this page.

  bool searchbool = false;

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

  bool selectall = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
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
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add Description ';
    }

    return null;
  }

  bool isDataUploading = false;
  List<FFUploadedFile> uploadedLocalFiles = [];
  List<String> uploadedFileUrls = [];

  DateTime? datePicked;
  // State field(s) for search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  List<String> simpleSearchResults = [];
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolRecord? school;
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

    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
