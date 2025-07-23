import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/confirmationpages/quickaction/quickaction_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/attenancemarkshimmer/attenancemarkshimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'students_timeline_activities_model.dart';
export 'students_timeline_activities_model.dart';

class StudentsTimelineActivitiesWidget extends StatefulWidget {
  const StudentsTimelineActivitiesWidget({
    super.key,
    required this.schoolref,
    this.classref,
    this.activityId,
    this.activityName,
  });

  final DocumentReference? schoolref;
  final DocumentReference? classref;
  final int? activityId;
  final String? activityName;

  static String routeName = 'students_timeline_activities';
  static String routePath = '/studentsTimelineActivities';

  @override
  State<StudentsTimelineActivitiesWidget> createState() =>
      _StudentsTimelineActivitiesWidgetState();
}

class _StudentsTimelineActivitiesWidgetState
    extends State<StudentsTimelineActivitiesWidget> {
  late StudentsTimelineActivitiesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentsTimelineActivitiesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().selectedstudents = [];
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
            body: AttenancemarkshimmerWidget(),
          );
        }

        final studentsTimelineActivitiesSchoolClassRecord = snapshot.data!;

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
                        size: 26.0,
                      ),
                      onPressed: () async {
                        context.pop();
                      },
                    ),
                    title: Text(
                      valueOrDefault<String>(
                        widget.activityName,
                        'Food',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
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
              child: Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.75,
                              decoration: BoxDecoration(),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 20.0, 0.0, 5.0),
                                        child: Text(
                                          studentsTimelineActivitiesSchoolClassRecord
                                              .className,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 24.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                    if (widget.activityId != 2)
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.72,
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                () {
                                                  if (widget.activityId == 0) {
                                                    return 'Who ate their food?';
                                                  } else if (widget
                                                          .activityId ==
                                                      1) {
                                                    return 'Who took their nap?';
                                                  } else if (widget
                                                          .activityId ==
                                                      3) {
                                                    return 'Who performed a good deed?';
                                                  } else if (widget
                                                          .activityId ==
                                                      4) {
                                                    return 'Who used the potty?';
                                                  } else {
                                                    return 'Who had an incident?';
                                                  }
                                                }(),
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiaryText,
                                                      fontSize: 24.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                () {
                                                  if (widget.activityId == 0) {
                                                    return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Ffork_and_knife_with_plate.png?alt=media&token=d3c0ab7c-f43b-4a3b-b615-02135d701b23';
                                                  } else if (widget
                                                          .activityId ==
                                                      1) {
                                                    return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FBitmap.png?alt=media&token=932b22f6-a33b-4cb2-a8f8-a3d176899f44';
                                                  } else if (widget
                                                          .activityId ==
                                                      3) {
                                                    return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAppreciation.png?alt=media&token=d7cd93a2-eaed-4068-8271-5c3c69805c34';
                                                  } else if (widget
                                                          .activityId ==
                                                      4) {
                                                    return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fpotty_(2).png?alt=media&token=ebf034f3-760d-405e-b9db-1a8407d2ec02';
                                                  } else {
                                                    return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FIncident.png?alt=media&token=f2401cf9-a754-4a0c-8f2f-ad0423ebe926';
                                                  }
                                                }(),
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.12,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.05,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.85,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Selected : ${FFAppState().selectedstudents.length.toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      if (_model.selectall) {
                                                        FFAppState()
                                                            .selectedstudents = [];
                                                        safeSetState(() {});
                                                        _model.selectall =
                                                            false;
                                                        safeSetState(() {});
                                                      } else {
                                                        FFAppState()
                                                                .selectedstudents =
                                                            studentsTimelineActivitiesSchoolClassRecord
                                                                .studentsList
                                                                .toList()
                                                                .cast<
                                                                    DocumentReference>();
                                                        safeSetState(() {});
                                                        _model.selectall = true;
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    text: FFAppState()
                                                                .selectedstudents
                                                                .length ==
                                                            studentsTimelineActivitiesSchoolClassRecord
                                                                .studentData
                                                                .where((e) =>
                                                                    e.isDraft ==
                                                                    false)
                                                                .toList()
                                                                .length
                                                        ? 'Deselect all'
                                                        : 'Select all',
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                      elevation: 0.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      5.0, 25.0, 5.0, 5.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final students =
                                                      studentsTimelineActivitiesSchoolClassRecord
                                                          .studentData
                                                          .sortedList(
                                                              keyOf: (e) =>
                                                                  e.studentName,
                                                              desc: false)
                                                          .toList();

                                                  return GridView.builder(
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 10.0,
                                                      mainAxisSpacing: 15.0,
                                                      childAspectRatio: 0.9,
                                                    ),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: students.length,
                                                    itemBuilder: (context,
                                                        studentsIndex) {
                                                      final studentsItem =
                                                          students[
                                                              studentsIndex];
                                                      return Stack(
                                                        children: [
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (!FFAppState()
                                                                  .selectedstudents
                                                                  .contains(
                                                                      studentsItem
                                                                          .studentId)) {
                                                                FFAppState().addToSelectedstudents(
                                                                    studentsItem
                                                                        .studentId!);
                                                                safeSetState(
                                                                    () {});
                                                              } else {
                                                                FFAppState().removeFromSelectedstudents(
                                                                    studentsItem
                                                                        .studentId!);
                                                                safeSetState(
                                                                    () {});
                                                              }
                                                            },
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FFAppState()
                                                                        .selectedstudents
                                                                        .contains(studentsItem
                                                                            .studentId)
                                                                    ? Color(
                                                                        0xFFA8C0F4)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        2.0,
                                                                    color: Color(
                                                                        0xFFE4E5E7),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      1.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        0.0,
                                                                  )
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFFEDF1F3),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            2.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.15,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.15,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        studentsItem
                                                                            .studentImage,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      studentsItem
                                                                          .studentName,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          if (FFAppState()
                                                              .selectedstudents
                                                              .contains(
                                                                  studentsItem
                                                                      .studentId))
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.1,
                                                                      -1.2),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .check_box,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ].addToEnd(SizedBox(height: 30.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 0.0, 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 5.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.8,
                                        child: TextFormField(
                                          controller: _model.textController,
                                          focusNode: _model.textFieldFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelText: 'Description',
                                            labelStyle: FlutterFlowTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.nunito(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: valueOrDefault<Color>(
                                                    (_model.textFieldFocusNode
                                                                ?.hasFocus ??
                                                            false)
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .textfieldText,
                                                    FlutterFlowTheme.of(context)
                                                        .text,
                                                  ),
                                                  fontSize:
                                                      (_model.textFieldFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? 12.0
                                                          : 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                            hintText: 'Description',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.nunito(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .textfieldText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .textfieldDisable,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.nunito(
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .text2,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          maxLines: 2,
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          validator: _model
                                              .textControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) => Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          if (FFAppState()
                                                  .selectedstudents
                                                  .length !=
                                              0) {
                                            while (FFAppState().loopmin <
                                                FFAppState()
                                                    .selectedstudents
                                                    .length) {
                                              if (FFAppState()
                                                          .quickAction
                                                          .videoUrl !=
                                                      '') {
                                                await FFAppState()
                                                    .selectedstudents
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'timeline': FieldValue
                                                          .arrayUnion([
                                                        getStudentTimelineFirestoreData(
                                                          createStudentTimelineStruct(
                                                            id: functions
                                                                .generateUniqueId(),
                                                            date:
                                                                getCurrentTimestamp,
                                                            activityId: widget
                                                                .activityId,
                                                            activityName: widget
                                                                .activityName,
                                                            activityDescription:
                                                                _model
                                                                    .textController
                                                                    .text,
                                                            activityAddedby:
                                                                currentUserDisplayName,
                                                            activityvideo:
                                                                FFAppState()
                                                                    .quickAction
                                                                    .videoUrl,
                                                            clearUnsetFields:
                                                                false,
                                                          ),
                                                          true,
                                                        )
                                                      ]),
                                                      'gallery': FieldValue
                                                          .arrayUnion([
                                                        getGalleryFirestoreData(
                                                          updateGalleryStruct(
                                                            GalleryStruct(
                                                              video: FFAppState()
                                                                  .quickAction
                                                                  .videoUrl,
                                                              date:
                                                                  getCurrentTimestamp,
                                                              addedby:
                                                                  currentUserDisplayName,
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
                                              } else {
                                                await FFAppState()
                                                    .selectedstudents
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'timeline': FieldValue
                                                          .arrayUnion([
                                                        getStudentTimelineFirestoreData(
                                                          createStudentTimelineStruct(
                                                            id: functions
                                                                .generateUniqueId(),
                                                            date:
                                                                getCurrentTimestamp,
                                                            activityId: widget
                                                                .activityId,
                                                            activityName: widget
                                                                .activityName,
                                                            activityDescription:
                                                                _model
                                                                    .textController
                                                                    .text,
                                                            activityAddedby:
                                                                currentUserDisplayName,
                                                            activityImages:
                                                                FFAppState()
                                                                    .quickAction
                                                                    .imageUrl,
                                                            clearUnsetFields:
                                                                false,
                                                          ),
                                                          true,
                                                        )
                                                      ]),
                                                      'gallery': FieldValue
                                                          .arrayUnion([
                                                        getGalleryFirestoreData(
                                                          updateGalleryStruct(
                                                            GalleryStruct(
                                                              images: FFAppState()
                                                                  .quickAction
                                                                  .imageUrl,
                                                              date:
                                                                  getCurrentTimestamp,
                                                              addedby:
                                                                  currentUserDisplayName,
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
                                              }

                                              FFAppState().loopmin =
                                                  FFAppState().loopmin + 1;
                                              safeSetState(() {});
                                            }
                                          
                                            _model.studenList =
                                                await queryStudentsRecordOnce();
                                            FFAppState().loopmin = 0;
                                            safeSetState(() {});
                                            while (FFAppState().loopmin <
                                                FFAppState()
                                                    .selectedstudents
                                                    .length) {
                                              _model.student =
                                                  await StudentsRecord
                                                      .getDocumentOnce(
                                                          FFAppState()
                                                              .selectedstudents
                                                              .elementAtOrNull(
                                                                  FFAppState()
                                                                      .loopmin)!);
                                              triggerPushNotification(
                                                notificationTitle:
                                                    widget.activityName!,
                                                notificationText: () {
                                                  if (widget.activityId == 0) {
                                                    return '${_model.student?.studentName} ate their food ${_model.textController.text != '' ? _model.textController.text : ''}';
                                                  } else if (widget
                                                          .activityId ==
                                                      1) {
                                                    return '${_model.student?.studentName} Took a nap${_model.textController.text != '' ? _model.textController.text : ''}';
                                                  } else if (widget
                                                          .activityId ==
                                                      2) {
                                                    return '${_model.student?.studentName} Has Been Tagged in A New Photo ${_model.textController.text != '' ? _model.textController.text : ''}';
                                                  } else if (widget
                                                          .activityId ==
                                                      4) {
                                                    return '${_model.student?.studentName} took a potty break ${_model.textController.text != '' ? _model.textController.text : ''}';
                                                  } else if (widget
                                                          .activityId ==
                                                      3) {
                                                    return '${_model.student?.studentName} did a good deed! ${_model.textController.text != '' ? _model.textController.text : ''}';
                                                  } else {
                                                    return '${_model.student?.studentName}  had an incident! ${_model.textController.text != '' ? _model.textController.text : ''}';
                                                  }
                                                }(),
                                                userRefs: _model
                                                    .student!.parentsList
                                                    .toList(),
                                                initialPageName: 'Dashboard',
                                                parameterData: {},
                                              );
                                              FFAppState().loopmin =
                                                  FFAppState().loopmin + 1;
                                              safeSetState(() {});
                                            }
                                            FFAppState().loopmin = 0;
                                            safeSetState(() {});
                                            if (valueOrDefault(
                                                    currentUserDocument
                                                        ?.userRole,
                                                    0) ==
                                                3) {
                                              _model.teachereref =
                                                  await queryTeachersRecordOnce(
                                                queryBuilder:
                                                    (teachersRecord) =>
                                                        teachersRecord.where(
                                                  'useref',
                                                  isEqualTo:
                                                      currentUserReference,
                                                ),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              if ((FFAppState()
                                                              .quickAction
                                                              .videoUrl !=
                                                          '') ||
                                                  (FFAppState()
                                                              .quickAction
                                                              .imageUrl !=
                                                          '')) {
                                                if (FFAppState()
                                                            .quickAction
                                                            .videoUrl !=
                                                        '') {
                                                  await _model
                                                      .teachereref!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'teacher_timeline':
                                                            FieldValue
                                                                .arrayUnion([
                                                          getTeachersTimelineFirestoreData(
                                                            updateTeachersTimelineStruct(
                                                              TeachersTimelineStruct(
                                                                id: functions
                                                                    .generateUniqueId(),
                                                                date:
                                                                    getCurrentTimestamp,
                                                                className:
                                                                    studentsTimelineActivitiesSchoolClassRecord
                                                                        .className,
                                                                noofStudents:
                                                                    studentsTimelineActivitiesSchoolClassRecord
                                                                        .studentData
                                                                        .length,
                                                                studentref:
                                                                    FFAppState()
                                                                        .selectedstudents,
                                                                eventid: widget
                                                                    .activityId,
                                                                eventName: widget
                                                                    .activityName,
                                                                eventDescr: _model
                                                                    .textController
                                                                    .text,
                                                                activityvideo:
                                                                    FFAppState()
                                                                        .quickAction
                                                                        .videoUrl,
                                                              ),
                                                              clearUnsetFields:
                                                                  false,
                                                            ),
                                                            true,
                                                          )
                                                        ]),
                                                        'timelinevideo':
                                                            FieldValue
                                                                .arrayUnion([
                                                          FFAppState()
                                                              .quickAction
                                                              .videoUrl
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                } else {
                                                  await _model
                                                      .teachereref!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'teacher_timeline':
                                                            FieldValue
                                                                .arrayUnion([
                                                          getTeachersTimelineFirestoreData(
                                                            updateTeachersTimelineStruct(
                                                              TeachersTimelineStruct(
                                                                id: functions
                                                                    .generateUniqueId(),
                                                                date:
                                                                    getCurrentTimestamp,
                                                                className:
                                                                    studentsTimelineActivitiesSchoolClassRecord
                                                                        .className,
                                                                noofStudents:
                                                                    studentsTimelineActivitiesSchoolClassRecord
                                                                        .studentData
                                                                        .length,
                                                                studentref:
                                                                    FFAppState()
                                                                        .selectedstudents,
                                                                eventid: widget
                                                                    .activityId,
                                                                eventName: widget
                                                                    .activityName,
                                                                images: FFAppState()
                                                                    .quickAction
                                                                    .imageUrl,
                                                                eventDescr: _model
                                                                    .textController
                                                                    .text,
                                                              ),
                                                              clearUnsetFields:
                                                                  false,
                                                            ),
                                                            true,
                                                          )
                                                        ]),
                                                        'images': FieldValue
                                                            .arrayUnion([
                                                          FFAppState()
                                                              .quickAction
                                                              .imageUrl
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                }
                                              } else {
                                                await _model
                                                    .teachereref!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'teacher_timeline':
                                                          FieldValue
                                                              .arrayUnion([
                                                        getTeachersTimelineFirestoreData(
                                                          updateTeachersTimelineStruct(
                                                            TeachersTimelineStruct(
                                                              id: functions
                                                                  .generateUniqueId(),
                                                              date:
                                                                  getCurrentTimestamp,
                                                              className:
                                                                  studentsTimelineActivitiesSchoolClassRecord
                                                                      .className,
                                                              noofStudents:
                                                                  studentsTimelineActivitiesSchoolClassRecord
                                                                      .studentData
                                                                      .length,
                                                              studentref:
                                                                  FFAppState()
                                                                      .selectedstudents,
                                                              eventid: widget
                                                                  .activityId,
                                                              eventName: widget
                                                                  .activityName,
                                                              images: FFAppState()
                                                                  .quickAction
                                                                  .imageUrl,
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
                                              }

                                              FFAppState()
                                                  .studenttimelineimage = '';
                                              safeSetState(() {});
                                              FFAppState().loopmin = 0;
                                              FFAppState().selectedstudents =
                                                  [];
                                              FFAppState().studentphotovideo =
                                                  '';
                                              FFAppState().quickAction =
                                                  QuickActionDatatypeStruct();
                                              safeSetState(() {});
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, -0.8)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(
                                                                dialogContext)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Container(
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.08,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.75,
                                                        child:
                                                            QuickactionWidget(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                              if (widget.activityId == 2) {
                                                Navigator.pop(context);
                                              }

                                              context.goNamed(
                                                  DashboardWidget.routeName);
                                            } else {
                                              FFAppState()
                                                  .studenttimelineimage = '';
                                              safeSetState(() {});
                                              FFAppState().loopmin = 0;
                                              FFAppState().selectedstudents =
                                                  [];
                                              FFAppState().quickAction =
                                                  QuickActionDatatypeStruct();
                                              safeSetState(() {});
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, -0.8)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(
                                                                dialogContext)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child: Container(
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.08,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.75,
                                                        child:
                                                            QuickactionWidget(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                              context.goNamed(
                                                ClassDashboardWidget.routeName,
                                                queryParameters: {
                                                  'schoolref': serializeParam(
                                                    widget.schoolref,
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
                                                  'Please select atleast one student.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 1500),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            );
                                          }

                                          safeSetState(() {});
                                        },
                                        text: 'Send update',
                                        options: FFButtonOptions(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.8,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.05,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                            font: GoogleFonts.nunito(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                            shadows: [
                                              Shadow(
                                                color: Color(0xFF3375DF),
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 1.0,
                                              ),
                                              Shadow(
                                                color: Color(0x0C253EA7),
                                                offset: Offset(0.0, 1.0),
                                                blurRadius: 2.0,
                                              )
                                            ],
                                          ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}
