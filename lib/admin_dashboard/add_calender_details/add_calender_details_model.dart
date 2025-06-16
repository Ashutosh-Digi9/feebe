import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_calender_details_widget.dart' show AddCalenderDetailsWidget;
import 'package:flutter/material.dart';

class AddCalenderDetailsModel
    extends FlutterFlowModel<AddCalenderDetailsWidget> {
  ///  Local state fields for this page.

  DateTime? calendarDate;

  String eventName = 'Event';

  List<String> image = [];
  void addToImage(String item) => image.add(item);
  void removeFromImage(String item) => image.remove(item);
  void removeAtIndexFromImage(int index) => image.removeAt(index);
  void insertAtIndexInImage(int index, String item) =>
      image.insert(index, item);
  void updateImageAtIndex(int index, Function(String) updateFn) =>
      image[index] = updateFn(image[index]);

  DocumentReference? schoolref;

  NotificationUSerefStruct? useref;
  void updateUserefStruct(Function(NotificationUSerefStruct) updateFn) {
    updateFn(useref ??= NotificationUSerefStruct());
  }

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
  // Stores action output result for [Firestore Query - Query a collection] action in add_calender_details widget.
  SchoolRecord? school;
  DateTime? datePicked;
  // State field(s) for eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  String? _eventnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter title of the event';
    }

    if (val.length > 50) {
      return 'The event name can only contain up to 50 characters.';
    }

    return null;
  }

  // State field(s) for Description_notice widget.
  FocusNode? descriptionNoticeFocusNode;
  TextEditingController? descriptionNoticeTextController;
  String? Function(BuildContext, String?)?
      descriptionNoticeTextControllerValidator;
  bool isDataUploading_uploadData4us = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadData4us = [];
  List<String> uploadedFileUrls_uploadData4us = [];

  bool isDataUploading_uploadData123 = false;
  FFUploadedFile uploadedLocalFile_uploadData123 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData123 = '';

  // Stores action output result for [Firestore Query - Query a collection] action in send widget.
  List<StudentsRecord>? students1;
  // Stores action output result for [Firestore Query - Query a collection] action in send widget.
  SchoolRecord? school123566;
  // Stores action output result for [Backend Call - Create Document] action in send widget.
  NotificationsRecord? studentsk;
  // Stores action output result for [Firestore Query - Query a collection] action in send widget.
  List<StudentsRecord>? students;
  // Stores action output result for [Firestore Query - Query a collection] action in send widget.
  SchoolRecord? school12356;

  @override
  void initState(BuildContext context) {
    eventnameTextControllerValidator = _eventnameTextControllerValidator;
  }

  @override
  void dispose() {
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    descriptionNoticeFocusNode?.dispose();
    descriptionNoticeTextController?.dispose();
  }
}
