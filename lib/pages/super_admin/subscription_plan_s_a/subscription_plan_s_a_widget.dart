import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'subscription_plan_s_a_model.dart';
export 'subscription_plan_s_a_model.dart';

class SubscriptionPlanSAWidget extends StatefulWidget {
  const SubscriptionPlanSAWidget({super.key});

  @override
  State<SubscriptionPlanSAWidget> createState() =>
      _SubscriptionPlanSAWidgetState();
}

class _SubscriptionPlanSAWidgetState extends State<SubscriptionPlanSAWidget> {
  late SubscriptionPlanSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscriptionPlanSAModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.pushNamed(
        'EditProfile_SA',
        queryParameters: {
          'userref': serializeParam(
            currentUserReference,
            ParamType.DocumentReference,
          ),
        }.withoutNulls,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.sizeOf(context).height * 0.06),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).info,
            automaticallyImplyLeading: false,
            leading: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
            ),
            title: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FEEBE',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 34.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/Logo_(1).png',
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        'SearchPage_SA',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                          ),
                        },
                      );
                    },
                    child: Icon(
                      Icons.search_sharp,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 10.0, 0.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => Container(
                      width: 40.0,
                      height: 40.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        valueOrDefault<String>(
                          currentUserPhoto,
                          'https://firebasestorage.googleapis.com/v0/b/feebee-4c7b2.firebasestorage.app/o/default_images%2FAdd%20profile%20pic%20(2).png?alt=media&token=4068e21d-193a-45b5-a497-885600aff209',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 0.94,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Text(
                        'Choose subscription',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 24.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: FlutterFlowCheckboxGroup(
                                    options: const ['Free'],
                                    onChanged: (val) => safeSetState(() =>
                                        _model.checkboxGroupValues1 = val),
                                    controller:
                                        _model.checkboxGroupValueController1 ??=
                                            FormFieldController<List<String>>(
                                      [],
                                    ),
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    checkColor:
                                        FlutterFlowTheme.of(context).info,
                                    checkboxBorderColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    unselectedTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                    checkboxBorderRadius:
                                        BorderRadius.circular(20.0),
                                    initialized:
                                        _model.checkboxGroupValues1 != null,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                          ].divide(const SizedBox(height: 5.0)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: FlutterFlowCheckboxGroup(
                                    options: const ['Single school'],
                                    onChanged: (val) => safeSetState(() =>
                                        _model.checkboxGroupValues2 = val),
                                    controller:
                                        _model.checkboxGroupValueController2 ??=
                                            FormFieldController<List<String>>(
                                      [],
                                    ),
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    checkColor:
                                        FlutterFlowTheme.of(context).info,
                                    checkboxBorderColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    unselectedTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                    checkboxBorderRadius:
                                        BorderRadius.circular(20.0),
                                    initialized:
                                        _model.checkboxGroupValues2 != null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  child: Text(
                                    '2,000/month',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                          ].divide(const SizedBox(height: 5.0)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: FlutterFlowCheckboxGroup(
                                    options: const ['Single school'],
                                    onChanged: (val) => safeSetState(() =>
                                        _model.checkboxGroupValues3 = val),
                                    controller:
                                        _model.checkboxGroupValueController3 ??=
                                            FormFieldController<List<String>>(
                                      [],
                                    ),
                                    activeColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    checkColor:
                                        FlutterFlowTheme.of(context).info,
                                    checkboxBorderColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    unselectedTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                    checkboxBorderRadius:
                                        BorderRadius.circular(20.0),
                                    initialized:
                                        _model.checkboxGroupValues3 != null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  child: Text(
                                    '2,000/month',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 12.0,
                                ),
                                Text(
                                  'Subscription features',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 10.0))
                                  .around(const SizedBox(width: 10.0)),
                            ),
                          ].divide(const SizedBox(height: 5.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('SendRequest pressed ...');
                          },
                          text: 'Send Request',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          showLoadingIndicator: false,
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 15.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
