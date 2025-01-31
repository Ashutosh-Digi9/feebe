import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/attenancemarkshimmer/attenancemarkshimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'attendance_history_students_card_model.dart';
export 'attendance_history_students_card_model.dart';

class AttendanceHistoryStudentsCardWidget extends StatefulWidget {
  const AttendanceHistoryStudentsCardWidget({
    super.key,
    required this.classRef,
    required this.schoolref,
    required this.date,
  });

  final DocumentReference? classRef;
  final DocumentReference? schoolref;
  final DateTime? date;

  @override
  State<AttendanceHistoryStudentsCardWidget> createState() =>
      _AttendanceHistoryStudentsCardWidgetState();
}

class _AttendanceHistoryStudentsCardWidgetState
    extends State<AttendanceHistoryStudentsCardWidget> {
  late AttendanceHistoryStudentsCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendanceHistoryStudentsCardModel());

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
              .toList().isNotEmpty) {
        _model.alreadypresentStudents = _model.classes!.attendance
            .where((e) =>
                dateTimeFormat("yMd", e.date) ==
                dateTimeFormat("yMd", getCurrentTimestamp))
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
            body: const AttenancemarkshimmerWidget(),
          );
        }

        final attendanceHistoryStudentsCardSchoolClassRecord = snapshot.data!;

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
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).alternate,
                  size: 28.0,
                ),
                onPressed: () async {
                  context.goNamed(
                    'class_attendence_history',
                    queryParameters: {
                      'classref': serializeParam(
                        widget.classRef,
                        ParamType.DocumentReference,
                      ),
                      'schoolref': serializeParam(
                        widget.schoolref,
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
              ),
              title: Text(
                'Attendance History',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
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
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Selected - ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      '${attendanceHistoryStudentsCardSchoolClassRecord.attendance.where((e) => dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", widget.date)).toList().firstOrNull?.totalPresent.toString()} / ${attendanceHistoryStudentsCardSchoolClassRecord.studentsList.length.toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ].divide(const SizedBox(width: 5.0)),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed:
                                    (attendanceHistoryStudentsCardSchoolClassRecord
                                                .studentsList.isEmpty)
                                        ? null
                                        : () async {
                                            if (_model.selectAll) {
                                              FFAppState().selectedstudents =
                                                  [];
                                              safeSetState(() {});
                                              _model.alreadypresentStudents =
                                                  [];
                                              _model.studentdatatattendance =
                                                  [];
                                              safeSetState(() {});
                                              _model.selectAll = false;
                                              safeSetState(() {});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'All the students have been marked as absent.',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 1200),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                ),
                                              );
                                            } else {
                                              FFAppState().selectedstudents =
                                                  attendanceHistoryStudentsCardSchoolClassRecord
                                                      .studentData
                                                      .map((e) => e.studentId)
                                                      .withoutNulls
                                                      .toList()
                                                      .cast<
                                                          DocumentReference>();
                                              safeSetState(() {});
                                              _model
                                                  .addToStudentdatatattendance(
                                                      StudentAttendanceStruct(
                                                id: functions
                                                    .generateUniqueId(),
                                                date: getCurrentTimestamp,
                                                ispresent: true,
                                                addedBy: currentUserDisplayName,
                                                studentref:
                                                    attendanceHistoryStudentsCardSchoolClassRecord
                                                        .studentData
                                                        .elementAtOrNull(
                                                            attendanceHistoryStudentsCardSchoolClassRecord
                                                                .studentData
                                                                .length)
                                                        ?.studentId,
                                              ));
                                              _model.alreadypresentStudents =
                                                  attendanceHistoryStudentsCardSchoolClassRecord
                                                      .studentData
                                                      .map((e) => e.studentId)
                                                      .withoutNulls
                                                      .toList()
                                                      .cast<
                                                          DocumentReference>();
                                              safeSetState(() {});
                                              _model.selectAll = true;
                                              safeSetState(() {});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'All the students have been marked as present.',
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 1250),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                ),
                                              );
                                            }
                                          },
                                text: dateTimeFormat("dd MMM, y", widget.date),
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.04,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Nunito',
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(0.0),
                                  disabledColor:
                                      FlutterFlowTheme.of(context).dIsable,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Builder(
                            builder: (context) {
                              final students =
                                  attendanceHistoryStudentsCardSchoolClassRecord
                                      .studentData
                                      .toList();

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 0.9,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: students.length,
                                itemBuilder: (context, studentsIndex) {
                                  final studentsItem = students[studentsIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await Future.wait([
                                        Future(() async {
                                          if (!FFAppState()
                                              .selectedstudents
                                              .contains(
                                                  studentsItem.studentId)) {
                                            FFAppState().addToSelectedstudents(
                                                studentsItem.studentId!);
                                            FFAppState().update(() {});
                                          } else {
                                            FFAppState()
                                                .removeFromSelectedstudents(
                                                    studentsItem.studentId!);
                                            FFAppState().update(() {});
                                          }
                                        }),
                                        Future(() async {
                                          if (!_model.alreadypresentStudents
                                              .contains(
                                                  studentsItem.studentId)) {
                                            _model.addToAlreadypresentStudents(
                                                studentsItem.studentId!);
                                            _model.addToStudentdatatattendance(
                                                StudentAttendanceStruct(
                                              id: functions.generateUniqueId(),
                                              date: getCurrentTimestamp,
                                              ispresent: true,
                                              addedBy: currentUserDisplayName,
                                              studentref:
                                                  studentsItem.studentId,
                                            ));
                                            safeSetState(() {});
                                          } else {
                                            _model
                                                .removeFromAlreadypresentStudents(
                                                    studentsItem.studentId!);
                                            _model.studentdatatattendance = functions
                                                .removeanstudent(
                                                    studentsItem.studentId!,
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
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: valueOrDefault<Color>(
                                            attendanceHistoryStudentsCardSchoolClassRecord
                                                    .attendance
                                                    .where((e) =>
                                                        dateTimeFormat(
                                                            "yMd", e.date) ==
                                                        dateTimeFormat("yMd",
                                                            widget.date))
                                                    .toList()
                                                    .firstOrNull!
                                                    .studentPresentList
                                                    .contains(
                                                        studentsItem.studentId)
                                                ? const Color(0xFFA8C0F4)
                                                : FlutterFlowTheme.of(context)
                                                    .secondary,
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 2.0,
                                              color: Color(0xE4E5E73D),
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: const Color(0xFFEDF1F3),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            if (attendanceHistoryStudentsCardSchoolClassRecord
                                                    .attendance
                                                    .where((e) =>
                                                        dateTimeFormat(
                                                            "yMd", e.date) ==
                                                        dateTimeFormat("yMd",
                                                            widget.date))
                                                    .toList()
                                                    .firstOrNull
                                                    ?.studentPresentList
                                                    .contains(studentsItem
                                                        .studentId) ??
                                                true)
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: Icon(
                                                  Icons.check_box,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 24.0,
                                                ),
                                              ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.2,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.2,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    studentsItem.studentImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    studentsItem.studentName,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                              ],
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
        );
      },
    );
  }
}
