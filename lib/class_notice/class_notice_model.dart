import '/flutter_flow/flutter_flow_util.dart';
import 'class_notice_widget.dart' show ClassNoticeWidget;
import 'package:flutter/material.dart';

class ClassNoticeModel extends FlutterFlowModel<ClassNoticeWidget> {
  ///  Local state fields for this page.

  DateTime? calendarDate;

  String noticeboard = 'notice';

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Title_notice widget.
  FocusNode? titleNoticeFocusNode;
  TextEditingController? titleNoticeTextController;
  String? Function(BuildContext, String?)? titleNoticeTextControllerValidator;
  String? _titleNoticeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter event titile ';
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
      return 'Please enter Description';
    }

    return null;
  }

  bool isDataUploading = false;
  List<FFUploadedFile> uploadedLocalFiles = [];
  List<String> uploadedFileUrls = [];

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
