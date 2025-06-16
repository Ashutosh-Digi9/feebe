import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/confirmationpages/attendance_markedsuccessfully/attendance_markedsuccessfully_widget.dart';
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
import 'mark_attendence_model.dart';
export 'mark_attendence_model.dart';

class MarkAttendenceWidget extends StatefulWidget {
  const MarkAttendenceWidget({
    super.key,
    required this.classRef,
    required this.schoolref,
  });

  final DocumentReference? classRef;
  final DocumentReference? schoolref;

  static String routeName = 'mark_attendence';
  static String routePath = '/AddClass2AdminCopy';

  @override
  State<MarkAttendenceWidget> createState() => _MarkAttendenceWidgetState();
}

class _MarkAttendenceWidgetState extends State<MarkAttendenceWidget> {
  late MarkAttendenceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarkAttendenceModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().selectedstudents = [];
      safeSetState(() {});
      _model.classes =
          await SchoolClassRecord.getDocumentOnce(widget.classRef!);
      if (_model.classes?.attendance
              .where((e) =>
                  dateTimeFormat("yMd", e.date) ==
                  dateTimeFormat("yMd", getCurrentTimestamp))
              .toList()
              .length !=
          0) {
        if (_model.classes?.attendance
                .where((e) =>
                    (dateTimeFormat("yMd", e.date) ==
                        dateTimeFormat("yMd", getCurrentTimestamp)) &&
                    (e.checkIn == false))
                .toList()
                .length !=
            0) {
          _model.alreadypresentStudents = _model.classes!.attendance
              .where((e) =>
                  (dateTimeFormat("yMd", e.date) ==
                      dateTimeFormat("yMd", getCurrentTimestamp)) &&
                  (e.checkIn == true))
              .toList()
              .firstOrNull!
              .studentPresentList
              .toList()
              .cast<DocumentReference>();
          _model.studentdatatattendance = _model.classes!.attendance
              .where((e) =>
                  dateTimeFormat("yMd", e.date) ==
                  dateTimeFormat("yMd", getCurrentTimestamp))
              .toList()
              .firstOrNull!
              .studenttimelines
              .toList()
              .cast<StudentAttendanceStruct>();
          _model.checkoutstudentlist = _model.classes!.attendance
              .where((e) =>
                  (dateTimeFormat("yMd", e.date) ==
                      dateTimeFormat("yMd", getCurrentTimestamp)) &&
                  (e.checkIn == false))
              .toList()
              .firstOrNull!
              .studentPresentList
              .toList()
              .cast<DocumentReference>();
          safeSetState(() {});
        } else {
          _model.alreadypresentStudents = _model.classes!.attendance
              .where((e) =>
                  (dateTimeFormat("yMd", e.date) ==
                      dateTimeFormat("yMd", getCurrentTimestamp)) &&
                  (e.checkIn == true))
              .toList()
              .firstOrNull!
              .studentPresentList
              .toList()
              .cast<DocumentReference>();
          _model.studentdatatattendance = _model.classes!.attendance
              .where((e) =>
                  dateTimeFormat("yMd", e.date) ==
                  dateTimeFormat("yMd", getCurrentTimestamp))
              .toList()
              .firstOrNull!
              .studenttimelines
              .toList()
              .cast<StudentAttendanceStruct>();
          safeSetState(() {});
        }
      }
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

    return StreamBuilder<SchoolClassRecord>(
      stream: SchoolClassRecord.getDocument(widget.classRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: AttenancemarkshimmerWidget(),
          );
        }

        final markAttendenceSchoolClassRecord = snapshot.data!;

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
                        color: Color(0xFFCCCCCC),
                        size: 28.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                    title: Text(
                      'Check In/ Check Out',
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
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 8.0, 0.0, 8.0),
                                child: Text(
                                  dateTimeFormat(
                                      "dd MMM y", getCurrentTimestamp),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.nunito(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                            color: Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  await Future.wait([
                                    Future(() async {
                                      _model.pageindex = 0;
                                      safeSetState(() {});
                                    }),
                                    Future(() async {
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        0,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }),
                                  ]);
                                },
                                text: 'Check-in',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.45,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: valueOrDefault<Color>(
                                    _model.pageindex == 0
                                        ? FlutterFlowTheme.of(context).secondary
                                        : Color(0xFFF0F0F0),
                                    FlutterFlowTheme.of(context).secondary,
                                  ),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: valueOrDefault<Color>(
                                      _model.pageindex == 0
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : Color(0xFFF0F0F0),
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  await Future.wait([
                                    Future(() async {
                                      _model.pageindex = 1;
                                      safeSetState(() {});
                                    }),
                                    Future(() async {
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }),
                                  ]);
                                },
                                text: 'Check-out',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.45,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: valueOrDefault<Color>(
                                    _model.pageindex == 1
                                        ? FlutterFlowTheme.of(context).secondary
                                        : Color(0xFFF0F0F0),
                                    FlutterFlowTheme.of(context).secondary,
                                  ),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: valueOrDefault<Color>(
                                      _model.pageindex == 1
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : Color(0xFFF0F0F0),
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.73,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 40.0),
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _model.pageViewController ??=
                                  PageController(
                                      initialPage: max(
                                          0,
                                          min(
                                              valueOrDefault<int>(
                                                _model.pageindex,
                                                0,
                                              ),
                                              1))),
                              scrollDirection: Axis.horizontal,
                              children: [
                                SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Selected - ',
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
                                                  Text(
                                                    '${_model.alreadypresentStudents.length.toString()} / ${markAttendenceSchoolClassRecord.studentsList.length.toString()}',
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
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed:
                                                  (markAttendenceSchoolClassRecord
                                                              .studentsList
                                                              .length ==
                                                          0)
                                                      ? null
                                                      : () async {
                                                          if (_model
                                                              .selectAll) {
                                                            FFAppState()
                                                                .selectedstudents = [];
                                                            safeSetState(() {});
                                                            _model.alreadypresentStudents =
                                                                [];
                                                            _model.studentdatatattendance =
                                                                [];
                                                            safeSetState(() {});
                                                            _model.selectAll =
                                                                false;
                                                            safeSetState(() {});
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'All the students have been marked as absent.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        500),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                              ),
                                                            );
                                                          } else {
                                                            FFAppState()
                                                                    .selectedstudents =
                                                                markAttendenceSchoolClassRecord
                                                                    .studentData
                                                                    .map((e) => e
                                                                        .studentId)
                                                                    .withoutNulls
                                                                    .toList()
                                                                    .cast<
                                                                        DocumentReference>();
                                                            safeSetState(() {});
                                                            _model.alreadypresentStudents =
                                                                markAttendenceSchoolClassRecord
                                                                    .studentData
                                                                    .map((e) => e
                                                                        .studentId)
                                                                    .withoutNulls
                                                                    .toList()
                                                                    .cast<
                                                                        DocumentReference>();
                                                            safeSetState(() {});
                                                            FFAppState()
                                                                .loopmin = 0;
                                                            safeSetState(() {});
                                                            while (FFAppState()
                                                                    .loopmin <
                                                                markAttendenceSchoolClassRecord
                                                                    .studentsList
                                                                    .length) {
                                                              _model.addToStudentdatatattendance(
                                                                  StudentAttendanceStruct(
                                                                id: functions
                                                                    .generateUniqueId(),
                                                                date:
                                                                    getCurrentTimestamp,
                                                                ispresent: true,
                                                                addedBy:
                                                                    currentUserDisplayName,
                                                                studentref: markAttendenceSchoolClassRecord
                                                                    .studentData
                                                                    .elementAtOrNull(
                                                                        FFAppState()
                                                                            .loopmin)
                                                                    ?.studentId,
                                                                checkIn: true,
                                                              ));
                                                              safeSetState(
                                                                  () {});
                                                              FFAppState()
                                                                      .loopmin =
                                                                  FFAppState()
                                                                          .loopmin +
                                                                      1;
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                            FFAppState()
                                                                .loopmin = 0;
                                                            safeSetState(() {});
                                                            _model.selectAll =
                                                                true;
                                                            safeSetState(() {});
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'All the students have been marked as present.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        750),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                              ),
                                                            );
                                                          }
                                                        },
                                              text: _model.alreadypresentStudents
                                                          .length ==
                                                      markAttendenceSchoolClassRecord
                                                          .studentData.length
                                                  ? 'Deselect all'
                                                  : 'Select all',
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.04,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                disabledColor:
                                                    FlutterFlowTheme.of(context)
                                                        .dIsable,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Builder(
                                          builder: (context) {
                                            final students =
                                                markAttendenceSchoolClassRecord
                                                    .studentData
                                                    .sortedList(
                                                        keyOf: (e) =>
                                                            e.studentName,
                                                        desc: false)
                                                    .toList();

                                            return GridView.builder(
                                              padding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                0,
                                                40.0,
                                              ),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 15.0,
                                                childAspectRatio: 0.9,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: students.length,
                                              itemBuilder:
                                                  (context, studentsIndex) {
                                                final studentsItem =
                                                    students[studentsIndex];
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
                                                    await Future.wait([
                                                      Future(() async {
                                                        if (!FFAppState()
                                                            .selectedstudents
                                                            .contains(studentsItem
                                                                .studentId)) {
                                                          FFAppState()
                                                              .addToSelectedstudents(
                                                                  studentsItem
                                                                      .studentId!);
                                                          FFAppState()
                                                              .update(() {});
                                                        } else {
                                                          FFAppState()
                                                              .removeFromSelectedstudents(
                                                                  studentsItem
                                                                      .studentId!);
                                                          FFAppState()
                                                              .update(() {});
                                                        }
                                                      }),
                                                      Future(() async {
                                                        if (!_model
                                                            .alreadypresentStudents
                                                            .contains(studentsItem
                                                                .studentId)) {
                                                          _model.addToAlreadypresentStudents(
                                                              studentsItem
                                                                  .studentId!);
                                                          _model.addToStudentdatatattendance(
                                                              StudentAttendanceStruct(
                                                            id: functions
                                                                .generateUniqueId(),
                                                            date:
                                                                getCurrentTimestamp,
                                                            ispresent: true,
                                                            addedBy:
                                                                currentUserDisplayName,
                                                            studentref:
                                                                studentsItem
                                                                    .studentId,
                                                            checkIn: true,
                                                          ));
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.removeFromAlreadypresentStudents(
                                                              studentsItem
                                                                  .studentId!);
                                                          _model.studentdatatattendance = functions
                                                              .removeanstudent(
                                                                  studentsItem
                                                                      .studentId!,
                                                                  _model
                                                                      .studentdatatattendance
                                                                      .toList())
                                                              .toList()
                                                              .cast<
                                                                  StudentAttendanceStruct>();
                                                          safeSetState(() {});
                                                        }
                                                      }),
                                                    ]);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          valueOrDefault<Color>(
                                                        _model.alreadypresentStudents
                                                                .contains(
                                                                    studentsItem
                                                                        .studentId)
                                                            ? Color(0xFFA8C0F4)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0x09E4E5E7),
                                                          offset: Offset(
                                                            0.0,
                                                            1.0,
                                                          ),
                                                          spreadRadius: 0.0,
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFEDF1F3),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        if (_model
                                                            .alreadypresentStudents
                                                            .contains(
                                                                studentsItem
                                                                    .studentId))
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.1, -1.2),
                                                            child: Icon(
                                                              Icons.check_box,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 24.0,
                                                            ),
                                                          ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            2.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.16,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.16,
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
                                                              ),
                                                              if (_model
                                                                  .alreadypresentStudents
                                                                  .contains(
                                                                      studentsItem
                                                                          .studentId))
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    studentsItem
                                                                        .studentName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              if (!_model
                                                                  .alreadypresentStudents
                                                                  .contains(
                                                                      studentsItem
                                                                          .studentId))
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    studentsItem
                                                                        .studentName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                            ],
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
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Selected - ',
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
                                                  Text(
                                                    '${_model.checkoutstudentlist.length.toString()} / ${markAttendenceSchoolClassRecord.studentsList.length.toString()}',
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
                                                ].divide(SizedBox(width: 5.0)),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed:
                                                  (markAttendenceSchoolClassRecord
                                                              .studentsList
                                                              .length ==
                                                          0)
                                                      ? null
                                                      : () async {
                                                          if (_model
                                                              .selectAll) {
                                                            FFAppState()
                                                                .selectedstudents = [];
                                                            safeSetState(() {});
                                                            _model.checkoutstudentlist =
                                                                [];
                                                            _model.checkoutdata =
                                                                [];
                                                            safeSetState(() {});
                                                            _model.selectAll =
                                                                false;
                                                            safeSetState(() {});
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'All the students have been marked as absent.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1200),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                              ),
                                                            );
                                                          } else {
                                                            FFAppState()
                                                                    .selectedstudents =
                                                                markAttendenceSchoolClassRecord
                                                                    .studentData
                                                                    .map((e) => e
                                                                        .studentId)
                                                                    .withoutNulls
                                                                    .toList()
                                                                    .cast<
                                                                        DocumentReference>();
                                                            safeSetState(() {});
                                                            _model.checkoutstudentlist =
                                                                markAttendenceSchoolClassRecord
                                                                    .studentData
                                                                    .map((e) => e
                                                                        .studentId)
                                                                    .withoutNulls
                                                                    .toList()
                                                                    .cast<
                                                                        DocumentReference>();
                                                            safeSetState(() {});
                                                            FFAppState()
                                                                .loopmin = 0;
                                                            safeSetState(() {});
                                                            while (FFAppState()
                                                                    .loopmin <
                                                                markAttendenceSchoolClassRecord
                                                                    .studentsList
                                                                    .length) {
                                                              _model.addToCheckoutdata(
                                                                  StudentAttendanceStruct(
                                                                id: functions
                                                                    .generateUniqueId(),
                                                                date:
                                                                    getCurrentTimestamp,
                                                                ispresent: true,
                                                                addedBy:
                                                                    currentUserDisplayName,
                                                                studentref: markAttendenceSchoolClassRecord
                                                                    .studentData
                                                                    .elementAtOrNull(
                                                                        FFAppState()
                                                                            .loopmin)
                                                                    ?.studentId,
                                                                checkIn: false,
                                                              ));
                                                              safeSetState(
                                                                  () {});
                                                              FFAppState()
                                                                      .loopmin =
                                                                  FFAppState()
                                                                          .loopmin +
                                                                      1;
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                            FFAppState()
                                                                .loopmin = 0;
                                                            safeSetState(() {});
                                                            _model.selectAll =
                                                                true;
                                                            safeSetState(() {});
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'All the students have been marked as present.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        1250),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                              ),
                                                            );
                                                          }
                                                        },
                                              text: _model.checkoutstudentlist
                                                          .length ==
                                                      markAttendenceSchoolClassRecord
                                                          .studentData.length
                                                  ? 'Deselect all'
                                                  : 'Select all',
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.35,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.04,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                disabledColor:
                                                    FlutterFlowTheme.of(context)
                                                        .dIsable,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Builder(
                                          builder: (context) {
                                            final students =
                                                markAttendenceSchoolClassRecord
                                                    .studentData
                                                    .sortedList(
                                                        keyOf: (e) =>
                                                            e.studentName,
                                                        desc: false)
                                                    .toList();

                                            return GridView.builder(
                                              padding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                0,
                                                40.0,
                                              ),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 15.0,
                                                childAspectRatio: 0.9,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: students.length,
                                              itemBuilder:
                                                  (context, studentsIndex) {
                                                final studentsItem =
                                                    students[studentsIndex];
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
                                                    await Future.wait([
                                                      Future(() async {
                                                        if (!FFAppState()
                                                            .selectedstudents
                                                            .contains(studentsItem
                                                                .studentId)) {
                                                          FFAppState()
                                                              .addToSelectedstudents(
                                                                  studentsItem
                                                                      .studentId!);
                                                          FFAppState()
                                                              .update(() {});
                                                        } else {
                                                          FFAppState()
                                                              .removeFromSelectedstudents(
                                                                  studentsItem
                                                                      .studentId!);
                                                          FFAppState()
                                                              .update(() {});
                                                        }
                                                      }),
                                                      Future(() async {
                                                        if (!_model
                                                            .checkoutstudentlist
                                                            .contains(studentsItem
                                                                .studentId)) {
                                                          _model.addToCheckoutstudentlist(
                                                              studentsItem
                                                                  .studentId!);
                                                          _model.addToCheckoutdata(
                                                              StudentAttendanceStruct(
                                                            id: functions
                                                                .generateUniqueId(),
                                                            date:
                                                                getCurrentTimestamp,
                                                            ispresent: true,
                                                            addedBy:
                                                                currentUserDisplayName,
                                                            studentref:
                                                                studentsItem
                                                                    .studentId,
                                                            checkIn: false,
                                                          ));
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.removeFromCheckoutstudentlist(
                                                              studentsItem
                                                                  .studentId!);
                                                          _model.checkoutdata = functions
                                                              .removeanstudent(
                                                                  studentsItem
                                                                      .studentId!,
                                                                  _model
                                                                      .checkoutdata
                                                                      .toList())
                                                              .toList()
                                                              .cast<
                                                                  StudentAttendanceStruct>();
                                                          safeSetState(() {});
                                                        }
                                                      }),
                                                    ]);
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 0.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: valueOrDefault<
                                                            Color>(
                                                          _model.checkoutstudentlist
                                                                  .contains(
                                                                      studentsItem
                                                                          .studentId)
                                                              ? Color(
                                                                  0xFFA8C0F4)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 2.0,
                                                            color: Color(
                                                                0x09E4E5E7),
                                                            offset: Offset(
                                                              0.0,
                                                              1.0,
                                                            ),
                                                            spreadRadius: 0.0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFEDF1F3),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          if (_model
                                                              .checkoutstudentlist
                                                              .contains(
                                                                  studentsItem
                                                                      .studentId))
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.1,
                                                                      -1.2),
                                                              child: Icon(
                                                                Icons.check_box,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.16,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.16,
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
                                                                ),
                                                                if (_model
                                                                    .checkoutstudentlist
                                                                    .contains(
                                                                        studentsItem
                                                                            .studentId))
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      studentsItem
                                                                          .studentName,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                if (!_model
                                                                    .checkoutstudentlist
                                                                    .contains(
                                                                        studentsItem
                                                                            .studentId))
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      studentsItem
                                                                          .studentName,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                              ],
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ].addToEnd(SizedBox(height: 40.0)),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondary,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFFF4F4F4),
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (valueOrDefault(
                                  currentUserDocument?.userRole, 0) !=
                              1)
                            Builder(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () {
                                      if (_model.pageindex == 1) {
                                        return ((_model.checkoutstudentlist
                                                    .length ==
                                                0) ||
                                            (markAttendenceSchoolClassRecord
                                                    .attendance
                                                    .where((e) =>
                                                        dateTimeFormat(
                                                            "yMd", e.date) ==
                                                        dateTimeFormat("yMd",
                                                            getCurrentTimestamp))
                                                    .toList()
                                                    .length ==
                                                0));
                                      } else if (_model.pageindex == 0) {
                                        return (_model.alreadypresentStudents
                                                .length ==
                                            0);
                                      } else {
                                        return false;
                                      }
                                    }()
                                        ? null
                                        : () async {
                                            if (markAttendenceSchoolClassRecord
                                                    .attendance
                                                    .where((e) =>
                                                        dateTimeFormat(
                                                            "yMd", e.date) ==
                                                        dateTimeFormat("yMd",
                                                            getCurrentTimestamp))
                                                    .toList()
                                                    .length ==
                                                0) {
                                              await widget.classRef!.update({
                                                ...mapToFirestore(
                                                  {
                                                    'attendance':
                                                        FieldValue.arrayUnion([
                                                      getClassAttendanceFirestoreData(
                                                        updateClassAttendanceStruct(
                                                          ClassAttendanceStruct(
                                                            id: functions
                                                                .generateUniqueId(),
                                                            totalStudents:
                                                                markAttendenceSchoolClassRecord
                                                                    .studentsList
                                                                    .length,
                                                            studentPresentList:
                                                                _model
                                                                    .alreadypresentStudents,
                                                            totalPresent:
                                                                FFAppState()
                                                                    .selectedstudents
                                                                    .length,
                                                            date:
                                                                getCurrentTimestamp,
                                                            totalAbsent: functions
                                                                .findTotalAbsent(
                                                                    FFAppState()
                                                                        .selectedstudents
                                                                        .length,
                                                                    markAttendenceSchoolClassRecord
                                                                        .studentsList
                                                                        .length),
                                                            studenttimelines: _model
                                                                .studentdatatattendance,
                                                            checkIn:
                                                                _model.pageindex ==
                                                                        0
                                                                    ? true
                                                                    : false,
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
                                              _model.students123 =
                                                  await queryStudentsRecordOnce();
                                              FFAppState().loopmin = 0;
                                              safeSetState(() {});
                                              while (FFAppState().loopmin <
                                                  FFAppState()
                                                      .selectedstudents
                                                      .length) {
                                                _model.studentnoti =
                                                    await StudentsRecord
                                                        .getDocumentOnce(FFAppState()
                                                            .selectedstudents
                                                            .elementAtOrNull(
                                                                FFAppState()
                                                                    .loopmin)!);
                                                triggerPushNotification(
                                                  notificationTitle:
                                                      'student checkin',
                                                  notificationText:
                                                      '\" ${_model.studentnoti?.studentName} \"has checked in',
                                                  userRefs: _model
                                                      .studentnoti!.parentsList
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
                                                  3) {}
                                              FFAppState().loopmin = 0;
                                              FFAppState().selectedstudents =
                                                  [];
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
                                                                0.86,
                                                        child:
                                                            AttendanceMarkedsuccessfullyWidget(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                              if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.userRole,
                                                      0) !=
                                                  2) {
                                                if (Navigator.of(context)
                                                    .canPop()) {
                                                  context.pop();
                                                }
                                                context.pushNamed(
                                                  DashboardWidget.routeName,
                                                  queryParameters: {
                                                    'fromlogin': serializeParam(
                                                      false,
                                                      ParamType.bool,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                                  },
                                                );
                                              } else {
                                                if (Navigator.of(context)
                                                    .canPop()) {
                                                  context.pop();
                                                }
                                                context.pushNamed(
                                                  ClassDashboardWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'schoolref': serializeParam(
                                                      widget.schoolref,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                                  },
                                                );
                                              }
                                            } else {
                                              if (_model.pageindex == 0) {
                                                await widget.classRef!.update({
                                                  ...mapToFirestore(
                                                    {
                                                      'attendance':
                                                          getClassAttendanceListFirestoreData(
                                                        functions.updateattendance(
                                                            markAttendenceSchoolClassRecord
                                                                .attendance
                                                                .toList(),
                                                            getCurrentTimestamp,
                                                            _model
                                                                .alreadypresentStudents
                                                                .toList(),
                                                            _model
                                                                .alreadypresentStudents
                                                                .length,
                                                            functions.findTotalAbsent(
                                                                _model
                                                                    .alreadypresentStudents
                                                                    .length,
                                                                markAttendenceSchoolClassRecord
                                                                    .studentData
                                                                    .length),
                                                            _model
                                                                .studentdatatattendance
                                                                .toList(),
                                                            markAttendenceSchoolClassRecord
                                                                .studentData
                                                                .length,
                                                            true),
                                                      ),
                                                    },
                                                  ),
                                                });
                                                _model.students1234 =
                                                    await queryStudentsRecordOnce();
                                                FFAppState().loopmin = 0;
                                                safeSetState(() {});
                                                while (FFAppState().loopmin <
                                                    FFAppState()
                                                        .selectedstudents
                                                        .length) {
                                                  _model.studentnoti1 =
                                                      await StudentsRecord
                                                          .getDocumentOnce(FFAppState()
                                                              .selectedstudents
                                                              .elementAtOrNull(
                                                                  FFAppState()
                                                                      .loopmin)!);
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        'student checkin',
                                                    notificationText:
                                                        '\" ${_model.studentnoti1?.studentName} \"has checked in',
                                                    userRefs: _model
                                                        .studentnoti1!
                                                        .parentsList
                                                        .toList(),
                                                    initialPageName:
                                                        'Dashboard',
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
                                                    3) {}
                                                FFAppState().loopmin = 0;
                                                FFAppState().selectedstudents =
                                                    [];
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
                                                                  0.86,
                                                          child:
                                                              AttendanceMarkedsuccessfullyWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.userRole,
                                                        0) !=
                                                    2) {
                                                  if (Navigator.of(context)
                                                      .canPop()) {
                                                    context.pop();
                                                  }
                                                  context.pushNamed(
                                                    DashboardWidget.routeName,
                                                    queryParameters: {
                                                      'fromlogin':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      kTransitionInfoKey:
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                      ),
                                                    },
                                                  );
                                                } else {
                                                  if (Navigator.of(context)
                                                      .canPop()) {
                                                    context.pop();
                                                  }
                                                  context.pushNamed(
                                                    ClassDashboardWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'schoolref':
                                                          serializeParam(
                                                        widget.schoolref,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      kTransitionInfoKey:
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                      ),
                                                    },
                                                  );
                                                }
                                              } else {
                                                if (markAttendenceSchoolClassRecord
                                                        .attendance
                                                        .where((e) =>
                                                            (dateTimeFormat(
                                                                    "yMd",
                                                                    e.date) ==
                                                                dateTimeFormat(
                                                                    "yMd",
                                                                    getCurrentTimestamp)) &&
                                                            !e.checkIn)
                                                        .toList()
                                                        .length ==
                                                    0) {
                                                  await widget.classRef!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'attendance': FieldValue
                                                            .arrayUnion([
                                                          getClassAttendanceFirestoreData(
                                                            updateClassAttendanceStruct(
                                                              ClassAttendanceStruct(
                                                                id: functions
                                                                    .generateUniqueId(),
                                                                totalStudents:
                                                                    markAttendenceSchoolClassRecord
                                                                        .studentsList
                                                                        .length,
                                                                studentPresentList:
                                                                    _model
                                                                        .checkoutstudentlist,
                                                                totalPresent: _model
                                                                    .checkoutstudentlist
                                                                    .length,
                                                                date:
                                                                    getCurrentTimestamp,
                                                                totalAbsent: functions.findTotalAbsent(
                                                                    _model
                                                                        .checkoutstudentlist
                                                                        .length,
                                                                    markAttendenceSchoolClassRecord
                                                                        .studentsList
                                                                        .length),
                                                                studenttimelines:
                                                                    _model
                                                                        .checkoutdata,
                                                                checkIn: false,
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
                                                  _model.students123458 =
                                                      await queryStudentsRecordOnce();
                                                  FFAppState().loopmin = 0;
                                                  safeSetState(() {});
                                                  while (FFAppState().loopmin <
                                                      FFAppState()
                                                          .selectedstudents
                                                          .length) {
                                                    _model.studentnoti2 =
                                                        await StudentsRecord
                                                            .getDocumentOnce(FFAppState()
                                                                .selectedstudents
                                                                .elementAtOrNull(
                                                                    FFAppState()
                                                                        .loopmin)!);
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'student checkout',
                                                      notificationText:
                                                          '\" ${_model.studentnoti2?.studentName} \"has checked out',
                                                      userRefs: _model
                                                          .studentnoti2!
                                                          .parentsList
                                                          .toList(),
                                                      initialPageName:
                                                          'Dashboard',
                                                      parameterData: {},
                                                    );
                                                    FFAppState().loopmin =
                                                        FFAppState().loopmin +
                                                            1;
                                                    safeSetState(() {});
                                                  }
                                                  FFAppState().loopmin = 0;
                                                  safeSetState(() {});
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.userRole,
                                                          0) ==
                                                      3) {}
                                                  FFAppState().loopmin = 0;
                                                  FFAppState()
                                                      .selectedstudents = [];
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
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.08,
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.86,
                                                            child:
                                                                AttendanceMarkedsuccessfullyWidget(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.userRole,
                                                          0) !=
                                                      2) {
                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamed(
                                                      DashboardWidget.routeName,
                                                      queryParameters: {
                                                        'fromlogin':
                                                            serializeParam(
                                                          false,
                                                          ParamType.bool,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamed(
                                                      ClassDashboardWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'schoolref':
                                                            serializeParam(
                                                          widget.schoolref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  }
                                                } else {
                                                  await widget.classRef!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'attendance':
                                                            getClassAttendanceListFirestoreData(
                                                          functions.updateattendance(
                                                              markAttendenceSchoolClassRecord
                                                                  .attendance
                                                                  .toList(),
                                                              getCurrentTimestamp,
                                                              _model
                                                                  .checkoutstudentlist
                                                                  .toList(),
                                                              _model
                                                                  .checkoutstudentlist
                                                                  .length,
                                                              functions.findTotalAbsent(
                                                                  _model
                                                                      .checkoutstudentlist
                                                                      .length,
                                                                  markAttendenceSchoolClassRecord
                                                                      .studentData
                                                                      .length),
                                                              _model
                                                                  .checkoutdata
                                                                  .toList(),
                                                              markAttendenceSchoolClassRecord
                                                                  .studentData
                                                                  .length,
                                                              false),
                                                        ),
                                                      },
                                                    ),
                                                  });
                                                  _model.students12345 =
                                                      await queryStudentsRecordOnce();
                                                  FFAppState().loopmin = 0;
                                                  safeSetState(() {});
                                                  while (FFAppState().loopmin <
                                                      FFAppState()
                                                          .selectedstudents
                                                          .length) {
                                                    _model.studentnoti3 =
                                                        await StudentsRecord
                                                            .getDocumentOnce(FFAppState()
                                                                .selectedstudents
                                                                .elementAtOrNull(
                                                                    FFAppState()
                                                                        .loopmin)!);
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'student checkout',
                                                      notificationText:
                                                          '\" ${_model.studentnoti3?.studentName} \"has checked out',
                                                      userRefs: _model
                                                          .studentnoti3!
                                                          .parentsList
                                                          .toList(),
                                                      initialPageName:
                                                          'Dashboard',
                                                      parameterData: {},
                                                    );
                                                    FFAppState().loopmin =
                                                        FFAppState().loopmin +
                                                            1;
                                                    safeSetState(() {});
                                                  }
                                                  FFAppState().loopmin = 0;
                                                  safeSetState(() {});
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.userRole,
                                                          0) ==
                                                      3) {}
                                                  FFAppState().loopmin = 0;
                                                  FFAppState()
                                                      .selectedstudents = [];
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
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.08,
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.86,
                                                            child:
                                                                AttendanceMarkedsuccessfullyWidget(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.userRole,
                                                          0) !=
                                                      2) {
                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamed(
                                                      DashboardWidget.routeName,
                                                      queryParameters: {
                                                        'fromlogin':
                                                            serializeParam(
                                                          false,
                                                          ParamType.bool,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  } else {
                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamed(
                                                      ClassDashboardWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'schoolref':
                                                            serializeParam(
                                                          widget.schoolref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  }
                                                }
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                    text: 'Submit',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.8,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.05,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
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
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context).dIsable,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
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
