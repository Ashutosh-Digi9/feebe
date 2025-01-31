import '/a_super_admin/edit_school/edit_school_widget.dart';
import '/a_super_admin/teacher_details/teacher_details_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/nobracnhes_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/existingschoolshimmer/existingschoolshimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'existing_school_details_s_a_model.dart';
export 'existing_school_details_s_a_model.dart';

class ExistingSchoolDetailsSAWidget extends StatefulWidget {
  const ExistingSchoolDetailsSAWidget({
    super.key,
    required this.schoolrefMain,
  });

  final DocumentReference? schoolrefMain;

  @override
  State<ExistingSchoolDetailsSAWidget> createState() =>
      _ExistingSchoolDetailsSAWidgetState();
}

class _ExistingSchoolDetailsSAWidgetState
    extends State<ExistingSchoolDetailsSAWidget> {
  late ExistingSchoolDetailsSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExistingSchoolDetailsSAModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimagechanged = false;
      FFAppState().imageurl =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
      FFAppState().schoolimage =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
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

    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.schoolrefMain!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const ExistingschoolshimmerWidget(),
          );
        }

        final existingSchoolDetailsSASchoolRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                context.pushNamed(
                  'AddBranch_SA',
                  queryParameters: {
                    'schoolref': serializeParam(
                      existingSchoolDetailsSASchoolRecord.reference,
                      ParamType.DocumentReference,
                    ),
                    'userref': serializeParam(
                      existingSchoolDetailsSASchoolRecord
                          .principalDetails.principalId,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );
              },
              backgroundColor: FlutterFlowTheme.of(context).primary,
              elevation: 8.0,
              child: Icon(
                Icons.add_rounded,
                color: FlutterFlowTheme.of(context).info,
                size: 24.0,
              ),
            ),
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).info,
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed('Dashboard');
                },
                child: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).bgColor1,
                  size: 28.0,
                ),
              ),
              title: Text(
                'School details',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: Stack(
                  children: [
                    StreamBuilder<UsersRecord>(
                      stream: UsersRecord.getDocument(
                          existingSchoolDetailsSASchoolRecord
                              .principalDetails.principalId!),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              child: const ExistingschoolshimmerWidget(),
                            ),
                          );
                        }

                        final containerUsersRecord = snapshot.data!;

                        return Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 20.0),
                            child: SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (containerUsersRecord
                                                .listofSchool.length !=
                                            existingSchoolDetailsSASchoolRecord
                                                .schoolDetails.noOfBranches)
                                          AutoSizeText(
                                            containerUsersRecord
                                                        .listofSchool.length ==
                                                    existingSchoolDetailsSASchoolRecord
                                                        .schoolDetails
                                                        .noOfBranches
                                                ? 'The school profile is completed'
                                                : 'Please ensure all required details are filled in to complete the school profile',
                                            minFontSize: 10.0,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        if (containerUsersRecord
                                                .listofSchool.length !=
                                            existingSchoolDetailsSASchoolRecord
                                                .schoolDetails.noOfBranches)
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: LinearPercentIndicator(
                                              percent: existingSchoolDetailsSASchoolRecord
                                                          .schoolDetails
                                                          .noOfBranches ==
                                                      0
                                                  ? 0.0
                                                  : functions.calculatePercentage(
                                                      containerUsersRecord
                                                          .listofSchool.length,
                                                      existingSchoolDetailsSASchoolRecord
                                                          .schoolDetails
                                                          .noOfBranches),
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              lineHeight: 20.0,
                                              animation: true,
                                              animateFromLastPercent: true,
                                              progressColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              center: Text(
                                                '${existingSchoolDetailsSASchoolRecord.schoolDetails.noOfBranches == 0 ? '0' : functions.multiplyByhundred(functions.calculatePercentage(containerUsersRecord.listofSchool.length, existingSchoolDetailsSASchoolRecord.schoolDetails.noOfBranches)).toString()} %',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              barRadius: const Radius.circular(10.0),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 12.0, 5.0, 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: const Color(0xFFF2F2F2),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (getCurrentTimestamp >
                                                existingSchoolDetailsSASchoolRecord
                                                    .subscriptionDetails
                                                    .endDate!)
                                              Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.04,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF4CCCC),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.error,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Subscription expired',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 5.0, 0.0, 5.0),
                                                child: Text(
                                                  'Subscription',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 2.0, 5.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    existingSchoolDetailsSASchoolRecord
                                                        .subscriptionDetails
                                                        .subName,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                  if (existingSchoolDetailsSASchoolRecord
                                                          .subscriptionDetails
                                                          .subAmount >
                                                      0.0)
                                                    Text(
                                                      '${existingSchoolDetailsSASchoolRecord.subscriptionDetails.subAmount.toString()}/${existingSchoolDetailsSASchoolRecord.subscriptionDetails.frequency}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            if (existingSchoolDetailsSASchoolRecord
                                                    .subscriptionDetails.subId >
                                                0)
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 5.0, 5.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Amount paid',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                    Text(
                                                      existingSchoolDetailsSASchoolRecord
                                                                  .subscriptionStatus ==
                                                              2
                                                          ? existingSchoolDetailsSASchoolRecord
                                                              .subscriptionDetails
                                                              .subAmount
                                                              .toString()
                                                          : 'Not paid yet',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Start Date',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  Text(
                                                    dateTimeFormat(
                                                        "dd MMM , y",
                                                        existingSchoolDetailsSASchoolRecord
                                                            .subscriptionDetails
                                                            .startDate!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'End Date',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  Text(
                                                    dateTimeFormat(
                                                        "dd MMM , y",
                                                        existingSchoolDetailsSASchoolRecord
                                                            .subscriptionDetails
                                                            .endDate!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  if (existingSchoolDetailsSASchoolRecord
                                                          .subscriptionStatus ==
                                                      1)
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 1.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    15.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            triggerPushNotification(
                                                              notificationTitle:
                                                                  'Change plan',
                                                              notificationText:
                                                                  '${existingSchoolDetailsSASchoolRecord.schoolDetails.schoolName} \'s subscription plan changed',
                                                              userRefs: [
                                                                currentUserReference!
                                                              ],
                                                              initialPageName:
                                                                  'ExistingSchoolDetails_SA',
                                                              parameterData: {
                                                                'schoolrefMain':
                                                                    widget
                                                                        .schoolrefMain,
                                                              },
                                                            );

                                                            await currentUserReference!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'notifications':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    getNotificationFirestoreData(
                                                                      updateNotificationStruct(
                                                                        NotificationStruct(
                                                                          notificationTitle:
                                                                              'Payment update',
                                                                          descriptions:
                                                                              '${existingSchoolDetailsSASchoolRecord.schoolDetails.schoolName} \'s subscription plan changed',
                                                                          timeStamp:
                                                                              getCurrentTimestamp,
                                                                          isRead:
                                                                              false,
                                                                          schoolRef:
                                                                              widget.schoolrefMain,
                                                                        ),
                                                                        clearUnsetFields:
                                                                            false,
                                                                      ),
                                                                      true,
                                                                    )
                                                                  ]),
                                                                },
                                                              ),
                                                            });

                                                            context.pushNamed(
                                                              'ChangeSubscriptionPlan_SA',
                                                              queryParameters: {
                                                                'schoolRef':
                                                                    serializeParam(
                                                                  widget
                                                                      .schoolrefMain,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          text: 'Change Plan',
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.04,
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Color(
                                                                  0xFFEFF0F6),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          showLoadingIndicator:
                                                              false,
                                                        ),
                                                      ),
                                                    ),
                                                  if (existingSchoolDetailsSASchoolRecord
                                                          .subscriptionStatus ==
                                                      1)
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 1.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    15.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            triggerPushNotification(
                                                              notificationTitle:
                                                                  'Send Request',
                                                              notificationText:
                                                                  '${existingSchoolDetailsSASchoolRecord.schoolDetails.schoolName} \'s subscription request sent',
                                                              userRefs: [
                                                                currentUserReference!
                                                              ],
                                                              initialPageName:
                                                                  'ExistingSchoolDetails_SA',
                                                              parameterData: {
                                                                'schoolrefMain':
                                                                    widget
                                                                        .schoolrefMain,
                                                              },
                                                            );

                                                            await currentUserReference!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'notifications':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    getNotificationFirestoreData(
                                                                      updateNotificationStruct(
                                                                        NotificationStruct(
                                                                          notificationTitle:
                                                                              'Payment update',
                                                                          descriptions:
                                                                              '${existingSchoolDetailsSASchoolRecord.schoolDetails.schoolName} \'s subscription request sent',
                                                                          timeStamp:
                                                                              getCurrentTimestamp,
                                                                          isRead:
                                                                              false,
                                                                          schoolRef:
                                                                              widget.schoolrefMain,
                                                                        ),
                                                                        clearUnsetFields:
                                                                            false,
                                                                      ),
                                                                      true,
                                                                    )
                                                                  ]),
                                                                },
                                                              ),
                                                            });

                                                            context.pushNamed(
                                                              'ChangeSubscriptionPlan_SA',
                                                              queryParameters: {
                                                                'schoolRef':
                                                                    serializeParam(
                                                                  widget
                                                                      .schoolrefMain,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          text: 'Send Request',
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.04,
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          showLoadingIndicator:
                                                              false,
                                                        ),
                                                      ),
                                                    ),
                                                  if (((existingSchoolDetailsSASchoolRecord
                                                                  .subscriptionDetails
                                                                  .subAmount >
                                                              0.0) &&
                                                          (existingSchoolDetailsSASchoolRecord
                                                                  .subscriptionStatus ==
                                                              0)) ||
                                                      (existingSchoolDetailsSASchoolRecord
                                                              .subscriptionStatus ==
                                                          3))
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0.0, 1.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    15.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            var confirmDialogResponse =
                                                                await showDialog<
                                                                        bool>(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (alertDialogContext) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Mark as Paid'),
                                                                          content:
                                                                              const Text('are you sure you want to mark this school as paid ?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                              child: const Text('Confirm'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ) ??
                                                                    false;
                                                            if (confirmDialogResponse) {
                                                              await widget
                                                                  .schoolrefMain!
                                                                  .update(
                                                                      createSchoolRecordData(
                                                                subscriptionStatus:
                                                                    2,
                                                              ));

                                                              await existingSchoolDetailsSASchoolRecord
                                                                  .principalDetails
                                                                  .principalId!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                subscriptionStatus:
                                                                    2,
                                                              ));
                                                              triggerPushNotification(
                                                                notificationTitle:
                                                                    'Payment update',
                                                                notificationText:
                                                                    '${existingSchoolDetailsSASchoolRecord.schoolDetails.schoolName} \'s subscription amount is paid',
                                                                userRefs: [
                                                                  currentUserReference!
                                                                ],
                                                                initialPageName:
                                                                    'ExistingSchoolDetails_SA',
                                                                parameterData: {
                                                                  'schoolrefMain':
                                                                      widget
                                                                          .schoolrefMain,
                                                                },
                                                              );

                                                              await currentUserReference!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'notifications':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      getNotificationFirestoreData(
                                                                        updateNotificationStruct(
                                                                          NotificationStruct(
                                                                            notificationTitle:
                                                                                'Payment update',
                                                                            descriptions:
                                                                                '${existingSchoolDetailsSASchoolRecord.schoolDetails.schoolName} \'s subscription amount is paid',
                                                                            timeStamp:
                                                                                getCurrentTimestamp,
                                                                          ),
                                                                          clearUnsetFields:
                                                                              false,
                                                                        ),
                                                                        true,
                                                                      )
                                                                    ]),
                                                                  },
                                                                ),
                                                              });
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'The subscription is successfully marked as paid !!',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          text: 'Mark as paid ',
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.8,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.04,
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              shadows: [
                                                                const Shadow(
                                                                  color: Color(
                                                                      0xFF375DF8),
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          0.0),
                                                                  blurRadius:
                                                                      0.0,
                                                                ),
                                                                const Shadow(
                                                                  color: Color(
                                                                      0x63253EA7),
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      2.0,
                                                                )
                                                              ],
                                                            ),
                                                            elevation: 3.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          showLoadingIndicator:
                                                              false,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ].addToEnd(const SizedBox(height: 10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 5.0, 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: const Color(0xFFF2F2F2),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Contact details',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Container(
                                                    width: 60.0,
                                                    height: 60.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            existingSchoolDetailsSASchoolRecord
                                                                .principalDetails
                                                                .principalImage,
                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png',
                                                          ),
                                                        ).image,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onLongPress: () async {
                                                        await Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                FlutterFlowExpandedImageView(
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  existingSchoolDetailsSASchoolRecord
                                                                      .principalDetails
                                                                      .principalImage,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                ),
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                              allowRotation:
                                                                  false,
                                                              tag:
                                                                  valueOrDefault<
                                                                      String>(
                                                                existingSchoolDetailsSASchoolRecord
                                                                    .principalDetails
                                                                    .principalImage,
                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                              ),
                                                              useHeroAnimation:
                                                                  true,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Hero(
                                                        tag: valueOrDefault<
                                                            String>(
                                                          existingSchoolDetailsSASchoolRecord
                                                              .principalDetails
                                                              .principalImage,
                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                        ),
                                                        transitionOnUserGestures:
                                                            true,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              existingSchoolDetailsSASchoolRecord
                                                                  .principalDetails
                                                                  .principalImage,
                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                            ),
                                                            width: 200.0,
                                                            height: 200.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.38,
                                                  decoration: const BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              existingSchoolDetailsSASchoolRecord
                                                                  .principalDetails
                                                                  .principalName,
                                                              'N/A',
                                                            ),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              existingSchoolDetailsSASchoolRecord
                                                                  .principalDetails
                                                                  .phoneNumber,
                                                              'N/A',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            existingSchoolDetailsSASchoolRecord
                                                                .principalDetails
                                                                .emailId,
                                                            'N/A',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(
                                                              height: 1.0))
                                                          .around(const SizedBox(
                                                              height: 1.0)),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        await launchUrl(Uri(
                                                          scheme: 'tel',
                                                          path: existingSchoolDetailsSASchoolRecord
                                                              .principalDetails
                                                              .phoneNumber,
                                                        ));
                                                      },
                                                      text: 'Contact',
                                                      icon: Icon(
                                                        Icons.call,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 15.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        height: 40.0,
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        iconPadding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: const BorderSide(
                                                          color:
                                                              Color(0xFFEFF0F6),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 40.0),
                                    child: Builder(
                                      builder: (context) {
                                        final branches = containerUsersRecord
                                            .listofSchool
                                            .toList();
                                        if (branches.isEmpty) {
                                          return const NobracnhesWidget();
                                        }

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              branches.length, (branchesIndex) {
                                            final branchesItem =
                                                branches[branchesIndex];
                                            return Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child:
                                                  StreamBuilder<SchoolRecord>(
                                                stream:
                                                    SchoolRecord.getDocument(
                                                        branchesItem),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  final containerSchoolRecord =
                                                      snapshot.data!;

                                                  return InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'class_dashboard',
                                                        queryParameters: {
                                                          'schoolref':
                                                              serializeParam(
                                                            branchesItem,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color:
                                                              const Color(0xFFF2F2F2),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(5.0),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        'School details',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                        (context) =>
                                                                            Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            40.0,
                                                                        buttonSize:
                                                                            40.0,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .more_vert,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          size:
                                                                              20.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await showAlignedDialog(
                                                                            context:
                                                                                context,
                                                                            isGlobal:
                                                                                false,
                                                                            avoidOverflow:
                                                                                false,
                                                                            targetAnchor:
                                                                                const AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                            followerAnchor:
                                                                                const AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                            builder:
                                                                                (dialogContext) {
                                                                              return Material(
                                                                                color: Colors.transparent,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(dialogContext).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: SizedBox(
                                                                                    height: MediaQuery.sizeOf(context).height * 0.1,
                                                                                    width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                    child: EditSchoolWidget(
                                                                                      schoolRef: branchesItem,
                                                                                      mainschoolref: widget.schoolrefMain!,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            15.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            60.0,
                                                                        height:
                                                                            60.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                containerSchoolRecord.schoolDetails.schoolImage,
                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png',
                                                                              ),
                                                                            ).image,
                                                                          ),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            await Navigator.push(
                                                                              context,
                                                                              PageTransition(
                                                                                type: PageTransitionType.fade,
                                                                                child: FlutterFlowExpandedImageView(
                                                                                  image: Image.network(
                                                                                    valueOrDefault<String>(
                                                                                      existingSchoolDetailsSASchoolRecord.schoolDetails.schoolImage,
                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                    ),
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                  allowRotation: false,
                                                                                  tag: valueOrDefault<String>(
                                                                                    existingSchoolDetailsSASchoolRecord.schoolDetails.schoolImage,
                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png' '$branchesIndex',
                                                                                  ),
                                                                                  useHeroAnimation: true,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Hero(
                                                                            tag:
                                                                                valueOrDefault<String>(
                                                                              existingSchoolDetailsSASchoolRecord.schoolDetails.schoolImage,
                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png' '$branchesIndex',
                                                                            ),
                                                                            transitionOnUserGestures:
                                                                                true,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: Image.network(
                                                                                valueOrDefault<String>(
                                                                                  existingSchoolDetailsSASchoolRecord.schoolDetails.schoolImage,
                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                ),
                                                                                width: 200.0,
                                                                                height: 200.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.58,
                                                                              decoration: const BoxDecoration(),
                                                                              child: Text(
                                                                                containerSchoolRecord.schoolDetails.schoolName,
                                                                                maxLines: 2,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Nunito',
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.16,
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              'Address -',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.6,
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                Align(
                                                                              alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                              child: Text(
                                                                                '${containerSchoolRecord.schoolDetails.address} ${containerSchoolRecord.schoolDetails.city} ${containerSchoolRecord.schoolDetails.pincode} ${containerSchoolRecord.schoolDetails.state}',
                                                                                maxLines: 5,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Nunito',
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  'No. of students -',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Nunito',
                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                  child: Text(
                                                                                    containerSchoolRecord.listOfStudents.length.toString(),
                                                                                    maxLines: 5,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(const SizedBox(width: 5.0)),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  'No of employee  - ',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Nunito',
                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                  child: Text(
                                                                                    containerSchoolRecord.schoolDetails.noOfFaculties.toString(),
                                                                                    maxLines: 5,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(const SizedBox(width: 5.0)),
                                                                            ),
                                                                          ),
                                                                          if (!containerSchoolRecord
                                                                              .isBranchPresent)
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  'Branches - ${valueOrDefault<String>(
                                                                                    containerSchoolRecord.schoolDetails.noOfBranches.toString(),
                                                                                    '0',
                                                                                  )}',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Nunito',
                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                ),
                                                                              ].divide(const SizedBox(width: 5.0)),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                                  child: Card(
                                                                    clipBehavior:
                                                                        Clip.antiAliasWithSaveLayer,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    elevation:
                                                                        1.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                6.0,
                                                                                0.0,
                                                                                0.0,
                                                                                6.0),
                                                                            child:
                                                                                Text(
                                                                              'Teachers',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          if (functions
                                                                                  .calculatePercentage(
                                                                                      valueOrDefault<int>(
                                                                                        containerSchoolRecord.teachersDataList.length,
                                                                                        1,
                                                                                      ),
                                                                                      containerSchoolRecord.schoolDetails.noOfFaculties)
                                                                                  .toString() !=
                                                                              '1')
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 10.0),
                                                                              child: Text(
                                                                                'Employee details is incomplete. Please add employee details to complete the profile.',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Nunito',
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    'add_Teacher_manually_Admin',
                                                                                    queryParameters: {
                                                                                      'schoolRef': serializeParam(
                                                                                        branchesItem,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                    extra: <String, dynamic>{
                                                                                      kTransitionInfoKey: const TransitionInfo(
                                                                                        hasTransition: true,
                                                                                        transitionType: PageTransitionType.fade,
                                                                                      ),
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                  decoration: const BoxDecoration(),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                        child: Stack(
                                                                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                          children: [
                                                                                            Container(
                                                                                              width: 50.0,
                                                                                              height: 50.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: const Color(0xFFEADFFF),
                                                                                                image: DecorationImage(
                                                                                                  fit: BoxFit.cover,
                                                                                                  image: Image.asset(
                                                                                                    'assets/images/Generic_avatar.png',
                                                                                                  ).image,
                                                                                                ),
                                                                                                shape: BoxShape.circle,
                                                                                              ),
                                                                                            ),
                                                                                            Align(
                                                                                              alignment: const AlignmentDirectional(1.0, 1.0),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 15.0, 0.0),
                                                                                                child: Icon(
                                                                                                  Icons.add_circle_outline,
                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          'Add employee',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Nunito',
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(const SizedBox(height: 5.0)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              if (existingSchoolDetailsSASchoolRecord.schoolDetails.noOfFaculties != containerSchoolRecord.listOfTeachers.length)
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                  child: CircularPercentIndicator(
                                                                                    percent: containerSchoolRecord.teachersDataList.isNotEmpty ? functions.calculatePercentage(containerSchoolRecord.listOfTeachers.length, containerSchoolRecord.schoolDetails.noOfFaculties) : 0.0,
                                                                                    radius: 35.0,
                                                                                    lineWidth: 12.0,
                                                                                    animation: true,
                                                                                    animateFromLastPercent: true,
                                                                                    progressColor: FlutterFlowTheme.of(context).primary,
                                                                                    backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                    center: Text(
                                                                                      '${containerSchoolRecord.teachersDataList.isNotEmpty ? functions.multiplyByhundred(functions.calculatePercentage(containerSchoolRecord.listOfTeachers.length, containerSchoolRecord.schoolDetails.noOfFaculties)).toString() : '0'} %',
                                                                                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            fontSize: 18.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    startAngle: 10.0,
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                          if (existingSchoolDetailsSASchoolRecord
                                                                              .teachersDataList
                                                                              .isNotEmpty)
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final teachersSchool = containerSchoolRecord.teachersDataList.toList();

                                                                                  return GridView.builder(
                                                                                    padding: const EdgeInsets.fromLTRB(
                                                                                      0,
                                                                                      0,
                                                                                      0,
                                                                                      10.0,
                                                                                    ),
                                                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                                      crossAxisCount: 4,
                                                                                      crossAxisSpacing: 20.0,
                                                                                      mainAxisSpacing: 10.0,
                                                                                      childAspectRatio: 0.7,
                                                                                    ),
                                                                                    primary: false,
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    itemCount: teachersSchool.length,
                                                                                    itemBuilder: (context, teachersSchoolIndex) {
                                                                                      final teachersSchoolItem = teachersSchool[teachersSchoolIndex];
                                                                                      return InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          await showModalBottomSheet(
                                                                                            isScrollControlled: true,
                                                                                            backgroundColor: Colors.transparent,
                                                                                            useSafeArea: true,
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return GestureDetector(
                                                                                                onTap: () {
                                                                                                  FocusScope.of(context).unfocus();
                                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                                },
                                                                                                child: Padding(
                                                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                                                  child: SizedBox(
                                                                                                    height: MediaQuery.sizeOf(context).height * 0.25,
                                                                                                    child: TeacherDetailsWidget(
                                                                                                      teacherref: teachersSchoolItem.teachersId!,
                                                                                                      schoolref: branchesItem,
                                                                                                      mainschoolref: widget.schoolrefMain!,
                                                                                                      teacher: teachersSchoolItem,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          ).then((value) => safeSetState(() {}));
                                                                                        },
                                                                                        child: Container(
                                                                                          decoration: const BoxDecoration(),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                                child: Container(
                                                                                                  width: 60.0,
                                                                                                  height: 60.0,
                                                                                                  decoration: const BoxDecoration(
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      await showModalBottomSheet(
                                                                                                        isScrollControlled: true,
                                                                                                        backgroundColor: Colors.transparent,
                                                                                                        useSafeArea: true,
                                                                                                        context: context,
                                                                                                        builder: (context) {
                                                                                                          return GestureDetector(
                                                                                                            onTap: () {
                                                                                                              FocusScope.of(context).unfocus();
                                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                                            },
                                                                                                            child: Padding(
                                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                                              child: SizedBox(
                                                                                                                height: MediaQuery.sizeOf(context).height * 0.25,
                                                                                                                child: TeacherDetailsWidget(
                                                                                                                  teacherref: teachersSchoolItem.teachersId!,
                                                                                                                  schoolref: branchesItem,
                                                                                                                  mainschoolref: widget.schoolrefMain!,
                                                                                                                  teacher: teachersSchoolItem,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                      ).then((value) => safeSetState(() {}));
                                                                                                    },
                                                                                                    onLongPress: () async {
                                                                                                      await Navigator.push(
                                                                                                        context,
                                                                                                        PageTransition(
                                                                                                          type: PageTransitionType.fade,
                                                                                                          child: FlutterFlowExpandedImageView(
                                                                                                            image: Image.network(
                                                                                                              valueOrDefault<String>(
                                                                                                                teachersSchoolItem.teacherImage,
                                                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                                              ),
                                                                                                              fit: BoxFit.contain,
                                                                                                            ),
                                                                                                            allowRotation: false,
                                                                                                            tag: valueOrDefault<String>(
                                                                                                              teachersSchoolItem.teacherImage,
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png' '$teachersSchoolIndex',
                                                                                                            ),
                                                                                                            useHeroAnimation: true,
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                    child: Hero(
                                                                                                      tag: valueOrDefault<String>(
                                                                                                        teachersSchoolItem.teacherImage,
                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png' '$teachersSchoolIndex',
                                                                                                      ),
                                                                                                      transitionOnUserGestures: true,
                                                                                                      child: ClipRRect(
                                                                                                        borderRadius: BorderRadius.circular(30.0),
                                                                                                        child: Image.network(
                                                                                                          valueOrDefault<String>(
                                                                                                            teachersSchoolItem.teacherImage,
                                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                                          ),
                                                                                                          width: 200.0,
                                                                                                          height: 200.0,
                                                                                                          fit: BoxFit.fill,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                                child: AutoSizeText(
                                                                                                  teachersSchoolItem.teacherName,
                                                                                                  minFontSize: 11.0,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
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
                                                                        ].addToEnd(const SizedBox(height: 5.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
