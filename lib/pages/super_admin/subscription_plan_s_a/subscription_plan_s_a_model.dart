import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'subscription_plan_s_a_widget.dart' show SubscriptionPlanSAWidget;
import 'package:flutter/material.dart';

class SubscriptionPlanSAModel
    extends FlutterFlowModel<SubscriptionPlanSAWidget> {
  ///  Local state fields for this page.

  int? pageno = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController1;
  List<String>? get checkboxGroupValues1 =>
      checkboxGroupValueController1?.value;
  set checkboxGroupValues1(List<String>? v) =>
      checkboxGroupValueController1?.value = v;

  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController2;
  List<String>? get checkboxGroupValues2 =>
      checkboxGroupValueController2?.value;
  set checkboxGroupValues2(List<String>? v) =>
      checkboxGroupValueController2?.value = v;

  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController3;
  List<String>? get checkboxGroupValues3 =>
      checkboxGroupValueController3?.value;
  set checkboxGroupValues3(List<String>? v) =>
      checkboxGroupValueController3?.value = v;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
