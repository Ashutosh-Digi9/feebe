import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/admin/classes_admin/classes_admin_widget.dart';
import '/pages/admin/navbar_admin/navbar_admin_widget.dart';
import '/pages/parent/childdetails/childdetails_widget.dart';
import '/pages/parent/navbar_parent/navbar_parent_widget.dart';
import '/pages/super_admin/nav_bar_s_a/nav_bar_s_a_widget.dart';
import '/pages/super_admin/school_s_a/school_s_a_widget.dart';
import 'dashboard_widget.dart' show DashboardWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController1;

  int get pageViewCurrentIndex1 => pageViewController1 != null &&
          pageViewController1!.hasClients &&
          pageViewController1!.page != null
      ? pageViewController1!.page!.round()
      : 0;
  // Model for School_SA component.
  late SchoolSAModel schoolSAModel;
  // Model for NavBarSA component.
  late NavBarSAModel navBarSAModel;
  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
          pageViewController2!.hasClients &&
          pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;
  // Model for ClassesAdmin component.
  late ClassesAdminModel classesAdminModel1;
  // State field(s) for TabBar widget.
  TabController? tabBarController1;
  int get tabBarCurrentIndex1 =>
      tabBarController1 != null ? tabBarController1!.index : 0;

  // State field(s) for Title_notice widget.
  FocusNode? titleNoticeFocusNode1;
  TextEditingController? titleNoticeTextController1;
  String? Function(BuildContext, String?)? titleNoticeTextController1Validator;
  // State field(s) for Description_notice widget.
  FocusNode? descriptionNoticeFocusNode1;
  TextEditingController? descriptionNoticeTextController1;
  String? Function(BuildContext, String?)?
      descriptionNoticeTextController1Validator;
  // State field(s) for Title_reminder widget.
  FocusNode? titleReminderFocusNode1;
  TextEditingController? titleReminderTextController1;
  String? Function(BuildContext, String?)?
      titleReminderTextController1Validator;
  // State field(s) for Description_reminder widget.
  FocusNode? descriptionReminderFocusNode1;
  TextEditingController? descriptionReminderTextController1;
  String? Function(BuildContext, String?)?
      descriptionReminderTextController1Validator;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay1;
  // Model for navbar_admin component.
  late NavbarAdminModel navbarAdminModel1;
  // State field(s) for PageView widget.
  PageController? pageViewController3;

  int get pageViewCurrentIndex3 => pageViewController3 != null &&
          pageViewController3!.hasClients &&
          pageViewController3!.page != null
      ? pageViewController3!.page!.round()
      : 0;
  // Model for ClassesAdmin component.
  late ClassesAdminModel classesAdminModel2;
  // State field(s) for TabBar widget.
  TabController? tabBarController2;
  int get tabBarCurrentIndex2 =>
      tabBarController2 != null ? tabBarController2!.index : 0;

  // State field(s) for Title_notice widget.
  FocusNode? titleNoticeFocusNode2;
  TextEditingController? titleNoticeTextController2;
  String? Function(BuildContext, String?)? titleNoticeTextController2Validator;
  // State field(s) for Description_notice widget.
  FocusNode? descriptionNoticeFocusNode2;
  TextEditingController? descriptionNoticeTextController2;
  String? Function(BuildContext, String?)?
      descriptionNoticeTextController2Validator;
  // State field(s) for Title_reminder widget.
  FocusNode? titleReminderFocusNode2;
  TextEditingController? titleReminderTextController2;
  String? Function(BuildContext, String?)?
      titleReminderTextController2Validator;
  // State field(s) for Description_reminder widget.
  FocusNode? descriptionReminderFocusNode2;
  TextEditingController? descriptionReminderTextController2;
  String? Function(BuildContext, String?)?
      descriptionReminderTextController2Validator;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay2;
  // Model for navbar_admin component.
  late NavbarAdminModel navbarAdminModel2;
  // State field(s) for PageView widget.
  PageController? pageViewController4;

  int get pageViewCurrentIndex4 => pageViewController4 != null &&
          pageViewController4!.hasClients &&
          pageViewController4!.page != null
      ? pageViewController4!.page!.round()
      : 0;
  // Model for childdetails component.
  late ChilddetailsModel childdetailsModel1;
  // Model for childdetails component.
  late ChilddetailsModel childdetailsModel2;
  // Model for navbar_parent component.
  late NavbarParentModel navbarParentModel;

  @override
  void initState(BuildContext context) {
    schoolSAModel = createModel(context, () => SchoolSAModel());
    navBarSAModel = createModel(context, () => NavBarSAModel());
    classesAdminModel1 = createModel(context, () => ClassesAdminModel());
    calendarSelectedDay1 = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    navbarAdminModel1 = createModel(context, () => NavbarAdminModel());
    classesAdminModel2 = createModel(context, () => ClassesAdminModel());
    calendarSelectedDay2 = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    navbarAdminModel2 = createModel(context, () => NavbarAdminModel());
    childdetailsModel1 = createModel(context, () => ChilddetailsModel());
    childdetailsModel2 = createModel(context, () => ChilddetailsModel());
    navbarParentModel = createModel(context, () => NavbarParentModel());
  }

  @override
  void dispose() {
    schoolSAModel.dispose();
    navBarSAModel.dispose();
    classesAdminModel1.dispose();
    tabBarController1?.dispose();
    titleNoticeFocusNode1?.dispose();
    titleNoticeTextController1?.dispose();

    descriptionNoticeFocusNode1?.dispose();
    descriptionNoticeTextController1?.dispose();

    titleReminderFocusNode1?.dispose();
    titleReminderTextController1?.dispose();

    descriptionReminderFocusNode1?.dispose();
    descriptionReminderTextController1?.dispose();

    navbarAdminModel1.dispose();
    classesAdminModel2.dispose();
    tabBarController2?.dispose();
    titleNoticeFocusNode2?.dispose();
    titleNoticeTextController2?.dispose();

    descriptionNoticeFocusNode2?.dispose();
    descriptionNoticeTextController2?.dispose();

    titleReminderFocusNode2?.dispose();
    titleReminderTextController2?.dispose();

    descriptionReminderFocusNode2?.dispose();
    descriptionReminderTextController2?.dispose();

    navbarAdminModel2.dispose();
    childdetailsModel1.dispose();
    childdetailsModel2.dispose();
    navbarParentModel.dispose();
  }
}
