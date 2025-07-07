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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
