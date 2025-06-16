import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'calender_list_parent_widget.dart' show CalenderListParentWidget;
import 'package:flutter/material.dart';

class CalenderListParentModel
    extends FlutterFlowModel<CalenderListParentWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
