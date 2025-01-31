import '/flutter_flow/flutter_flow_util.dart';
import 'student_gallery_widget.dart' show StudentGalleryWidget;
import 'package:flutter/material.dart';

class StudentGalleryModel extends FlutterFlowModel<StudentGalleryWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
