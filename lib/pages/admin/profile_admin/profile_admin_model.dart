import '/flutter_flow/flutter_flow_util.dart';
import '/pages/admin/school_admin/school_admin_widget.dart';
import 'profile_admin_widget.dart' show ProfileAdminWidget;
import 'package:flutter/material.dart';

class ProfileAdminModel extends FlutterFlowModel<ProfileAdminWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // Model for School_Admin component.
  late SchoolAdminModel schoolAdminModel;

  @override
  void initState(BuildContext context) {
    schoolAdminModel = createModel(context, () => SchoolAdminModel());
  }

  @override
  void dispose() {
    schoolAdminModel.dispose();
  }
}
