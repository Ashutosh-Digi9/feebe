import '/flutter_flow/flutter_flow_util.dart';
import 'teacher_profile_widget.dart' show TeacherProfileWidget;
import 'package:flutter/material.dart';

class TeacherProfileModel extends FlutterFlowModel<TeacherProfileWidget> {
  ///  Local state fields for this page.

  List<String> uploadedimages = [];
  void addToUploadedimages(String item) => uploadedimages.add(item);
  void removeFromUploadedimages(String item) => uploadedimages.remove(item);
  void removeAtIndexFromUploadedimages(int index) =>
      uploadedimages.removeAt(index);
  void insertAtIndexInUploadedimages(int index, String item) =>
      uploadedimages.insert(index, item);
  void updateUploadedimagesAtIndex(int index, Function(String) updateFn) =>
      uploadedimages[index] = updateFn(uploadedimages[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
