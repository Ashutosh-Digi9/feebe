import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'select_class_notice_widget.dart' show SelectClassNoticeWidget;
import 'package:flutter/material.dart';

class SelectClassNoticeModel extends FlutterFlowModel<SelectClassNoticeWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> classref = [];
  void addToClassref(DocumentReference item) => classref.add(item);
  void removeFromClassref(DocumentReference item) => classref.remove(item);
  void removeAtIndexFromClassref(int index) => classref.removeAt(index);
  void insertAtIndexInClassref(int index, DocumentReference item) =>
      classref.insert(index, item);
  void updateClassrefAtIndex(int index, Function(DocumentReference) updateFn) =>
      classref[index] = updateFn(classref[index]);

  Color color = const Color(0xffffffff);

  int everyone = 0;

  List<String> classname = [];
  void addToClassname(String item) => classname.add(item);
  void removeFromClassname(String item) => classname.remove(item);
  void removeAtIndexFromClassname(int index) => classname.removeAt(index);
  void insertAtIndexInClassname(int index, String item) =>
      classname.insert(index, item);
  void updateClassnameAtIndex(int index, Function(String) updateFn) =>
      classname[index] = updateFn(classname[index]);

  List<String> toWHome = [];
  void addToToWHome(String item) => toWHome.add(item);
  void removeFromToWHome(String item) => toWHome.remove(item);
  void removeAtIndexFromToWHome(int index) => toWHome.removeAt(index);
  void insertAtIndexInToWHome(int index, String item) =>
      toWHome.insert(index, item);
  void updateToWHomeAtIndex(int index, Function(String) updateFn) =>
      toWHome[index] = updateFn(toWHome[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? classdoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<SchoolClassRecord>? listofclasses;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<StudentsRecord>? students;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? classStudnt;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<StudentsRecord>? studentEveryone;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? schoolClassT;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<SchoolClassRecord>? listofclasses1;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<StudentsRecord>? students1234;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? classStudnt123;
  // Stores action output result for [Backend Call - Read Document] action in send widget.
  SchoolRecord? school;
  // Stores action output result for [Firestore Query - Query a collection] action in send widget.
  List<StudentsRecord>? studentquery;
  // Stores action output result for [Backend Call - Read Document] action in send widget.
  SchoolClassRecord? classesstudentQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
