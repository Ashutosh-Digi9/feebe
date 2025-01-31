import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  String? _descriptionNoticeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter Description of the event';
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

  // Stores action output result for [Firestore Query - Query a collection] action in send widget.
  List<StudentsRecord>? students;
  // Stores action output result for [Firestore Query - Query a collection] action in send widget.
  SchoolRecord? school12356;

  @override
  void initState(BuildContext context) {
    eventnameTextControllerValidator = _eventnameTextControllerValidator;
    descriptionNoticeTextControllerValidator =
        _descriptionNoticeTextControllerValidator;
  }

  @override
  void dispose() {
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    descriptionNoticeFocusNode?.dispose();
    descriptionNoticeTextController?.dispose();
  }
}
