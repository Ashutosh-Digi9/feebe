import '/flutter_flow/flutter_flow_util.dart';
import 'add_events_details_widget.dart' show AddEventsDetailsWidget;
import 'package:flutter/material.dart';

class AddEventsDetailsModel extends FlutterFlowModel<AddEventsDetailsWidget> {
  ///  Local state fields for this page.

  DateTime? calendarDate;

  String eventName = 'Event';

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  DateTime? datePicked;
  // State field(s) for Title_notice widget.
  FocusNode? titleNoticeFocusNode;
  TextEditingController? titleNoticeTextController;
  String? Function(BuildContext, String?)? titleNoticeTextControllerValidator;
  String? _titleNoticeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the title of the event';
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
      return 'Please enter description of the event ';
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

  @override
  void initState(BuildContext context) {
    titleNoticeTextControllerValidator = _titleNoticeTextControllerValidator;
    descriptionNoticeTextControllerValidator =
        _descriptionNoticeTextControllerValidator;
  }

  @override
  void dispose() {
    titleNoticeFocusNode?.dispose();
    titleNoticeTextController?.dispose();

    descriptionNoticeFocusNode?.dispose();
    descriptionNoticeTextController?.dispose();
  }
}
