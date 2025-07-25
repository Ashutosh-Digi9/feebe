import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'select_class_calender_widget.dart' show SelectClassCalenderWidget;
import 'package:flutter/material.dart';

class SelectClassCalenderModel
    extends FlutterFlowModel<SelectClassCalenderWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> schoolclassref = [];
  void addToSchoolclassref(DocumentReference item) => schoolclassref.add(item);
  void removeFromSchoolclassref(DocumentReference item) =>
      schoolclassref.remove(item);
  void removeAtIndexFromSchoolclassref(int index) =>
      schoolclassref.removeAt(index);
  void insertAtIndexInSchoolclassref(int index, DocumentReference item) =>
      schoolclassref.insert(index, item);
  void updateSchoolclassrefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      schoolclassref[index] = updateFn(schoolclassref[index]);

  Color color = Color(4294967295);

  int everyone = 0;

  List<String> toWhome = [];
  void addToToWhome(String item) => toWhome.add(item);
  void removeFromToWhome(String item) => toWhome.remove(item);
  void removeAtIndexFromToWhome(int index) => toWhome.removeAt(index);
  void insertAtIndexInToWhome(int index, String item) =>
      toWhome.insert(index, item);
  void updateToWhomeAtIndex(int index, Function(String) updateFn) =>
      toWhome[index] = updateFn(toWhome[index]);

  int? id;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? schoolClassTff;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  StudentsRecord? studentnotice;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<SchoolClassRecord>? classes;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<StudentsRecord>? students;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? classselect;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<StudentsRecord>? studentsOfSchool;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? schoolClassT;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<SchoolClassRecord>? classses123;
  // Stores action output result for [Firestore Query - Query a collection] action in Send widget.
  List<StudentsRecord>? students3;
  // Stores action output result for [Backend Call - Read Document] action in Send widget.
  SchoolClassRecord? classselect3;
  // Stores action output result for [Backend Call - Read Document] action in Next widget.
  SchoolClassRecord? schoolClassT3;
  // Stores action output result for [Backend Call - Read Document] action in Next widget.
  SchoolRecord? school;
  // Stores action output result for [Firestore Query - Query a collection] action in Next widget.
  List<SchoolClassRecord>? classses1233;
  // Stores action output result for [Firestore Query - Query a collection] action in Next widget.
  List<StudentsRecord>? students33;
  // Stores action output result for [Backend Call - Read Document] action in Next widget.
  SchoolClassRecord? classselect33;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
