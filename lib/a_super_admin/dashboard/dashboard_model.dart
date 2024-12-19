import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/nav_bar_s_a/nav_bar_s_a_widget.dart';
import '/navbar/navbar_parent/navbar_parent_widget.dart';
import '/navbar/navbarteacher/navbarteacher_widget.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  DateTime? calendarDate;

  DocumentReference? selectedstudentref;

  String? eventname;

  List<String> imagesnotice = [];
  void addToImagesnotice(String item) => imagesnotice.add(item);
  void removeFromImagesnotice(String item) => imagesnotice.remove(item);
  void removeAtIndexFromImagesnotice(int index) => imagesnotice.removeAt(index);
  void insertAtIndexInImagesnotice(int index, String item) =>
      imagesnotice.insert(index, item);
  void updateImagesnoticeAtIndex(int index, Function(String) updateFn) =>
      imagesnotice[index] = updateFn(imagesnotice[index]);

  DateTime? datetime;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in Dashboard widget.
  SchoolRecord? school;
  // Stores action output result for [Firestore Query - Query a collection] action in Dashboard widget.
  List<SchoolRecord>? numberofSchool;
  // State field(s) for TabBar widget.
  TabController? tabBarController1;
  int get tabBarCurrentIndex1 =>
      tabBarController1 != null ? tabBarController1!.index : 0;

  // Model for NavBarSA component.
  late NavBarSAModel navBarSAModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController2;
  int get tabBarCurrentIndex2 =>
      tabBarController2 != null ? tabBarController2!.index : 0;

  // Stores action output result for [Backend Call - Create Document] action in Checkin_time widget.
  NotificationsRecord? sc;
  // Stores action output result for [Backend Call - Create Document] action in Checkout_time widget.
  NotificationsRecord? dfff;
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
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please add Description ';
    }

    return null;
  }

  bool isDataUploading = false;
  List<FFUploadedFile> uploadedLocalFiles = [];
  List<String> uploadedFileUrls = [];

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
  // Stores action output result for [Firestore Query - Query a collection] action in CircleImage widget.
  List<StudentsRecord>? students;

  @override
  void initState(BuildContext context) {
    navBarSAModel = createModel(context, () => NavBarSAModel());
    eventnameTextControllerValidator = _eventnameTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
    navbarteacherModel = createModel(context, () => NavbarteacherModel());
    navbarParentModel = createModel(context, () => NavbarParentModel());
  }

  @override
  void dispose() {
    tabBarController1?.dispose();
    navBarSAModel.dispose();
    tabBarController2?.dispose();
    eventnameFocusNode?.dispose();
    eventnameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    navbarteacherModel.dispose();
    navbarParentModel.dispose();
  }
}
