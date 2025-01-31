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
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

        final markAttendenceSchoolClassRecord = snapshot.data!;

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
                  context.safePop();
                },
              ),
              title: Text(
                '${markAttendenceSchoolClassRecord.className}- Attendance',
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 8.0, 0.0, 8.0),
                                child: Text(
                                  dateTimeFormat(
                                      "dd MMM , y", getCurrentTimestamp),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                      '${_model.alreadypresentStudents.length.toString()} / ${markAttendenceSchoolClassRecord.studentsList.length.toString()}',
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
                                onPressed: (markAttendenceSchoolClassRecord
                                            .studentsList.isEmpty)
                                    ? null
                                    : () async {
                                        if (_model.selectAll) {
                                          FFAppState().selectedstudents = [];
                                          safeSetState(() {});
                                          _model.alreadypresentStudents = [];
                                          _model.studentdatatattendance = [];
                                          safeSetState(() {});
                                          _model.selectAll = false;
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'All the students have been marked as absent.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 1200),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
                                        } else {
                                          FFAppState().selectedstudents =
                                              markAttendenceSchoolClassRecord
                                                  .studentData
                                                  .map((e) => e.studentId)
                                                  .withoutNulls
                                                  .toList()
                                                  .cast<DocumentReference>();
                                          safeSetState(() {});
                                          _model.addToStudentdatatattendance(
                                              StudentAttendanceStruct(
                                            id: functions.generateUniqueId(),
                                            date: getCurrentTimestamp,
                                            ispresent: true,
                                            addedBy: currentUserDisplayName,
                                            studentref:
                                                markAttendenceSchoolClassRecord
                                                    .studentData
                                                    .elementAtOrNull(
                                                        markAttendenceSchoolClassRecord
                                                            .studentData.length)
                                                    ?.studentId,
                                          ));
                                          _model.alreadypresentStudents =
                                              markAttendenceSchoolClassRecord
                                                  .studentData
                                                  .map((e) => e.studentId)
                                                  .withoutNulls
                                                  .toList()
                                                  .cast<DocumentReference>();
                                          safeSetState(() {});
                                          _model.selectAll = true;
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'All the students have been marked as present.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 1250),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
                                        }
                                      },
                                text: _model.selectAll
                                    ? 'Deselect all'
                                    : 'Select all',
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
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
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
                              final students = markAttendenceSchoolClassRecord
                                  .studentData
                                  .sortedList(
                                      keyOf: (e) => e.studentName, desc: false)
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
                                            _model.alreadypresentStudents
                                                    .contains(
                                                        studentsItem.studentId)
                                                ? const Color(0xFFA8C0F4)
                                                : FlutterFlowTheme.of(context)
                                                    .secondary,
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: const Color(0xFFEDF1F3),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            if (_model.alreadypresentStudents
                                                .contains(
                                                    studentsItem.studentId))
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
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondary,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color(0xFFF4F4F4),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      if (markAttendenceSchoolClassRecord
                                              .attendance
                                              .where((e) =>
                                                  dateTimeFormat(
                                                      "yMd", e.date) ==
                                                  dateTimeFormat("yMd",
                                                      getCurrentTimestamp))
                                              .toList().isEmpty) {
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
                                                      studentPresentList: _model
                                                          .alreadypresentStudents,
                                                      totalPresent: FFAppState()
                                                          .selectedstudents
                                                          .length,
                                                      date: getCurrentTimestamp,
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
                                                    ),
                                                    clearUnsetFields: false,
                                                  ),
                                                  true,
                                                )
                                              ]),
                                            },
                                          ),
                                        });
                                        _model.students123 =
                                            await queryStudentsRecordOnce();
                                        triggerPushNotification(
                                          notificationTitle:
                                              'Attendance update',
                                          notificationText:
                                              'Your ward has attended class today ',
                                          userRefs: functions
                                              .extractParentUserRefs(_model
                                                  .students123!
                                                  .where((e) => FFAppState()
                                                      .selectedstudents
                                                      .contains(e.reference))
                                                  .toList())
                                              .toList(),
                                          initialPageName: 'Dashboard',
                                          parameterData: {},
                                        );

                                        await NotificationsRecord.collection
                                            .doc()
                                            .set({
                                          ...createNotificationsRecordData(
                                            content:
                                                'Your ward was present for class ${markAttendenceSchoolClassRecord.className}',
                                            notification:
                                                updateNotificationStruct(
                                              NotificationStruct(
                                                notificationTitle: 'Attendance',
                                                descriptions:
                                                    'Your ward was present for class ${markAttendenceSchoolClassRecord.className} : marked at ${dateTimeFormat("M/d h:mm a", getCurrentTimestamp)}',
                                                timeStamp: getCurrentTimestamp,
                                                isRead: false,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            isread: false,
                                            createDate: getCurrentTimestamp,
                                            addedby: currentUserReference,
                                            heading: 'Attendence',
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': functions
                                                  .extractParentUserRefs(_model
                                                      .students123!
                                                      .where((e) => FFAppState()
                                                          .selectedstudents
                                                          .contains(
                                                              e.reference))
                                                      .toList()),
                                              'towhome': [
                                                markAttendenceSchoolClassRecord
                                                    .className
                                              ],
                                            },
                                          ),
                                        });
                                        FFAppState().loopmin = 0;
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
                                                      const AttendanceMarkedsuccessfullyWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        context.goNamed(
                                          'class_attendence',
                                          queryParameters: {
                                            'classRef': serializeParam(
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
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      } else {
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
                                                        .toList()),
                                              ),
                                            },
                                          ),
                                        });
                                        _model.students1234 =
                                            await queryStudentsRecordOnce();
                                        triggerPushNotification(
                                          notificationTitle:
                                              'Attendance update',
                                          notificationText:
                                              'Your ward has attended class today ',
                                          userRefs: functions
                                              .extractParentUserRefs(_model
                                                  .students1234!
                                                  .where((e) => FFAppState()
                                                      .selectedstudents
                                                      .contains(e.reference))
                                                  .toList())
                                              .toList(),
                                          initialPageName: 'Dashboard',
                                          parameterData: {},
                                        );

                                        await NotificationsRecord.collection
                                            .doc()
                                            .set({
                                          ...createNotificationsRecordData(
                                            content:
                                                'Your ward was present for class ${markAttendenceSchoolClassRecord.className}',
                                            notification:
                                                updateNotificationStruct(
                                              NotificationStruct(
                                                notificationTitle: 'Attendance',
                                                descriptions:
                                                    'Your ward was present for class ${markAttendenceSchoolClassRecord.className} : marked at ${dateTimeFormat("M/d h:mm a", getCurrentTimestamp)}',
                                                timeStamp: getCurrentTimestamp,
                                                isRead: false,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            isread: false,
                                            createDate: getCurrentTimestamp,
                                            addedby: currentUserReference,
                                            heading: 'Attendence',
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': functions
                                                  .extractParentUserRefs(_model
                                                      .students1234!
                                                      .where((e) => FFAppState()
                                                          .selectedstudents
                                                          .contains(
                                                              e.reference))
                                                      .toList()),
                                              'towhome': [
                                                markAttendenceSchoolClassRecord
                                                    .className
                                              ],
                                            },
                                          ),
                                        });
                                        FFAppState().loopmin = 0;
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
                                                      const AttendanceMarkedsuccessfullyWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        context.goNamed(
                                          'class_attendence',
                                          queryParameters: {
                                            'classRef': serializeParam(
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
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: valueOrDefault<String>(
                                      markAttendenceSchoolClassRecord.attendance
                                                  .where((e) =>
                                                      dateTimeFormat(
                                                          "yMd", e.date) ==
                                                      dateTimeFormat("yMd",
                                                          getCurrentTimestamp))
                                                  .toList().isEmpty
                                          ? 'Mark Today\'s attendance'
                                          : 'Update Today\'s attendance',
                                      'Mark Todays\'s attendance',
                                    ),
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.8,
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
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
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
