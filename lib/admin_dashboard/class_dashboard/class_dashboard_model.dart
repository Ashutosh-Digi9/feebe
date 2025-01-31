import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import 'class_dashboard_widget.dart' show ClassDashboardWidget;
import 'package:flutter/material.dart';

class ClassDashboardModel extends FlutterFlowModel<ClassDashboardWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  DateTime? date;

  String? noticename = '';

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

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in class_dashboard widget.
  SchoolRecord? school;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

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
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add Description ';
    }

    return null;
  }

  bool isDataUploading1 = false;
  List<FFUploadedFile> uploadedLocalFiles1 = [];
  List<String> uploadedFileUrls1 = [];

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  DateTime? datePicked;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  List<SchoolClassRecord>? dropDownPreviousSnapshot;
  // Stores action output result for [Backend Call - Read Document] action in DropDown widget.
  SchoolClassRecord? class45;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for navbaradmin component.
  late NavbaradminModel navbaradminModel;

  @override
  void initState(BuildContext context) {
    titleTextControllerValidator = _titleTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
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
}
