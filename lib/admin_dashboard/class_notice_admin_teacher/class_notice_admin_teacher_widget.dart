import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/confirmationpages/noticecreated_copy/noticecreated_copy_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/shimmer_effects/addclasss_shimmer/addclasss_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'class_notice_admin_teacher_model.dart';
export 'class_notice_admin_teacher_model.dart';

class ClassNoticeAdminTeacherWidget extends StatefulWidget {
  const ClassNoticeAdminTeacherWidget({
    super.key,
    required this.classref,
    required this.schoolref,
    bool? notice,
    bool? studentpage,
  })  : this.notice = notice ?? false,
        this.studentpage = studentpage ?? false;

  final DocumentReference? classref;
  final DocumentReference? schoolref;
  final bool notice;
  final bool studentpage;

  static String routeName = 'ClassNotice_Admin_Teacher';
  static String routePath = '/classNoticeAdminTeacher';

  @override
  State<ClassNoticeAdminTeacherWidget> createState() =>
      _ClassNoticeAdminTeacherWidgetState();
}

class _ClassNoticeAdminTeacherWidgetState
    extends State<ClassNoticeAdminTeacherWidget> {
  late ClassNoticeAdminTeacherModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassNoticeAdminTeacherModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.date = getCurrentTimestamp;
      _model.noticename = 'General';
      _model.addToClassref(widget.classref!);
      safeSetState(() {});
      FFAppState().eventfiles = [];
      safeSetState(() {});
    });

    _model.eventnameTextController ??= TextEditingController();
    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<SchoolClassRecord>(
      stream: SchoolClassRecord.getDocument(widget.classref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: AddclasssShimmerWidget(),
          );
        }

        final classNoticeAdminTeacherSchoolClassRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            appBar: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            )
                ? AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).info,
                    automaticallyImplyLeading: false,
                    leading: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).bgColor1,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        if ((_model.eventnameTextController.text != '') ||
                            (_model.descriptionTextController.text != '')) {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title:
                                        Text('Are you sure you want to leave.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            FFAppState().eventfiles = [];
                            safeSetState(() {});
                            if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                3) {
                              if (widget.notice == true) {
                                context.goNamed(
                                  DashboardWidget.routeName,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              } else {
                                if (widget.studentpage == true) {
                                  context.safePop();
                                } else {
                                  context.pushNamed(
                                    ClassViewWidget.routeName,
                                    queryParameters: {
                                      'schoolclassref': serializeParam(
                                        classNoticeAdminTeacherSchoolClassRecord
                                            .reference,
                                        ParamType.DocumentReference,
                                      ),
                                      'schoolref': serializeParam(
                                        widget.schoolref,
                                        ParamType.DocumentReference,
                                      ),
                                      'datePick': serializeParam(
                                        getCurrentTimestamp,
                                        ParamType.DateTime,
                                      ),
                                    }.withoutNulls,
                                  );
                                }
                              }
                            } else {
                              if (widget.notice == true) {
                                context.goNamed(
                                  ClassDashboardWidget.routeName,
                                  queryParameters: {
                                    'schoolref': serializeParam(
                                      widget.schoolref,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              } else {
                                if (widget.studentpage == true) {
                                  context.safePop();
                                } else {
                                  context.pushNamed(
                                    ClassViewWidget.routeName,
                                    queryParameters: {
                                      'schoolclassref': serializeParam(
                                        classNoticeAdminTeacherSchoolClassRecord
                                            .reference,
                                        ParamType.DocumentReference,
                                      ),
                                      'schoolref': serializeParam(
                                        widget.schoolref,
                                        ParamType.DocumentReference,
                                      ),
                                      'datePick': serializeParam(
                                        getCurrentTimestamp,
                                        ParamType.DateTime,
                                      ),
                                    }.withoutNulls,
                                  );
                                }
                              }
                            }
                          }
                        } else {
                          FFAppState().eventfiles = [];
                          safeSetState(() {});
                          if (valueOrDefault(
                                  currentUserDocument?.userRole, 0) ==
                              3) {
                            if (widget.notice == true) {
                              context.goNamed(
                                DashboardWidget.routeName,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                  ),
                                },
                              );
                            } else {
                              if (widget.studentpage == true) {
                                context.safePop();
                              } else {
                                context.pushNamed(
                                  ClassViewWidget.routeName,
                                  queryParameters: {
                                    'schoolclassref': serializeParam(
                                      classNoticeAdminTeacherSchoolClassRecord
                                          .reference,
                                      ParamType.DocumentReference,
                                    ),
                                    'schoolref': serializeParam(
                                      widget.schoolref,
                                      ParamType.DocumentReference,
                                    ),
                                    'datePick': serializeParam(
                                      getCurrentTimestamp,
                                      ParamType.DateTime,
                                    ),
                                  }.withoutNulls,
                                );
                              }
                            }
                          } else {
                            if (widget.notice == true) {
                              context.goNamed(
                                ClassDashboardWidget.routeName,
                                queryParameters: {
                                  'schoolref': serializeParam(
                                    widget.schoolref,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                  ),
                                },
                              );
                            } else {
                              if (widget.studentpage == true) {
                                context.safePop();
                              } else {
                                context.pushNamed(
                                  ClassViewWidget.routeName,
                                  queryParameters: {
                                    'schoolclassref': serializeParam(
                                      classNoticeAdminTeacherSchoolClassRecord
                                          .reference,
                                      ParamType.DocumentReference,
                                    ),
                                    'schoolref': serializeParam(
                                      widget.schoolref,
                                      ParamType.DocumentReference,
                                    ),
                                    'datePick': serializeParam(
                                      getCurrentTimestamp,
                                      ParamType.DateTime,
                                    ),
                                  }.withoutNulls,
                                );
                              }
                            }
                          }
                        }
                      },
                    ),
                    title: Text(
                      '${classNoticeAdminTeacherSchoolClassRecord.className} Class Notice',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.nunito(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                    ),
                    actions: [],
                    centerTitle: false,
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    decoration: BoxDecoration(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!functions.isDatePassed(_model.date!) &&
                              (valueOrDefault(
                                      currentUserDocument?.userRole, 0) !=
                                  1))
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Color(0xFFF2F2F2),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'New Notice',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.9,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.noticename = 'General';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .event,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.59),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .generalBorder,
                                                      width:
                                                          _model.noticename ==
                                                                  'General'
                                                              ? 3.0
                                                              : 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                          width: 15.5,
                                                          height: 15.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Text(
                                                          'General',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              width: 3.0))
                                                          .around(SizedBox(
                                                              width: 3.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.noticename =
                                                      'Reminder';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .reminderfill,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.59),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .reminderborder,
                                                      width:
                                                          _model.noticename ==
                                                                  'Reminder'
                                                              ? 3.0
                                                              : 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/3d-alarm.png',
                                                          width: 15.5,
                                                          height: 15.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Text(
                                                          'Reminder',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              width: 3.0))
                                                          .around(SizedBox(
                                                              width: 3.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.noticename =
                                                      'Homework';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .homework,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.59),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .homeworkborder,
                                                      width:
                                                          _model.noticename ==
                                                                  'Homework'
                                                              ? 3.0
                                                              : 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                          width: 15.5,
                                                          height: 15.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Text(
                                                          'Homework',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              width: 3.0))
                                                          .around(SizedBox(
                                                              width: 3.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                        ),
                                        Form(
                                          key: _model.formKey,
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 10.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .eventnameTextController,
                                                    focusNode: _model
                                                        .eventnameFocusNode,
                                                    autofocus: false,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText: 'Title *',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  (_model.eventnameFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .textfieldText,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldText,
                                                                ),
                                                                fontSize: (_model
                                                                            .eventnameFocusNode
                                                                            ?.hasFocus ??
                                                                        false)
                                                                    ? 12.0
                                                                    : 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText: 'Title',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .textfieldText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .textfieldDisable,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .text2,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                    maxLength: 25,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .eventnameTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      if (!isAndroid && !isiOS)
                                                        TextInputFormatter
                                                            .withFunction(
                                                                (oldValue,
                                                                    newValue) {
                                                          return TextEditingValue(
                                                            selection: newValue
                                                                .selection,
                                                            text: newValue.text
                                                                .toCapitalization(
                                                                    TextCapitalization
                                                                        .sentences),
                                                          );
                                                        }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 10.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .descriptionTextController,
                                                    focusNode: _model
                                                        .descriptionFocusNode,
                                                    onFieldSubmitted:
                                                        (_) async {
                                                      _model.last = true;
                                                      safeSetState(() {});
                                                    },
                                                    autofocus: false,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText: 'Description ',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  (_model.descriptionFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .textfieldText,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldText,
                                                                ),
                                                                fontSize: (_model
                                                                            .descriptionFocusNode
                                                                            ?.hasFocus ??
                                                                        false)
                                                                    ? 12.0
                                                                    : 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText: 'Description',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .textfieldText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .textfieldDisable,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .text2,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                    maxLines: 4,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .descriptionTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      if (!isAndroid && !isiOS)
                                                        TextInputFormatter
                                                            .withFunction(
                                                                (oldValue,
                                                                    newValue) {
                                                          return TextEditingValue(
                                                            selection: newValue
                                                                .selection,
                                                            text: newValue.text
                                                                .toCapitalization(
                                                                    TextCapitalization
                                                                        .sentences),
                                                          );
                                                        }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Builder(
                                            builder: (context) {
                                              final imagesview = FFAppState()
                                                  .eventfiles
                                                  .toList();

                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    imagesview.length,
                                                    (imagesviewIndex) {
                                                  final imagesviewItem =
                                                      imagesview[
                                                          imagesviewIndex];
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if (functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          1)
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/download.png',
                                                              width: 46.0,
                                                              height: 41.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      if (functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          2)
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/download_(1).png',
                                                              width: 46.0,
                                                              height: 41.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      if (functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          3)
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/download_(2).png',
                                                              width: 46.0,
                                                              height: 41.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      if (functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          4)
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/clarity_image-gallery-line.png',
                                                              width: 46.0,
                                                              height: 41.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      if (functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          5)
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/download-removebg-preview.png',
                                                              width: 46.0,
                                                              height: 41.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                    ]
                                                        .divide(SizedBox(
                                                            width: 5.0))
                                                        .around(SizedBox(
                                                            width: 5.0)),
                                                  );
                                                }),
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FlutterFlowIconButton(
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .stroke,
                                                borderRadius: 10.0,
                                                borderWidth: 1.0,
                                                buttonSize: 50.0,
                                                icon: Icon(
                                                  Icons.attach_file,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  size: 18.0,
                                                ),
                                                showLoadingIndicator: true,
                                                onPressed: () async {
                                                  safeSetState(() {
                                                    _model.isDataUploading_uploadDataTse =
                                                        false;
                                                    _model.uploadedLocalFiles_uploadDataTse =
                                                        [];
                                                    _model.uploadedFileUrls_uploadDataTse =
                                                        [];
                                                  });

                                                  final selectedFiles =
                                                      await selectFiles(
                                                    multiFile: true,
                                                  );
                                                  if (selectedFiles != null) {
                                                    safeSetState(() => _model
                                                            .isDataUploading_uploadDataTse =
                                                        true);
                                                    var selectedUploadedFiles =
                                                        <FFUploadedFile>[];

                                                    var downloadUrls =
                                                        <String>[];
                                                    try {
                                                      selectedUploadedFiles =
                                                          selectedFiles
                                                              .map((m) =>
                                                                  FFUploadedFile(
                                                                    name: m
                                                                        .storagePath
                                                                        .split(
                                                                            '/')
                                                                        .last,
                                                                    bytes:
                                                                        m.bytes,
                                                                  ))
                                                              .toList();

                                                      downloadUrls =
                                                          (await Future.wait(
                                                        selectedFiles.map(
                                                          (f) async =>
                                                              await uploadData(
                                                                  f.storagePath,
                                                                  f.bytes),
                                                        ),
                                                      ))
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      _model.isDataUploading_uploadDataTse =
                                                          false;
                                                    }
                                                    if (selectedUploadedFiles
                                                                .length ==
                                                            selectedFiles
                                                                .length &&
                                                        downloadUrls.length ==
                                                            selectedFiles
                                                                .length) {
                                                      safeSetState(() {
                                                        _model.uploadedLocalFiles_uploadDataTse =
                                                            selectedUploadedFiles;
                                                        _model.uploadedFileUrls_uploadDataTse =
                                                            downloadUrls;
                                                      });
                                                    } else {
                                                      safeSetState(() {});
                                                      return;
                                                    }
                                                  }

                                                  if (_model
                                                          .uploadedFileUrls_uploadDataTse
                                                          .length !=
                                                      0) {
                                                    if (functions
                                                        .isValidFileFormatCopy(
                                                            _model
                                                                .uploadedFileUrls_uploadDataTse
                                                                .toList())) {
                                                      FFAppState().eventfiles = functions
                                                          .combineImagePathsCopy(
                                                              FFAppState()
                                                                  .eventfiles
                                                                  .toList(),
                                                              _model
                                                                  .uploadedFileUrls_uploadDataTse
                                                                  .toList())
                                                          .toList()
                                                          .cast<String>();
                                                      safeSetState(() {});
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'only pdf , docx , jpeg , png , jpg , mp3, ppt , pptx files are allowed ',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  1400),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                              ),
                                              FlutterFlowIconButton(
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .stroke,
                                                borderRadius: 10.0,
                                                borderWidth: 1.0,
                                                buttonSize: 50.0,
                                                icon: Icon(
                                                  Icons.photo_camera_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  size: 18.0,
                                                ),
                                                showLoadingIndicator: true,
                                                onPressed: () async {
                                                  safeSetState(() {
                                                    _model.isDataUploading_uploadData8yc =
                                                        false;
                                                    _model.uploadedLocalFile_uploadData8yc =
                                                        FFUploadedFile(
                                                            bytes: Uint8List
                                                                .fromList([]));
                                                    _model.uploadedFileUrl_uploadData8yc =
                                                        '';
                                                  });

                                                  final selectedMedia =
                                                      await selectMedia(
                                                    imageQuality: 10,
                                                    multiImage: false,
                                                  );
                                                  if (selectedMedia != null &&
                                                      selectedMedia.every((m) =>
                                                          validateFileFormat(
                                                              m.storagePath,
                                                              context))) {
                                                    safeSetState(() => _model
                                                            .isDataUploading_uploadData8yc =
                                                        true);
                                                    var selectedUploadedFiles =
                                                        <FFUploadedFile>[];

                                                    var downloadUrls =
                                                        <String>[];
                                                    try {
                                                      selectedUploadedFiles =
                                                          selectedMedia
                                                              .map((m) =>
                                                                  FFUploadedFile(
                                                                    name: m
                                                                        .storagePath
                                                                        .split(
                                                                            '/')
                                                                        .last,
                                                                    bytes:
                                                                        m.bytes,
                                                                    height: m
                                                                        .dimensions
                                                                        ?.height,
                                                                    width: m
                                                                        .dimensions
                                                                        ?.width,
                                                                    blurHash: m
                                                                        .blurHash,
                                                                  ))
                                                              .toList();

                                                      downloadUrls =
                                                          (await Future.wait(
                                                        selectedMedia.map(
                                                          (m) async =>
                                                              await uploadData(
                                                                  m.storagePath,
                                                                  m.bytes),
                                                        ),
                                                      ))
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      _model.isDataUploading_uploadData8yc =
                                                          false;
                                                    }
                                                    if (selectedUploadedFiles
                                                                .length ==
                                                            selectedMedia
                                                                .length &&
                                                        downloadUrls.length ==
                                                            selectedMedia
                                                                .length) {
                                                      safeSetState(() {
                                                        _model.uploadedLocalFile_uploadData8yc =
                                                            selectedUploadedFiles
                                                                .first;
                                                        _model.uploadedFileUrl_uploadData8yc =
                                                            downloadUrls.first;
                                                      });
                                                    } else {
                                                      safeSetState(() {});
                                                      return;
                                                    }
                                                  }

                                                  if (_model.uploadedFileUrl_uploadData8yc !=
                                                          '') {
                                                    FFAppState()
                                                        .addToEventfiles(_model
                                                            .uploadedFileUrl_uploadData8yc);
                                                    safeSetState(() {});
                                                  }
                                                },
                                              ),
                                              Builder(
                                                builder: (context) =>
                                                    FFButtonWidget(
                                                  onPressed: () async {
                                                    _model.id = functions
                                                        .generateUniqueId();
                                                    safeSetState(() {});
                                                    if (_model.formKey
                                                                .currentState ==
                                                            null ||
                                                        !_model.formKey
                                                            .currentState!
                                                            .validate()) {
                                                      return;
                                                    }
                                                    if (_model.noticename !=
                                                            '') {
                                                      if (FFAppState()
                                                              .eventfiles
                                                              .length ==
                                                          0) {
                                                        await widget.classref!
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'notice': FieldValue
                                                                  .arrayUnion([
                                                                getEventsNoticeFirestoreData(
                                                                  createEventsNoticeStruct(
                                                                    eventId:
                                                                        _model
                                                                            .id,
                                                                    eventName:
                                                                        _model
                                                                            .noticename,
                                                                    eventTitle: _model
                                                                        .eventnameTextController
                                                                        .text,
                                                                    eventDescription:
                                                                        _model
                                                                            .descriptionTextController
                                                                            .text,
                                                                    eventDate:
                                                                        _model
                                                                            .date,
                                                                    fieldValues: {
                                                                      'classref':
                                                                          _model
                                                                              .classref,
                                                                    },
                                                                    clearUnsetFields:
                                                                        false,
                                                                  ),
                                                                  true,
                                                                )
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                      } else {
                                                        await widget.classref!
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'notice': FieldValue
                                                                  .arrayUnion([
                                                                getEventsNoticeFirestoreData(
                                                                  createEventsNoticeStruct(
                                                                    eventId:
                                                                        _model
                                                                            .id,
                                                                    eventName:
                                                                        _model
                                                                            .noticename,
                                                                    eventTitle: _model
                                                                        .eventnameTextController
                                                                        .text,
                                                                    eventDescription:
                                                                        _model
                                                                            .descriptionTextController
                                                                            .text,
                                                                    eventDate:
                                                                        _model
                                                                            .date,
                                                                    fieldValues: {
                                                                      'classref':
                                                                          _model
                                                                              .classref,
                                                                      'eventfiles':
                                                                          FFAppState()
                                                                              .eventfiles,
                                                                    },
                                                                    clearUnsetFields:
                                                                        false,
                                                                  ),
                                                                  true,
                                                                )
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                      }

                                                      await widget.schoolref!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'List_of_notice':
                                                                FieldValue
                                                                    .arrayUnion([
                                                              getEventsNoticeFirestoreData(
                                                                createEventsNoticeStruct(
                                                                  eventId:
                                                                      _model.id,
                                                                  eventName: _model
                                                                      .noticename,
                                                                  eventTitle: _model
                                                                      .eventnameTextController
                                                                      .text,
                                                                  eventDescription:
                                                                      _model
                                                                          .descriptionTextController
                                                                          .text,
                                                                  eventDate:
                                                                      _model
                                                                          .date,
                                                                  fieldValues: {
                                                                    'eventfiles':
                                                                        FFAppState()
                                                                            .eventfiles,
                                                                    'classref':
                                                                        _model
                                                                            .classref,
                                                                  },
                                                                  clearUnsetFields:
                                                                      false,
                                                                ),
                                                                true,
                                                              )
                                                            ]),
                                                          },
                                                        ),
                                                      });
                                                      _model.students =
                                                          await queryStudentsRecordOnce();
                                                      triggerPushNotification(
                                                        notificationTitle:
                                                            'Notice',
                                                        notificationText: _model
                                                            .eventnameTextController
                                                            .text,
                                                        userRefs: functions
                                                            .extractParentUserRefs(_model
                                                                .students!
                                                                .where((e) => classNoticeAdminTeacherSchoolClassRecord
                                                                    .studentsList
                                                                    .contains(e
                                                                        .reference))
                                                                .toList())
                                                            .toList(),
                                                        initialPageName:
                                                            'Dashboard',
                                                        parameterData: {},
                                                      );

                                                      await NotificationsRecord
                                                          .collection
                                                          .doc()
                                                          .set({
                                                        ...createNotificationsRecordData(
                                                          content: _model
                                                              .eventnameTextController
                                                              .text,
                                                          descri: _model
                                                              .descriptionTextController
                                                              .text,
                                                          datetimeofevent:
                                                              _model.date,
                                                          isread: false,
                                                          notification:
                                                              updateNotificationStruct(
                                                            NotificationStruct(
                                                              notificationTitle:
                                                                  _model
                                                                      .eventnameTextController
                                                                      .text,
                                                              descriptions: _model
                                                                  .descriptionTextController
                                                                  .text,
                                                              timeStamp:
                                                                  getCurrentTimestamp,
                                                              isRead: false,
                                                              eventDate:
                                                                  _model.date,
                                                              notificationFiles:
                                                                  FFAppState()
                                                                      .eventfiles,
                                                            ),
                                                            clearUnsetFields:
                                                                false,
                                                            create: true,
                                                          ),
                                                          createDate:
                                                              getCurrentTimestamp,
                                                          addedby:
                                                              currentUserReference,
                                                          tag:
                                                              _model.noticename,
                                                          heading:
                                                              'Posted a notice',
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'userref': functions
                                                                .extractParentUserRefs(_model
                                                                    .students!
                                                                    .where((e) => classNoticeAdminTeacherSchoolClassRecord
                                                                        .studentsList
                                                                        .contains(
                                                                            e.reference))
                                                                    .toList()),
                                                            'towhome': [
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .className
                                                            ],
                                                          },
                                                        ),
                                                      });
                                                      triggerPushNotification(
                                                        notificationTitle:
                                                            'Notice',
                                                        notificationText: _model
                                                            .eventnameTextController
                                                            .text,
                                                        userRefs:
                                                            classNoticeAdminTeacherSchoolClassRecord
                                                                .listOfteachersUser
                                                                .toList(),
                                                        initialPageName:
                                                            'Dashboard',
                                                        parameterData: {},
                                                      );

                                                      await NotificationsRecord
                                                          .collection
                                                          .doc()
                                                          .set({
                                                        ...createNotificationsRecordData(
                                                          content: _model
                                                              .eventnameTextController
                                                              .text,
                                                          descri: _model
                                                              .descriptionTextController
                                                              .text,
                                                          datetimeofevent:
                                                              _model.date,
                                                          isread: false,
                                                          notification:
                                                              updateNotificationStruct(
                                                            NotificationStruct(
                                                              notificationTitle:
                                                                  _model
                                                                      .eventnameTextController
                                                                      .text,
                                                              descriptions: _model
                                                                  .descriptionTextController
                                                                  .text,
                                                              timeStamp:
                                                                  getCurrentTimestamp,
                                                              isRead: false,
                                                              eventDate:
                                                                  _model.date,
                                                              notificationFiles:
                                                                  FFAppState()
                                                                      .eventfiles,
                                                            ),
                                                            clearUnsetFields:
                                                                false,
                                                            create: true,
                                                          ),
                                                          createDate:
                                                              getCurrentTimestamp,
                                                          tag:
                                                              _model.noticename,
                                                          addedby:
                                                              currentUserReference,
                                                          heading:
                                                              'Posted a notice',
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'userref':
                                                                classNoticeAdminTeacherSchoolClassRecord
                                                                    .listOfteachersUser,
                                                            'towhome': [
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .className
                                                            ],
                                                          },
                                                        ),
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Notice Added!',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  3100),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                        ),
                                                      );
                                                      if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.userRole,
                                                              0) ==
                                                          2) {
                                                        safeSetState(() {
                                                          _model
                                                              .eventnameTextController
                                                              ?.clear();
                                                          _model
                                                              .descriptionTextController
                                                              ?.clear();
                                                        });
                                                        FFAppState()
                                                            .eventfiles = [];
                                                        safeSetState(() {});
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              alignment: AlignmentDirectional(
                                                                      0.0, -0.8)
                                                                  .resolve(
                                                                      Directionality.of(
                                                                          context)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          dialogContext)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.08,
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.6,
                                                                  child:
                                                                      NoticecreatedCopyWidget(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );

                                                        if (Navigator.of(
                                                                context)
                                                            .canPop()) {
                                                          context.pop();
                                                        }
                                                        context.pushNamed(
                                                          ClassViewWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'datePick':
                                                                serializeParam(
                                                              getCurrentTimestamp,
                                                              ParamType
                                                                  .DateTime,
                                                            ),
                                                            'schoolclassref':
                                                                serializeParam(
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .reference,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                            'schoolref':
                                                                serializeParam(
                                                              widget.schoolref,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          },
                                                        );
                                                      } else {
                                                        _model.school =
                                                            await SchoolRecord
                                                                .getDocumentOnce(
                                                                    widget
                                                                        .schoolref!);
                                                        triggerPushNotification(
                                                          notificationTitle:
                                                              'Notice',
                                                          notificationText: _model
                                                              .eventnameTextController
                                                              .text,
                                                          userRefs: [
                                                            _model
                                                                .school!
                                                                .principalDetails
                                                                .principalId!
                                                          ],
                                                          initialPageName:
                                                              'Dashboard',
                                                          parameterData: {},
                                                        );

                                                        await NotificationsRecord
                                                            .collection
                                                            .doc()
                                                            .set({
                                                          ...createNotificationsRecordData(
                                                            content: _model
                                                                .eventnameTextController
                                                                .text,
                                                            descri: _model
                                                                .descriptionTextController
                                                                .text,
                                                            datetimeofevent:
                                                                _model.date,
                                                            isread: false,
                                                            notification:
                                                                updateNotificationStruct(
                                                              NotificationStruct(
                                                                notificationTitle:
                                                                    _model
                                                                        .eventnameTextController
                                                                        .text,
                                                                descriptions: _model
                                                                    .descriptionTextController
                                                                    .text,
                                                                timeStamp:
                                                                    getCurrentTimestamp,
                                                                isRead: false,
                                                                eventDate:
                                                                    _model.date,
                                                                notificationFiles:
                                                                    FFAppState()
                                                                        .eventfiles,
                                                              ),
                                                              clearUnsetFields:
                                                                  false,
                                                              create: true,
                                                            ),
                                                            createDate:
                                                                getCurrentTimestamp,
                                                            tag: _model
                                                                .noticename,
                                                            addedby:
                                                                currentUserReference,
                                                            heading:
                                                                'Posted a notice',
                                                          ),
                                                          ...mapToFirestore(
                                                            {
                                                              'schoolref': [
                                                                widget
                                                                    .schoolref
                                                              ],
                                                              'towhome': [
                                                                classNoticeAdminTeacherSchoolClassRecord
                                                                    .className
                                                              ],
                                                            },
                                                          ),
                                                        });
                                                        safeSetState(() {
                                                          _model
                                                              .eventnameTextController
                                                              ?.clear();
                                                          _model
                                                              .descriptionTextController
                                                              ?.clear();
                                                        });
                                                        FFAppState()
                                                            .eventfiles = [];
                                                        safeSetState(() {});
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              alignment: AlignmentDirectional(
                                                                      0.0, -0.8)
                                                                  .resolve(
                                                                      Directionality.of(
                                                                          context)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          dialogContext)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.08,
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.6,
                                                                  child:
                                                                      NoticecreatedCopyWidget(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );

                                                        if (Navigator.of(
                                                                context)
                                                            .canPop()) {
                                                          context.pop();
                                                        }
                                                        context.pushNamed(
                                                          ClassViewWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'datePick':
                                                                serializeParam(
                                                              getCurrentTimestamp,
                                                              ParamType
                                                                  .DateTime,
                                                            ),
                                                            'schoolclassref':
                                                                serializeParam(
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .reference,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                            'schoolref':
                                                                serializeParam(
                                                              widget.schoolref,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Please select the notice name.',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  text: 'Post',
                                                  options: FFButtonOptions(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.55,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.055,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                          .divide(SizedBox(height: 10.0))
                                          .around(SizedBox(height: 10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                        }
                        context.pushNamed(
                          ClassViewWidget.routeName,
                          queryParameters: {
                            'schoolclassref': serializeParam(
                              widget.classref,
                              ParamType.DocumentReference,
                            ),
                            'schoolref': serializeParam(
                              widget.schoolref,
                              ParamType.DocumentReference,
                            ),
                            'datePick': serializeParam(
                              getCurrentTimestamp,
                              ParamType.DateTime,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
                        );
                      },
                      text: 'View all notice',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.nunito(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
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
  }
}
