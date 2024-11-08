import '/flutter_flow/flutter_flow_util.dart';
import '/pages/parent/childdetails/childdetails_widget.dart';
import '/pages/parent/navbar_parent/navbar_parent_widget.dart';
import 'dashboard_parent_widget.dart' show DashboardParentWidget;
import 'package:flutter/material.dart';

class DashboardParentModel extends FlutterFlowModel<DashboardParentWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for childdetails component.
  late ChilddetailsModel childdetailsModel1;
  // Model for childdetails component.
  late ChilddetailsModel childdetailsModel2;
  // Model for navbar_parent component.
  late NavbarParentModel navbarParentModel;

  @override
  void initState(BuildContext context) {
    childdetailsModel1 = createModel(context, () => ChilddetailsModel());
    childdetailsModel2 = createModel(context, () => ChilddetailsModel());
    navbarParentModel = createModel(context, () => NavbarParentModel());
  }

  @override
  void dispose() {
    childdetailsModel1.dispose();
    childdetailsModel2.dispose();
    navbarParentModel.dispose();
  }
}
