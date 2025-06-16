import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'teacher_notice_widget.dart' show TeacherNoticeWidget;
import 'package:flutter/material.dart';

class TeacherNoticeModel extends FlutterFlowModel<TeacherNoticeWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
