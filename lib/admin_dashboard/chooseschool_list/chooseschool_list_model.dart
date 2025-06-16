import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chooseschool_list_widget.dart' show ChooseschoolListWidget;
import 'package:flutter/material.dart';

class ChooseschoolListModel extends FlutterFlowModel<ChooseschoolListWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> listOfSchoolref = [];
  void addToListOfSchoolref(DocumentReference item) =>
      listOfSchoolref.add(item);
  void removeFromListOfSchoolref(DocumentReference item) =>
      listOfSchoolref.remove(item);
  void removeAtIndexFromListOfSchoolref(int index) =>
      listOfSchoolref.removeAt(index);
  void insertAtIndexInListOfSchoolref(int index, DocumentReference item) =>
      listOfSchoolref.insert(index, item);
  void updateListOfSchoolrefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      listOfSchoolref[index] = updateFn(listOfSchoolref[index]);

  bool isAdded = false;

  bool isSearch = false;

  EventsNoticeStruct? noticedetails;
  void updateNoticedetailsStruct(Function(EventsNoticeStruct) updateFn) {
    updateFn(noticedetails ??= EventsNoticeStruct());
  }

  ///  State fields for stateful widgets in this component.

  // State field(s) for search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  List<String> simpleSearchResults = [];
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  SchoolRecord? school;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
