import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import '/index.dart';
import 'class_dashboard_widget.dart' show ClassDashboardWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  List<StudentListStruct> studentsList = [];
  void addToStudentsList(StudentListStruct item) => studentsList.add(item);
  void removeFromStudentsList(StudentListStruct item) =>
      studentsList.remove(item);
  void removeAtIndexFromStudentsList(int index) => studentsList.removeAt(index);
  void insertAtIndexInStudentsList(int index, StudentListStruct item) =>
      studentsList.insert(index, item);
  void updateStudentsListAtIndex(
          int index, Function(StudentListStruct) updateFn) =>
      studentsList[index] = updateFn(studentsList[index]);

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
  // State field(s) for GridView widget.

  PagingController<DocumentSnapshot?, StudentsRecord>?
      gridViewPagingController1;
  Query? gridViewPagingQuery1;
  List<StreamSubscription?> gridViewStreamSubscriptions1 = [];

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

    gridViewStreamSubscriptions1.forEach((s) => s?.cancel());
    gridViewPagingController1?.dispose();

    navbaradminModel.dispose();
  }

  /// Action blocks.
  Future backbutton(BuildContext context) async {}

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, StudentsRecord> setGridViewController1(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    gridViewPagingController1 ??= _createGridViewController1(query, parent);
    if (gridViewPagingQuery1 != query) {
      gridViewPagingQuery1 = query;
      gridViewPagingController1?.refresh();
    }
    return gridViewPagingController1!;
  }

  PagingController<DocumentSnapshot?, StudentsRecord>
      _createGridViewController1(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, StudentsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryStudentsRecordPage(
          queryBuilder: (_) => gridViewPagingQuery1 ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: gridViewStreamSubscriptions1,
          controller: controller,
          pageSize: 12,
          isStream: true,
        ),
      );
  }
}
