import '/flutter_flow/flutter_flow_util.dart';
import '/pages/parent/navbar_parent/navbar_parent_widget.dart';
import 'notifications_detials_admin_widget.dart'
    show NotificationsDetialsAdminWidget;
import 'package:flutter/material.dart';

class NotificationsDetialsAdminModel
    extends FlutterFlowModel<NotificationsDetialsAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

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
