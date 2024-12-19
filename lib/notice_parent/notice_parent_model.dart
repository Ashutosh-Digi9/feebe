import '/flutter_flow/flutter_flow_util.dart';
import 'notice_parent_widget.dart' show NoticeParentWidget;
import 'package:flutter/material.dart';

class NoticeParentModel extends FlutterFlowModel<NoticeParentWidget> {
  ///  Local state fields for this page.

  String noticeboard = 'notice';

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  DateTime? dateClass;

  DateTime? dateSchool;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
