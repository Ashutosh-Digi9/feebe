import '/flutter_flow/flutter_flow_util.dart';
import '/pages/parent/navbar_parent/navbar_parent_widget.dart';
import 'class_dashboard_widget.dart' show ClassDashboardWidget;
import 'package:flutter/material.dart';

class ClassDashboardModel extends FlutterFlowModel<ClassDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navbar_parent component.
  late NavbarParentModel navbarParentModel;

  @override
  void initState(BuildContext context) {
    navbarParentModel = createModel(context, () => NavbarParentModel());
  }

  @override
  void dispose() {
    navbarParentModel.dispose();
  }
}
