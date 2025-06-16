import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'teachers_gallery_widget.dart' show TeachersGalleryWidget;
import 'package:flutter/material.dart';

class TeachersGalleryModel extends FlutterFlowModel<TeachersGalleryWidget> {
  ///  Local state fields for this page.

  int? pageindex;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
