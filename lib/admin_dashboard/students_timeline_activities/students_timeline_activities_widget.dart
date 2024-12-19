import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
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
            body: const AttenancemarkshimmerWidget(),
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
                  color: FlutterFlowTheme.of(context).bgColor1,
                  size: 28.0,
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
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 20.0, 0.0, 0.0),
                          child: Text(
                            studentsTimelineActivitiesSchoolClassRecord
                                .className,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 5.0, 0.0, 0.0),
                          child: Text(
                            'Select students.',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Selected : ${FFAppState().selectedstudents.length.toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        if (_model.selectall) {
                                          FFAppState().selectedstudents = [];
                                          safeSetState(() {});
                                          _model.selectall = false;
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'All Students are removed',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 650),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
                                        } else {
                                          FFAppState().selectedstudents =
                                              studentsTimelineActivitiesSchoolClassRecord
                                                  .studentsList
                                                  .toList()
                                                  .cast<DocumentReference>();
                                          safeSetState(() {});
                                          _model.selectall = true;
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'All Students are selected',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 500),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
                                        }
                                      },
                                      text: _model.selectall
                                          ? 'Deselect all'
                                          : 'Select all',
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                        studentsTimelineActivitiesSchoolClassRecord
                                            .studentsList
                                            .toList();

                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 1.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: students.length,
                                      itemBuilder: (context, studentsIndex) {
                                        final studentsItem =
                                            students[studentsIndex];
                                        return Stack(
                                          children: [
                                            StreamBuilder<StudentsRecord>(
                                              stream:
                                                  StudentsRecord.getDocument(
                                                      studentsItem),
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

                                                final containerStudentsRecord =
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
                                                    if (!FFAppState()
                                                        .selectedstudents
                                                        .contains(
                                                            studentsItem)) {
                                                      FFAppState()
                                                          .addToSelectedstudents(
                                                              containerStudentsRecord
                                                                  .reference);
                                                      safeSetState(() {});
                                                    } else {
                                                      FFAppState()
                                                          .removeFromSelectedstudents(
                                                              containerStudentsRecord
                                                                  .reference);
                                                      safeSetState(() {});
                                                    }
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 5.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FFAppState()
                                                                .selectedstudents
                                                                .contains(
                                                                    studentsItem)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .lightblue
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.15,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.15,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  containerStudentsRecord
                                                                      .studentImage,
                                                                  'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Text(
                                                              containerStudentsRecord
                                                                  .studentName,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    letterSpacing:
                                                                        0.0,
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
                                            if (FFAppState()
                                                .selectedstudents
                                                .contains(studentsItem))
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 0.0),
                                                  child: Icon(
                                                    Icons.check_box,
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
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Description',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: valueOrDefault<Color>(
                                        (_model.textFieldFocusNode?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context).text,
                                        FlutterFlowTheme.of(context).text,
                                      ),
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Description',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).dIsable,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                              maxLines: 4,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          if (FFAppState().selectedstudents.isNotEmpty) {
                            if (FFAppState().studenttimelineimage != '') {
                              while (FFAppState().loopmin <
                                  FFAppState().selectedstudents.length) {
                                await FFAppState()
                                    .selectedstudents
                                    .elementAtOrNull(FFAppState().loopmin)!
                                    .update({
                                  ...mapToFirestore(
                                    {
                                      'timeline': FieldValue.arrayUnion([
                                        getStudentTimelineFirestoreData(
                                          createStudentTimelineStruct(
                                            id: functions.generateUniqueId(),
                                            date: getCurrentTimestamp,
                                            activityId: widget.activityId,
                                            activityName: widget.activityName,
                                            activityDescription:
                                                _model.textController.text,
                                            activityAddedby:
                                                currentUserDisplayName,
                                            activityImages: FFAppState()
                                                .studenttimelineimage,
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                      'imageslist': FieldValue.arrayUnion(
                                          [FFAppState().studenttimelineimage]),
                                    },
                                  ),
                                });
                                FFAppState().loopmin = FFAppState().loopmin + 1;
                                safeSetState(() {});
                              }
                            } else {
                              while (FFAppState().loopmin <
                                  FFAppState().selectedstudents.length) {
                                await FFAppState()
                                    .selectedstudents
                                    .elementAtOrNull(FFAppState().loopmin)!
                                    .update({
                                  ...mapToFirestore(
                                    {
                                      'timeline': FieldValue.arrayUnion([
                                        getStudentTimelineFirestoreData(
                                          createStudentTimelineStruct(
                                            id: functions.generateUniqueId(),
                                            date: getCurrentTimestamp,
                                            activityId: widget.activityId,
                                            activityName: widget.activityName,
                                            activityDescription:
                                                _model.textController.text,
                                            activityAddedby:
                                                currentUserDisplayName,
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                    },
                                  ),
                                });
                                FFAppState().loopmin = FFAppState().loopmin + 1;
                                safeSetState(() {});
                              }
                            }

                            _model.studenList = await queryStudentsRecordOnce();
                            triggerPushNotification(
                              notificationTitle: widget.activityName!,
                              notificationText: 'Update',
                              userRefs: functions
                                  .extractParentUserRefs(_model.studenList!
                                      .where((e) => FFAppState()
                                          .selectedstudents
                                          .contains(e.reference))
                                      .toList())
                                  .toList(),
                              initialPageName: 'Dashboard',
                              parameterData: {},
                            );

                            await NotificationsRecord.collection.doc().set({
                              ...createNotificationsRecordData(
                                content:
                                    'Your child\'s update on ${widget.activityName}',
                                notification: updateNotificationStruct(
                                  NotificationStruct(
                                    notificationTitle:
                                        'Your child\'s update on ${widget.activityName}',
                                    descriptions: _model.textController.text,
                                    timeStamp: getCurrentTimestamp,
                                    isRead: false,
                                  ),
                                  clearUnsetFields: false,
                                  create: true,
                                ),
                                isread: false,
                                createDate: getCurrentTimestamp,
                              ),
                              ...mapToFirestore(
                                {
                                  'userref': functions.extractParentUserRefs(
                                      _model.studenList!
                                          .where((e) => FFAppState()
                                              .selectedstudents
                                              .contains(e.reference))
                                          .toList()),
                                },
                              ),
                            });
                            if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                3) {
                              _model.teachereref =
                                  await queryTeachersRecordOnce(
                                queryBuilder: (teachersRecord) =>
                                    teachersRecord.where(
                                  'useref',
                                  isEqualTo: currentUserReference,
                                ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);
                              if (FFAppState().studenttimelineimage != '') {
                                await _model.teachereref!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'teacher_timeline':
                                          FieldValue.arrayUnion([
                                        getTeachersTimelineFirestoreData(
                                          updateTeachersTimelineStruct(
                                            TeachersTimelineStruct(
                                              id: functions.generateUniqueId(),
                                              date: getCurrentTimestamp,
                                              className:
                                                  studentsTimelineActivitiesSchoolClassRecord
                                                      .className,
                                              noofStudents: FFAppState()
                                                  .selectedstudents
                                                  .length,
                                              studentref:
                                                  FFAppState().selectedstudents,
                                              eventid: widget.activityId,
                                              eventName: widget.activityName,
                                              images: FFAppState()
                                                  .studenttimelineimage,
                                            ),
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                      'images': FieldValue.arrayUnion(
                                          [FFAppState().studenttimelineimage]),
                                    },
                                  ),
                                });
                              } else {
                                await _model.teachereref!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'teacher_timeline':
                                          FieldValue.arrayUnion([
                                        getTeachersTimelineFirestoreData(
                                          updateTeachersTimelineStruct(
                                            TeachersTimelineStruct(
                                              id: functions.generateUniqueId(),
                                              date: getCurrentTimestamp,
                                              className:
                                                  studentsTimelineActivitiesSchoolClassRecord
                                                      .className,
                                              noofStudents: FFAppState()
                                                  .selectedstudents
                                                  .length,
                                              studentref:
                                                  FFAppState().selectedstudents,
                                              eventid: widget.activityId,
                                              eventName: widget.activityName,
                                              images: FFAppState()
                                                  .studenttimelineimage,
                                            ),
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                    },
                                  ),
                                });
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Student timeline updated.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              );
                              triggerPushNotification(
                                notificationTitle: 'Quick action ',
                                notificationText:
                                    '$currentUserDisplayName has updated ${widget.activityName}',
                                userRefs: [FFAppState().superadminref!],
                                initialPageName: 'class_dashboard',
                                parameterData: {
                                  'schoolref': widget.schoolref,
                                },
                              );

                              await NotificationsRecord.collection.doc().set({
                                ...createNotificationsRecordData(
                                  content:
                                      '$currentUserDisplayName has updated ${widget.activityName}',
                                  notification: updateNotificationStruct(
                                    NotificationStruct(
                                      notificationTitle:
                                          '$currentUserDisplayName has updated ${widget.activityName}',
                                      descriptions: _model.textController.text,
                                      timeStamp: getCurrentTimestamp,
                                      isRead: false,
                                    ),
                                    clearUnsetFields: false,
                                    create: true,
                                  ),
                                  isread: false,
                                  createDate: getCurrentTimestamp,
                                ),
                                ...mapToFirestore(
                                  {
                                    'userref': [FFAppState().superadminref],
                                    'schoolref': [widget.schoolref],
                                  },
                                ),
                              });
                              FFAppState().studenttimelineimage = '';
                              safeSetState(() {});
                              FFAppState().loopmin = 0;
                              FFAppState().selectedstudents = [];
                              safeSetState(() {});

                              context.goNamed('Dashboard');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Student timeline updated.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 1150),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              );
                              FFAppState().studenttimelineimage = '';
                              safeSetState(() {});
                              FFAppState().loopmin = 0;
                              FFAppState().selectedstudents = [];
                              safeSetState(() {});

                              context.pushNamed(
                                'class_dashboard',
                                queryParameters: {
                                  'schoolref': serializeParam(
                                    widget.schoolref,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please select atleast one student.',
                                  style: TextStyle(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 1500),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                              ),
                            );
                          }

                          safeSetState(() {});
                        },
                        text: 'Send update',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ].addToEnd(const SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
