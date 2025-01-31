import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'students_timeline_activities_widget.dart'
    show StudentsTimelineActivitiesWidget;
import 'package:flutter/material.dart';

class StudentsTimelineActivitiesModel
    extends FlutterFlowModel<StudentsTimelineActivitiesWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  bool selectall = false;

  int selectedno = 0;

  List<int> activityid = [];
  void addToActivityid(int item) => activityid.add(item);
  void removeFromActivityid(int item) => activityid.remove(item);
  void removeAtIndexFromActivityid(int index) => activityid.removeAt(index);
  void insertAtIndexInActivityid(int index, int item) =>
      activityid.insert(index, item);
  void updateActivityidAtIndex(int index, Function(int) updateFn) =>
      activityid[index] = updateFn(activityid[index]);

  List<String> activityName = [];
  void addToActivityName(String item) => activityName.add(item);
  void removeFromActivityName(String item) => activityName.remove(item);
  void removeAtIndexFromActivityName(int index) => activityName.removeAt(index);
  void insertAtIndexInActivityName(int index, String item) =>
      activityName.insert(index, item);
  void updateActivityNameAtIndex(int index, Function(String) updateFn) =>
      activityName[index] = updateFn(activityName[index]);

  List<DateTime> activitytime = [];
  void addToActivitytime(DateTime item) => activitytime.add(item);
  void removeFromActivitytime(DateTime item) => activitytime.remove(item);
  void removeAtIndexFromActivitytime(int index) => activitytime.removeAt(index);
  void insertAtIndexInActivitytime(int index, DateTime item) =>
      activitytime.insert(index, item);
  void updateActivitytimeAtIndex(int index, Function(DateTime) updateFn) =>
      activitytime[index] = updateFn(activitytime[index]);

  List<String> activitydescription = [];
  void addToActivitydescription(String item) => activitydescription.add(item);
  void removeFromActivitydescription(String item) =>
      activitydescription.remove(item);
  void removeAtIndexFromActivitydescription(int index) =>
      activitydescription.removeAt(index);
  void insertAtIndexInActivitydescription(int index, String item) =>
      activitydescription.insert(index, item);
  void updateActivitydescriptionAtIndex(int index, Function(String) updateFn) =>
      activitydescription[index] = updateFn(activitydescription[index]);

  List<String> addedby = [];
  void addToAddedby(String item) => addedby.add(item);
  void removeFromAddedby(String item) => addedby.remove(item);
  void removeAtIndexFromAddedby(int index) => addedby.removeAt(index);
  void insertAtIndexInAddedby(int index, String item) =>
      addedby.insert(index, item);
  void updateAddedbyAtIndex(int index, Function(String) updateFn) =>
      addedby[index] = updateFn(addedby[index]);

  List<String> towhom = [];
  void addToTowhom(String item) => towhom.add(item);
  void removeFromTowhom(String item) => towhom.remove(item);
  void removeAtIndexFromTowhom(int index) => towhom.removeAt(index);
  void insertAtIndexInTowhom(int index, String item) =>
      towhom.insert(index, item);
  void updateTowhomAtIndex(int index, Function(String) updateFn) =>
      towhom[index] = updateFn(towhom[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter description';
    }

    if (val.length > 50) {
      return 'Maximum 50 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Read Document] action in sendupdate widget.
  StudentsRecord? students1;
  // Stores action output result for [Firestore Query - Query a collection] action in sendupdate widget.
  List<StudentsRecord>? studenList;
  // Stores action output result for [Firestore Query - Query a collection] action in sendupdate widget.
  TeachersRecord? teachereref;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
