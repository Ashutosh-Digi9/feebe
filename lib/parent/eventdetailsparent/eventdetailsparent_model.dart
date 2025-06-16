import '/flutter_flow/flutter_flow_util.dart';
import 'eventdetailsparent_widget.dart' show EventdetailsparentWidget;
import 'package:flutter/material.dart';

class EventdetailsparentModel
    extends FlutterFlowModel<EventdetailsparentWidget> {
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

  bool viewpdf = false;

  bool viewdoc = false;

  bool viewmp3 = false;

  bool viewimg = false;

  bool viewppt = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
