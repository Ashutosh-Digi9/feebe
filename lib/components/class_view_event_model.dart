import '/flutter_flow/flutter_flow_util.dart';
import 'class_view_event_widget.dart' show ClassViewEventWidget;
import 'package:flutter/material.dart';

class ClassViewEventModel extends FlutterFlowModel<ClassViewEventWidget> {
  ///  Local state fields for this component.

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  String? eventName;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  // State field(s) for eventtitle widget.
  FocusNode? eventtitleFocusNode;
  TextEditingController? eventtitleTextController;
  String? Function(BuildContext, String?)? eventtitleTextControllerValidator;
  // State field(s) for date widget.
  FocusNode? dateFocusNode;
  TextEditingController? dateTextController;
  String? Function(BuildContext, String?)? dateTextControllerValidator;
  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    eventtitleFocusNode?.dispose();
    eventtitleTextController?.dispose();

    dateFocusNode?.dispose();
    dateTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
