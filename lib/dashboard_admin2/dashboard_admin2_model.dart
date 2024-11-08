import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/admin/classes_admin/classes_admin_widget.dart';
import '/pages/admin/navbar_admin/navbar_admin_widget.dart';
import 'dashboard_admin2_widget.dart' show DashboardAdmin2Widget;
import 'package:flutter/material.dart';

class DashboardAdmin2Model extends FlutterFlowModel<DashboardAdmin2Widget> {
  ///  Local state fields for this page.

  int? pagenumber = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for ClassesAdmin component.
  late ClassesAdminModel classesAdminModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for Title_notice widget.
  FocusNode? titleNoticeFocusNode;
  TextEditingController? titleNoticeTextController;
  String? Function(BuildContext, String?)? titleNoticeTextControllerValidator;
  // State field(s) for Description_notice widget.
  FocusNode? descriptionNoticeFocusNode;
  TextEditingController? descriptionNoticeTextController;
  String? Function(BuildContext, String?)?
      descriptionNoticeTextControllerValidator;
  // State field(s) for Title_reminder widget.
  FocusNode? titleReminderFocusNode;
  TextEditingController? titleReminderTextController;
  String? Function(BuildContext, String?)? titleReminderTextControllerValidator;
  // State field(s) for Description_reminder widget.
  FocusNode? descriptionReminderFocusNode;
  TextEditingController? descriptionReminderTextController;
  String? Function(BuildContext, String?)?
      descriptionReminderTextControllerValidator;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Model for navbar_admin component.
  late NavbarAdminModel navbarAdminModel;

  @override
  void initState(BuildContext context) {
    classesAdminModel = createModel(context, () => ClassesAdminModel());
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    navbarAdminModel = createModel(context, () => NavbarAdminModel());
  }

  @override
  void dispose() {
    classesAdminModel.dispose();
    tabBarController?.dispose();
    titleNoticeFocusNode?.dispose();
    titleNoticeTextController?.dispose();

    descriptionNoticeFocusNode?.dispose();
    descriptionNoticeTextController?.dispose();

    titleReminderFocusNode?.dispose();
    titleReminderTextController?.dispose();

    descriptionReminderFocusNode?.dispose();
    descriptionReminderTextController?.dispose();

    navbarAdminModel.dispose();
  }
}
