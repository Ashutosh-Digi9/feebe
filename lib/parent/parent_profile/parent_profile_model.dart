import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'parent_profile_widget.dart' show ParentProfileWidget;
import 'package:flutter/material.dart';

class ParentProfileModel extends FlutterFlowModel<ParentProfileWidget> {
  ///  Local state fields for this page.

  List<ParentsDetailsStruct> parentslist = [];
  void addToParentslist(ParentsDetailsStruct item) => parentslist.add(item);
  void removeFromParentslist(ParentsDetailsStruct item) =>
      parentslist.remove(item);
  void removeAtIndexFromParentslist(int index) => parentslist.removeAt(index);
  void insertAtIndexInParentslist(int index, ParentsDetailsStruct item) =>
      parentslist.insert(index, item);
  void updateParentslistAtIndex(
          int index, Function(ParentsDetailsStruct) updateFn) =>
      parentslist[index] = updateFn(parentslist[index]);

  ParentsDetailsStruct? parentdata;
  void updateParentdataStruct(Function(ParentsDetailsStruct) updateFn) {
    updateFn(parentdata ??= ParentsDetailsStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - insertintoindex1] action in parent_profile widget.
  List<ParentsDetailsStruct>? updatedlilst;
  // Stores action output result for [Custom Action - insertintoindex1] action in Container widget.
  List<ParentsDetailsStruct>? newUpdatedlist;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
