import '/flutter_flow/flutter_flow_util.dart';
import 'notice_send_to_widget.dart' show NoticeSendToWidget;
import 'package:flutter/material.dart';

class NoticeSendToModel extends FlutterFlowModel<NoticeSendToWidget> {
  ///  Local state fields for this component.

  int everyone = 0;

  List<DocumentReference> schoolref = [];
  void addToSchoolref(DocumentReference item) => schoolref.add(item);
  void removeFromSchoolref(DocumentReference item) => schoolref.remove(item);
  void removeAtIndexFromSchoolref(int index) => schoolref.removeAt(index);
  void insertAtIndexInSchoolref(int index, DocumentReference item) =>
      schoolref.insert(index, item);
  void updateSchoolrefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      schoolref[index] = updateFn(schoolref[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
