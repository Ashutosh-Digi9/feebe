import '/flutter_flow/flutter_flow_util.dart';
import '/pages/admin/navbar_admin/navbar_admin_widget.dart';
import 'notification_admin_widget.dart' show NotificationAdminWidget;
import 'package:flutter/material.dart';

class NotificationAdminModel extends FlutterFlowModel<NotificationAdminWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navbar_admin component.
  late NavbarAdminModel navbarAdminModel;

  @override
  void initState(BuildContext context) {
    navbarAdminModel = createModel(context, () => NavbarAdminModel());
  }

  @override
  void dispose() {
    navbarAdminModel.dispose();
  }
}
