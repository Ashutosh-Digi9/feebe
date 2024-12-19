import '/a_super_admin/requestsent_s_a/requestsent_s_a_widget.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/notifications_shimmer/notifications_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'change_subscription_plan_s_a_model.dart';
export 'change_subscription_plan_s_a_model.dart';

class ChangeSubscriptionPlanSAWidget extends StatefulWidget {
  const ChangeSubscriptionPlanSAWidget({
    super.key,
    required this.schoolRef,
  });

  final DocumentReference? schoolRef;

  @override
  State<ChangeSubscriptionPlanSAWidget> createState() =>
      _ChangeSubscriptionPlanSAWidgetState();
}

class _ChangeSubscriptionPlanSAWidgetState
    extends State<ChangeSubscriptionPlanSAWidget> {
  late ChangeSubscriptionPlanSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangeSubscriptionPlanSAModel());

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
      stream: querySubScriptionRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
            body: const NotificationsShimmerWidget(),
          );
        }
        List<SubScriptionRecord>
            changeSubscriptionPlanSASubScriptionRecordList = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).info,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Color(0x58001B36),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Subscription plans',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 2.0,
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
                                changeSubscriptionPlanSASubScriptionRecordList
                                    .toList();

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: subscriptionVar.length,
                              itemBuilder: (context, subscriptionVarIndex) {
                                final subscriptionVarItem =
                                    subscriptionVar[subscriptionVarIndex];
                                return Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ToggleIcon(
                                                  onPressed: () async {
                                                    safeSetState(
                                                      () => _model.pageno.contains(
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
                                                    FFAppState().subscription =
                                                        SubscribtionDetailsStruct(
                                                      subId: subscriptionVarItem
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
                                                      endDate:
                                                          functions.return30day(
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
                                                  value: _model.pageno.contains(
                                                      subscriptionVarItem
                                                          .subId),
                                                  onIcon: Icon(
                                                    Icons.check_box,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                  offIcon: Icon(
                                                    Icons.circle_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    size: 24.0,
                                                  ),
                                                ),
                                                Text(
                                                  subscriptionVarItem.name,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  '${subscriptionVarItem.amount.toString()}/${subscriptionVarItem.frequency}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
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
                                                      CrossAxisAlignment.start,
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
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    );
                                                  }),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(1.0, -1.0),
                                child: Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      if (FFAppState().selectedSubscriptionId !=
                                          10) {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('Change Plan !'),
                                                      content: const Text(
                                                          'Are you sure you want to send request to this school ?'),
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
                                                          child:
                                                              const Text('Confirm'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ) ??
                                                false;
                                        if (confirmDialogResponse) {
                                          await columnSchoolRecord.reference
                                              .update(createSchoolRecordData(
                                            subscriptionDetails:
                                                updateSubscribtionDetailsStruct(
                                              FFAppState().subscription,
                                              clearUnsetFields: false,
                                            ),
                                            subscriptionStatus: FFAppState()
                                                        .subscription
                                                        .subId ==
                                                    0
                                                ? 2
                                                : 3,
                                          ));

                                          await columnSchoolRecord
                                              .principalDetails.principalId!
                                              .update(createUsersRecordData(
                                            subcriptiondetails:
                                                updateSubscribtionDetailsStruct(
                                              FFAppState().subscription,
                                              clearUnsetFields: false,
                                            ),
                                            subscriptionStatus: FFAppState()
                                                        .subscription
                                                        .subId ==
                                                    0
                                                ? 2
                                                : 3,
                                          ));
                                          FFAppState().subscription =
                                              SubscribtionDetailsStruct();
                                          safeSetState(() {});
                                          await showAlignedDialog(
                                            context: context,
                                            isGlobal: false,
                                            avoidOverflow: true,
                                            targetAnchor: const AlignmentDirectional(
                                                    0.0, 1.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            followerAnchor:
                                                const AlignmentDirectional(0.0, 1.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                            builder: (dialogContext) {
                                              return Material(
                                                color: Colors.transparent,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: const RequestsentSAWidget(),
                                                ),
                                              );
                                            },
                                          );

                                          triggerPushNotification(
                                            notificationTitle:
                                                ' change in subscription plan',
                                            notificationText:
                                                'Your subscription plan has changed.  Make a payment and continue to use the app.',
                                            notificationSound: 'default',
                                            userRefs: [
                                              columnSchoolRecord
                                                  .principalDetails.principalId!
                                            ],
                                            initialPageName:
                                                'Notification_admin',
                                            parameterData: {
                                              'schoolref':
                                                  columnSchoolRecord.reference,
                                            },
                                          );

                                          await columnSchoolRecord
                                              .principalDetails.principalId!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'notifications':
                                                    FieldValue.arrayUnion([
                                                  getNotificationFirestoreData(
                                                    updateNotificationStruct(
                                                      NotificationStruct(
                                                        notificationTitle:
                                                            'change in subscription plan',
                                                        descriptions:
                                                            'Your subscription plan has changed.  Make a payment and continue to use the app',
                                                        timeStamp:
                                                            getCurrentTimestamp,
                                                      ),
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });

                                          context.goNamed(
                                            'ExistingSchoolDetails_SA',
                                            queryParameters: {
                                              'schoolrefMain': serializeParam(
                                                widget.schoolRef,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please choose subscription',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                const Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }
                                    },
                                    text: 'Send Request',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.05,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
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
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                                .divide(const SizedBox(width: 15.0))
                                .around(const SizedBox(width: 15.0)),
                          ),
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
