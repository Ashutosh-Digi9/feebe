import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'change_subscription_plan_s_a_widget.dart'
    show ChangeSubscriptionPlanSAWidget;
import 'package:flutter/material.dart';

class ChangeSubscriptionPlanSAModel
    extends FlutterFlowModel<ChangeSubscriptionPlanSAWidget> {
  ///  Local state fields for this page.

  List<int> pageno = [10];
  void addToPageno(int item) => pageno.add(item);
  void removeFromPageno(int item) => pageno.remove(item);
  void removeAtIndexFromPageno(int index) => pageno.removeAt(index);
  void insertAtIndexInPageno(int index, int item) => pageno.insert(index, item);
  void updatePagenoAtIndex(int index, Function(int) updateFn) =>
      pageno[index] = updateFn(pageno[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
