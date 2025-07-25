import '/flutter_flow/flutter_flow_util.dart';
import 'teacher_notice_comp_widget.dart' show TeacherNoticeCompWidget;
import 'package:flutter/material.dart';

class TeacherNoticeCompModel extends FlutterFlowModel<TeacherNoticeCompWidget> {
  ///  Local state fields for this component.

  String teachernotice = 'General';

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  bool last = false;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  DateTime? datePicked;
  // State field(s) for Eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  String? _eventnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter title';
    }

    if (val.length > 50) {
      return 'The event name can only contain up to 50 character';
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

  bool isDataUploading_uploadDataXor = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataXor = [];
  List<String> uploadedFileUrls_uploadDataXor = [];

  bool isDataUploading_teacherNotice = false;
  FFUploadedFile uploadedLocalFile_teacherNotice =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_teacherNotice = '';

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
