import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/navbar/nav_bar_s_a/nav_bar_s_a_widget.dart';
import '/navbar/navbar_parent/navbar_parent_widget.dart';
import '/navbar/navbarteacher/navbarteacher_widget.dart';
import '/index.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  DateTime? calendarDate;

  DocumentReference? selectedstudentref;

  String eventname = 'General';

  List<String> imagesnotice = [];
  void addToImagesnotice(String item) => imagesnotice.add(item);
  void removeFromImagesnotice(String item) => imagesnotice.remove(item);
  void removeAtIndexFromImagesnotice(int index) => imagesnotice.removeAt(index);
  void insertAtIndexInImagesnotice(int index, String item) =>
      imagesnotice.insert(index, item);
  void updateImagesnoticeAtIndex(int index, Function(String) updateFn) =>
      imagesnotice[index] = updateFn(imagesnotice[index]);

  DateTime? datetime;

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

  bool isScroll = false;

  int lastfield = 0;

  int? numberofstudents;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in Dashboard widget.
  SchoolRecord? school;
  // Stores action output result for [Firestore Query - Query a collection] action in Dashboard widget.
  List<SchoolRecord>? numberofSchool;
  // Stores action output result for [Firestore Query - Query a collection] action in Dashboard widget.
  SchoolRecord? teacherSchool;
  // Stores action output result for [Firestore Query - Query a collection] action in Dashboard widget.
  List<StudentsRecord>? studentListofparents;
  // Stores action output result for [Firestore Query - Query a collection] action in CircleImage widget.
  List<StudentsRecord>? students12;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for NavBarSA component.
  late NavBarSAModel navBarSAModel;
  // State field(s) for Tabbarclass widget.
  TabController? tabbarclassController;
  int get tabbarclassCurrentIndex =>
      tabbarclassController != null ? tabbarclassController!.index : 0;
  int get tabbarclassPreviousIndex =>
      tabbarclassController != null ? tabbarclassController!.previousIndex : 0;

  // State field(s) for Eventname widget.
  FocusNode? eventnameFocusNode;
  TextEditingController? eventnameTextController;
  String? Function(BuildContext, String?)? eventnameTextControllerValidator;
  String? _eventnameTextControllerValidator(BuildContext context, String? val) {
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
  bool isDataUploading_uploadDataWee = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataWee = [];
  List<String> uploadedFileUrls_uploadDataWee = [];

  bool isDataUploading_uploadData8ae66 = false;
  FFUploadedFile uploadedLocalFile_uploadData8ae66 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData8ae66 = '';

  DateTime? datePicked;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for navbarteacher component.
  late NavbarteacherModel navbarteacherModel;
  // State field(s) for studentPageview widget.
  PageController? studentPageviewController;

  int get studentPageviewCurrentIndex => studentPageviewController != null &&
          studentPageviewController!.hasClients &&
          studentPageviewController!.page != null
      ? studentPageviewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - Read Document] action in IconButton widget.
  SchoolRecord? school9;
  // Model for navbar_parent component.
  late NavbarParentModel navbarParentModel;

  @override
  void initState(BuildContext context) {
    navBarSAModel = createModel(context, () => NavBarSAModel());
    eventnameTextControllerValidator = _eventnameTextControllerValidator;
    navbarteacherModel = createModel(context, () => NavbarteacherModel());
    navbarParentModel = createModel(context, () => NavbarParentModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    navBarSAModel.dispose();
    tabbarclassController?.dispose();
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    navbarteacherModel.dispose();
    navbarParentModel.dispose();
  }
}
