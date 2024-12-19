import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import 'notification_admin_widget.dart' show NotificationAdminWidget;
import 'package:flutter/material.dart';

class NotificationAdminModel extends FlutterFlowModel<NotificationAdminWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for navbaradmin component.
  late NavbaradminModel navbaradminModel;

  @override
  void initState(BuildContext context) {
    navbaradminModel = createModel(context, () => NavbaradminModel());
  }

  @override
  void dispose() {
    navbaradminModel.dispose();
  }
}
