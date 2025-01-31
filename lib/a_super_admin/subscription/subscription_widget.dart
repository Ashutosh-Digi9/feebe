import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/confirmationpages/schoolapproved12/schoolapproved12_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'subscription_model.dart';
export 'subscription_model.dart';

class SubscriptionWidget extends StatefulWidget {
  const SubscriptionWidget({
    super.key,
    required this.schoolRef,
  });

  final DocumentReference? schoolRef;

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  late SubscriptionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscriptionModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().selectedSubscriptionId = 10;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<SubScriptionRecord>>(
      stream: querySubScriptionRecord(
        queryBuilder: (subScriptionRecord) =>
            subScriptionRecord.orderBy('subId'),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<SubScriptionRecord> subscriptionSubScriptionRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).info,
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).bgColor1,
                  size: 28.0,
                ),
              ),
              title: Text(
                'Subscription Plans',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: StreamBuilder<SchoolRecord>(
                stream: SchoolRecord.getDocument(widget.schoolRef!),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }

                  final columnSchoolRecord = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final subscriptionVar =
                                subscriptionSubScriptionRecordList.toList();

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: subscriptionVar.length,
                              itemBuilder: (context, subscriptionVarIndex) {
                                final subscriptionVarItem =
                                    subscriptionVar[subscriptionVarIndex];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: _model.pageno
                                            .contains(subscriptionVarItem.subId)
                                        ? FlutterFlowTheme.of(context).lightblue
                                        : FlutterFlowTheme.of(context)
                                            .secondary,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 4.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    ToggleIcon(
                                                      onPressed: () async {
                                                        safeSetState(
                                                          () => _model.pageno
                                                                  .contains(
                                                                      subscriptionVarItem
                                                                          .subId)
                                                              ? _model.removeFromPageno(
                                                                  subscriptionVarItem
                                                                      .subId)
                                                              : _model.addToPageno(
                                                                  subscriptionVarItem
                                                                      .subId),
                                                        );
                                                        _model.pageno = [10];
                                                        safeSetState(() {});
                                                        FFAppState()
                                                                .selectedSubscriptionId =
                                                            subscriptionVarItem
                                                                .subId;
                                                        FFAppState()
                                                                .subscription =
                                                            SubscribtionDetailsStruct(
                                                          subId:
                                                              subscriptionVarItem
                                                                  .subId,
                                                          subName:
                                                              subscriptionVarItem
                                                                  .name,
                                                          subAmount:
                                                              subscriptionVarItem
                                                                  .amount,
                                                          frequency:
                                                              subscriptionVarItem
                                                                  .frequency,
                                                          startDate:
                                                              getCurrentTimestamp,
                                                          endDate: functions
                                                              .return30day(
                                                                  getCurrentTimestamp),
                                                          subScriptionFeature:
                                                              subscriptionVarItem
                                                                  .featuresList,
                                                        );
                                                        safeSetState(() {});
                                                        _model.addToPageno(
                                                            subscriptionVarItem
                                                                .subId);
                                                        safeSetState(() {});
                                                      },
                                                      value: _model.pageno
                                                          .contains(
                                                              subscriptionVarItem
                                                                  .subId),
                                                      onIcon: Icon(
                                                        Icons.check_box,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 16.0,
                                                      ),
                                                      offIcon: Icon(
                                                        Icons.circle_outlined,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      subscriptionVarItem.name,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                if (subscriptionVarItem.amount >
                                                    0.0)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Text(
                                                      '${subscriptionVarItem.amount.toString()}/${subscriptionVarItem.frequency}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final featuresList =
                                                      subscriptionVarItem
                                                          .featuresList
                                                          .toList();

                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                        featuresList.length,
                                                        (featuresListIndex) {
                                                      final featuresListItem =
                                                          featuresList[
                                                              featuresListIndex];
                                                      return Text(
                                                        '- $featuresListItem',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                      );
                                                    }).divide(
                                                        const SizedBox(height: 2.0)),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 18.9,
                              color: Color(0x0F555555),
                              offset: Offset(
                                0.0,
                                -10.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                10)
                              AuthUserStreamWidget(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    context.goNamed(
                                      'SchoolRejected',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: const TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                        ),
                                      },
                                    );
                                  },
                                  text: 'Reject',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.043,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  showLoadingIndicator: false,
                                ),
                              ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    if (FFAppState().selectedSubscriptionId !=
                                        10) {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Approve school'),
                                                    content: const Text(
                                                        'Are you sure you want to approve this school ?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: const Text('Confirm'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        await widget.schoolRef!
                                            .update(createSchoolRecordData(
                                          schoolStatus: 2,
                                          subscriptionDetails:
                                              updateSubscribtionDetailsStruct(
                                            FFAppState().subscription,
                                            clearUnsetFields: false,
                                          ),
                                          subscriptionStatus:
                                              FFAppState().subscription.subId ==
                                                      0
                                                  ? 2
                                                  : 0,
                                        ));

                                        await columnSchoolRecord
                                            .principalDetails.principalId!
                                            .update(createUsersRecordData(
                                          subcriptiondetails:
                                              updateSubscribtionDetailsStruct(
                                            FFAppState().subscription,
                                            clearUnsetFields: false,
                                          ),
                                          subscriptionStatus:
                                              FFAppState().subscription.subId ==
                                                      0
                                                  ? 2
                                                  : 0,
                                        ));
                                        FFAppState().subscription =
                                            SubscribtionDetailsStruct();
                                        safeSetState(() {});
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment: const AlignmentDirectional(
                                                      0.0, -0.8)
                                                  .resolve(Directionality.of(
                                                      context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: SizedBox(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.08,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.6,
                                                  child:
                                                      const Schoolapproved12Widget(),
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        context.goNamed(
                                          'Dashboard',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Choose subscription',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Select Plan',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.8,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      shadows: [
                                        const Shadow(
                                          color: Color(0x77253EA7),
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 2.0,
                                        ),
                                        const Shadow(
                                          color: Color(0xFF375DFB),
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                        )
                                      ],
                                    ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .divide(const SizedBox(width: 15.0))
                              .around(const SizedBox(width: 15.0)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
