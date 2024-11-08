import '/flutter_flow/flutter_flow_util.dart';
import '/pages/parent/childdetails/childdetails_widget.dart';
import 'parent_profile_widget.dart' show ParentProfileWidget;
import 'package:flutter/material.dart';

class ParentProfileModel extends FlutterFlowModel<ParentProfileWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // Model for childdetails component.
  late ChilddetailsModel childdetailsModel;

  @override
  void initState(BuildContext context) {
    childdetailsModel = createModel(context, () => ChilddetailsModel());
  }

  @override
  void dispose() {
    childdetailsModel.dispose();
  }
}
