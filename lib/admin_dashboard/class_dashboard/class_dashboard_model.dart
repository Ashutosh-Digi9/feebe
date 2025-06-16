import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import '/index.dart';
import 'class_dashboard_widget.dart' show ClassDashboardWidget;
import 'package:flutter/material.dart';

class ClassDashboardModel extends FlutterFlowModel<ClassDashboardWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  DateTime? date;

  String noticename = 'General';

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void insertAtIndexInImages(int index, String item) =>
      images.insert(index, item);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  EventsNoticeStruct? timelinedatatype;
  void updateTimelinedatatypeStruct(Function(EventsNoticeStruct) updateFn) {
    updateFn(timelinedatatype ??= EventsNoticeStruct());
  }

  DocumentReference? classref;

  String? teacherNotice;

  String? camerimages;

  DocumentReference? selectedclass;

  List<EventsNoticeStruct> classevents = [];
  void addToClassevents(EventsNoticeStruct item) => classevents.add(item);
  void removeFromClassevents(EventsNoticeStruct item) =>
      classevents.remove(item);
  void removeAtIndexFromClassevents(int index) => classevents.removeAt(index);
  void insertAtIndexInClassevents(int index, EventsNoticeStruct item) =>
      classevents.insert(index, item);
  void updateClasseventsAtIndex(
          int index, Function(EventsNoticeStruct) updateFn) =>
      classevents[index] = updateFn(classevents[index]);

  String? title;

  String? des;

  List<DocumentReference> teacherRef = [];
  void addToTeacherRef(DocumentReference item) => teacherRef.add(item);
  void removeFromTeacherRef(DocumentReference item) => teacherRef.remove(item);
  void removeAtIndexFromTeacherRef(int index) => teacherRef.removeAt(index);
  void insertAtIndexInTeacherRef(int index, DocumentReference item) =>
      teacherRef.insert(index, item);
  void updateTeacherRefAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      teacherRef[index] = updateFn(teacherRef[index]);

  bool last = false;

  bool isClicked = false;

  int? tabindex = 0;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in class_dashboard widget.
  SchoolRecord? school;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;
  String? _titleTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add title';
    }

    if (val.length > 50) {
      return 'The event name can only contain up to 50 characters.';
    }

    return null;
  }

  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  bool isDataUploading_uploadData9tz = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadData9tz = [];
  List<String> uploadedFileUrls_uploadData9tz = [];

  bool isDataUploading_uploadDataK0455 = false;
  FFUploadedFile uploadedLocalFile_uploadDataK0455 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataK0455 = '';

  DateTime? datePicked;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for navbaradmin component.
  late NavbaradminModel navbaradminModel;
  // Stores action output result for [Firestore Query - Query a collection] action in CircleImage widget.
  List<StudentsRecord>? students12;

  @override
  void initState(BuildContext context) {
    titleTextControllerValidator = _titleTextControllerValidator;
    navbaradminModel = createModel(context, () => NavbaradminModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    titleFocusNode?.dispose();
    titleTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    navbaradminModel.dispose();
  }

  /// Action blocks.
  Future backbutton(BuildContext context) async {}
}
