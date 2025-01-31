import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/confirmationpages/eventpostedsuccessfully/eventpostedsuccessfully_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/quick_action_selectclass/quick_action_selectclass_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'select_class_calender_model.dart';
export 'select_class_calender_model.dart';

class SelectClassCalenderWidget extends StatefulWidget {
  const SelectClassCalenderWidget({
    super.key,
    required this.schoolref,
    required this.eventtitle,
    required this.eventname,
    required this.description,
    required this.datetime,
    this.images,
  });

  final DocumentReference? schoolref;
  final String? eventtitle;
  final String? eventname;
  final String? description;
  final DateTime? datetime;
  final List<String>? images;

  @override
  State<SelectClassCalenderWidget> createState() =>
      _SelectClassCalenderWidgetState();
}

class _SelectClassCalenderWidgetState extends State<SelectClassCalenderWidget> {
  late SelectClassCalenderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectClassCalenderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Builder(
          builder: (context) {
            if (valueOrDefault(currentUserDocument?.userRole, 0) == 2) {
              return StreamBuilder<SchoolRecord>(
                stream: SchoolRecord.getDocument(widget.schoolref!),
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

                  final containerSchoolRecord = snapshot.data!;

                  return Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiary,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.6,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tertiary,
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Select class',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      if ((_model.everyone == 0) ||
                                          (_model.everyone == 1))
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 12.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (_model.everyone == 1) {
                                                _model.everyone = 0;
                                                _model.toWhome = [];
                                                safeSetState(() {});
                                              } else {
                                                _model.everyone = 1;
                                                _model.toWhome = [];
                                                safeSetState(() {});
                                                _model.addToToWhome('Everyone');
                                                safeSetState(() {});
                                              }
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.8,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.1,
                                                decoration: BoxDecoration(
                                                  color: _model.everyone == 1
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .lightblue
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                  border: Border.all(
                                                    color: const Color(0xFFDDF1F6),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Everyone',
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
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    Text(
                                                      'Student : ${containerSchoolRecord.studentDataList.where((e) => e.isDraft == false).toList().length.toString()}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if ((_model.everyone == 0) ||
                                          (_model.everyone == 2))
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: Builder(
                                            builder: (context) {
                                              final schoolClassref =
                                                  containerSchoolRecord
                                                      .listOfClass
                                                      .toList();

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    schoolClassref.length,
                                                itemBuilder: (context,
                                                    schoolClassrefIndex) {
                                                  final schoolClassrefItem =
                                                      schoolClassref[
                                                          schoolClassrefIndex];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 12.0),
                                                    child: StreamBuilder<
                                                        SchoolClassRecord>(
                                                      stream: SchoolClassRecord
                                                          .getDocument(
                                                              schoolClassrefItem),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return SizedBox(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.4,
                                                            child:
                                                                const QuickActionSelectclassWidget(),
                                                          );
                                                        }

                                                        final containerSchoolClassRecord =
                                                            snapshot.data!;

                                                        return InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            if (!_model
                                                                .schoolclassref
                                                                .contains(
                                                                    schoolClassrefItem)) {
                                                              _model.addToSchoolclassref(
                                                                  schoolClassrefItem);
                                                              _model.toWhome = functions
                                                                  .removeaname(
                                                                      _model
                                                                          .toWhome
                                                                          .toList(),
                                                                      'Everyone')
                                                                  .toList()
                                                                  .cast<
                                                                      String>();
                                                              safeSetState(
                                                                  () {});
                                                              _model.addToToWhome(
                                                                  containerSchoolClassRecord
                                                                      .className);
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              _model.removeFromSchoolclassref(
                                                                  schoolClassrefItem);
                                                              _model.toWhome = functions
                                                                  .removeaname(
                                                                      _model
                                                                          .toWhome
                                                                          .toList(),
                                                                      containerSchoolClassRecord
                                                                          .className)
                                                                  .toList()
                                                                  .cast<
                                                                      String>();
                                                              safeSetState(
                                                                  () {});
                                                            }

                                                            if (_model
                                                                    .schoolclassref.isNotEmpty) {
                                                              _model.everyone =
                                                                  2;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              _model.everyone =
                                                                  0;
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          },
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 5.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14.0),
                                                            ),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.8,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _model
                                                                        .schoolclassref
                                                                        .contains(
                                                                            schoolClassrefItem)
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .lightblue
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14.0),
                                                                border:
                                                                    Border.all(
                                                                  color: const Color(
                                                                      0xFFDDF1F6),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Text(
                                                                    containerSchoolClassRecord
                                                                        .className,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    'Student  : ${containerSchoolClassRecord.studentsList.length.toString()}',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                    ].addToEnd(const SizedBox(height: 20.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                text: 'Cancel',
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.06,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0.0,
                                  borderSide: const BorderSide(
                                    color: Color(0xFFEFF0F6),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    if (valueOrDefault(
                                            currentUserDocument?.userRole, 0) ==
                                        2) {
                                      if (_model.everyone == 2) {
                                        while (FFAppState().loopmin <
                                            _model.schoolclassref.length) {
                                          await _model.schoolclassref
                                              .elementAtOrNull(
                                                  FFAppState().loopmin)!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'calendar':
                                                    FieldValue.arrayUnion([
                                                  getEventsNoticeFirestoreData(
                                                    updateEventsNoticeStruct(
                                                      EventsNoticeStruct(
                                                        eventId: functions
                                                            .generateUniqueId(),
                                                        eventName:
                                                            widget.eventname,
                                                        eventTitle:
                                                            widget.eventtitle,
                                                        eventDescription:
                                                            widget.description,
                                                        eventDate:
                                                            widget.datetime,
                                                        eventImages:
                                                            widget.images,
                                                      ),
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });
                                          _model.schoolClassTff =
                                              await SchoolClassRecord
                                                  .getDocumentOnce(_model
                                                      .schoolclassref
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          _model.studentnotice =
                                              await StudentsRecord
                                                  .getDocumentOnce(_model
                                                      .schoolClassTff!
                                                      .studentsList
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        _model.classes =
                                            await querySchoolClassRecordOnce();
                                        triggerPushNotification(
                                          notificationTitle: widget.eventname!,
                                          notificationText: widget.eventtitle!,
                                          scheduledTime: functions
                                              .noticedate(widget.datetime)!,
                                          notificationSound: 'default',
                                          userRefs: functions
                                              .filterClassesByReferences(_model
                                                  .classes!
                                                  .where((e) => _model
                                                      .schoolclassref
                                                      .contains(e.reference))
                                                  .toList())
                                              .toList(),
                                          initialPageName:
                                              'Notification_Teacher',
                                          parameterData: {
                                            'schoolref':
                                                containerSchoolRecord.reference,
                                          },
                                        );

                                        await NotificationsRecord.collection
                                            .doc()
                                            .set({
                                          ...createNotificationsRecordData(
                                            content: widget.eventtitle,
                                            descri: widget.description,
                                            datetimeofevent: widget.datetime,
                                            notification:
                                                updateNotificationStruct(
                                              NotificationStruct(
                                                notificationTitle:
                                                    widget.eventtitle,
                                                descriptions:
                                                    widget.description,
                                                isRead: false,
                                                timeStamp: getCurrentTimestamp,
                                                eventDate: widget.datetime,
                                                notificationImages:
                                                    widget.images,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            isread: false,
                                            createDate: getCurrentTimestamp,
                                            tag: widget.eventname,
                                            addedby: currentUserReference,
                                            heading: 'Added a event',
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': functions
                                                  .filterClassesByReferences(
                                                      _model.classes!
                                                          .where((e) => _model
                                                              .schoolclassref
                                                              .contains(
                                                                  e.reference))
                                                          .toList()),
                                              'towhome': _model.toWhome,
                                            },
                                          ),
                                        });
                                        _model.students =
                                            await queryStudentsRecordOnce();
                                        while (FFAppState().loopmin ==
                                            _model.schoolclassref.length) {
                                          _model.classselect =
                                              await SchoolClassRecord
                                                  .getDocumentOnce(_model
                                                      .schoolclassref
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventname!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: functions
                                                .extractParentUserRefs(_model
                                                    .students!
                                                    .where((e) => _model
                                                        .classselect!
                                                        .studentsList
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
                                              content: widget.eventtitle,
                                              descri: widget.description,
                                              datetimeofevent: widget.datetime,
                                              notification:
                                                  updateNotificationStruct(
                                                NotificationStruct(
                                                  notificationTitle:
                                                      widget.eventtitle,
                                                  descriptions:
                                                      widget.description,
                                                  timeStamp:
                                                      getCurrentTimestamp,
                                                  isRead: false,
                                                  eventDate: widget.datetime,
                                                  notificationImages:
                                                      widget.images,
                                                ),
                                                clearUnsetFields: false,
                                                create: true,
                                              ),
                                              isread: false,
                                              createDate: getCurrentTimestamp,
                                              tag: widget.eventname,
                                              addedby: currentUserReference,
                                              heading: 'Added a event',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': functions
                                                    .extractParentUserRefs(
                                                        _model.students!
                                                            .where((e) => _model
                                                                .classselect!
                                                                .studentsList
                                                                .contains(e
                                                                    .reference))
                                                            .toList()),
                                                'towhome': _model.toWhome,
                                              },
                                            ),
                                          });
                                        }
                                        FFAppState().eventnoticeimage = [];
                                        FFAppState().update(() {});
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
                                                    const EventpostedsuccessfullyWidget(),
                                              ),
                                            );
                                          },
                                        );

                                        context.goNamed(
                                          'class_dashboard',
                                          queryParameters: {
                                            'schoolref': serializeParam(
                                              containerSchoolRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                            'tabindex': serializeParam(
                                              0,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else if (_model.everyone == 1) {
                                        await widget.schoolref!.update({
                                          ...mapToFirestore(
                                            {
                                              'Calendar_list':
                                                  FieldValue.arrayUnion([
                                                getEventsNoticeFirestoreData(
                                                  updateEventsNoticeStruct(
                                                    EventsNoticeStruct(
                                                      eventId: functions
                                                          .generateUniqueId(),
                                                      eventName:
                                                          widget.eventname,
                                                      eventTitle:
                                                          widget.eventtitle,
                                                      eventDescription:
                                                          widget.description,
                                                      eventDate:
                                                          widget.datetime,
                                                      eventImages:
                                                          widget.images,
                                                    ),
                                                    clearUnsetFields: false,
                                                  ),
                                                  true,
                                                )
                                              ]),
                                            },
                                          ),
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              ' The event has been added successfully.',
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
                                        triggerPushNotification(
                                          notificationTitle: widget.eventname!,
                                          notificationText: widget.eventtitle!,
                                          scheduledTime: functions
                                              .noticedate(widget.datetime)!,
                                          notificationSound: 'default',
                                          userRefs: containerSchoolRecord
                                              .listOfteachersuser
                                              .toList(),
                                          initialPageName: 'Dashboard',
                                          parameterData: {},
                                        );
                                        _model.studentsOfSchool =
                                            await queryStudentsRecordOnce();
                                        triggerPushNotification(
                                          notificationTitle: widget.eventname!,
                                          notificationText: widget.eventtitle!,
                                          scheduledTime: functions
                                              .noticedate(widget.datetime)!,
                                          userRefs: functions
                                              .extractParentUserRefs(_model
                                                  .studentsOfSchool!
                                                  .where((e) =>
                                                      containerSchoolRecord
                                                          .listOfStudents
                                                          .contains(
                                                              e.reference))
                                                  .toList())
                                              .toList(),
                                          initialPageName: 'Dashboard',
                                          parameterData: {},
                                        );

                                        await NotificationsRecord.collection
                                            .doc()
                                            .set({
                                          ...createNotificationsRecordData(
                                            content: widget.eventtitle,
                                            descri: widget.description,
                                            datetimeofevent: widget.datetime,
                                            notification:
                                                updateNotificationStruct(
                                              NotificationStruct(
                                                notificationTitle:
                                                    widget.eventtitle,
                                                descriptions:
                                                    widget.description,
                                                timeStamp: getCurrentTimestamp,
                                                isRead: false,
                                                eventDate: widget.datetime,
                                                notificationImages:
                                                    widget.images,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            isread: false,
                                            createDate: getCurrentTimestamp,
                                            tag: widget.eventname,
                                            addedby: currentUserReference,
                                            heading: 'Added a event',
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': functions
                                                  .extractParentUserRefs(_model
                                                      .studentsOfSchool!
                                                      .where((e) =>
                                                          containerSchoolRecord
                                                              .listOfStudents
                                                              .contains(
                                                                  e.reference))
                                                      .toList()),
                                              'towhome': _model.toWhome,
                                            },
                                          ),
                                        });

                                        await NotificationsRecord.collection
                                            .doc()
                                            .set({
                                          ...createNotificationsRecordData(
                                            content: widget.eventtitle,
                                            descri: widget.description,
                                            datetimeofevent: widget.datetime,
                                            notification:
                                                updateNotificationStruct(
                                              NotificationStruct(
                                                notificationTitle:
                                                    widget.eventtitle,
                                                descriptions:
                                                    widget.description,
                                                timeStamp: getCurrentTimestamp,
                                                isRead: false,
                                                eventDate: widget.datetime,
                                                notificationImages:
                                                    widget.images,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            isread: false,
                                            createDate: getCurrentTimestamp,
                                            tag: widget.eventname,
                                            addedby: currentUserReference,
                                            heading: 'Added a event',
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': containerSchoolRecord
                                                  .listOfteachersuser,
                                              'towhome': _model.toWhome,
                                              'schoolref': [widget.schoolref],
                                            },
                                          ),
                                        });
                                        FFAppState().eventnoticeimage = [];
                                        FFAppState().update(() {});
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
                                                    const EventpostedsuccessfullyWidget(),
                                              ),
                                            );
                                          },
                                        );

                                        context.goNamed(
                                          'class_dashboard',
                                          queryParameters: {
                                            'schoolref': serializeParam(
                                              containerSchoolRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                            'tabindex': serializeParam(
                                              0,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else if (containerSchoolRecord
                                              .listOfNotice.isEmpty) {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Alert!'),
                                              content: const Text(
                                                  ' Please select at least one class.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: const Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Alert!'),
                                              content: const Text(
                                                  ' Please select at least one class.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: const Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    } else if (valueOrDefault(
                                            currentUserDocument?.userRole, 0) ==
                                        3) {
                                      while (FFAppState().loopmin <
                                          _model.schoolclassref.length) {
                                        await _model.schoolclassref
                                            .elementAtOrNull(
                                                FFAppState().loopmin)!
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'calendar':
                                                  FieldValue.arrayUnion([
                                                getEventsNoticeFirestoreData(
                                                  updateEventsNoticeStruct(
                                                    EventsNoticeStruct(
                                                      eventId: functions
                                                          .generateUniqueId(),
                                                      eventName:
                                                          widget.eventname,
                                                      eventTitle:
                                                          widget.eventtitle,
                                                      eventDescription:
                                                          widget.description,
                                                      eventDate:
                                                          widget.datetime,
                                                      eventImages:
                                                          widget.images,
                                                    ),
                                                    clearUnsetFields: false,
                                                  ),
                                                  true,
                                                )
                                              ]),
                                            },
                                          ),
                                        });
                                        _model.schoolClassT =
                                            await SchoolClassRecord
                                                .getDocumentOnce(_model
                                                    .schoolclassref
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)!);
                                        FFAppState().loopmin =
                                            FFAppState().loopmin + 1;
                                        safeSetState(() {});
                                      }
                                      FFAppState().loopmin = 0;
                                      safeSetState(() {});
                                      _model.classses123 =
                                          await querySchoolClassRecordOnce();
                                      triggerPushNotification(
                                        notificationTitle: widget.eventname!,
                                        notificationText: widget.eventtitle!,
                                        scheduledTime: functions
                                            .noticedate(widget.datetime)!,
                                        userRefs: functions
                                            .filterClassesByReferences(_model
                                                .classses123!
                                                .where((e) => _model
                                                    .schoolclassref
                                                    .contains(e.reference))
                                                .toList())
                                            .toList(),
                                        initialPageName: 'Notification_Teacher',
                                        parameterData: {
                                          'schoolref':
                                              containerSchoolRecord.reference,
                                        },
                                      );

                                      await NotificationsRecord.collection
                                          .doc()
                                          .set({
                                        ...createNotificationsRecordData(
                                          content:
                                              '${widget.eventname} : ${widget.eventtitle} on ${dateTimeFormat("yMMMd", widget.datetime)}',
                                          descri: widget.description,
                                          datetimeofevent: widget.datetime,
                                          notification:
                                              updateNotificationStruct(
                                            NotificationStruct(
                                              notificationTitle:
                                                  widget.eventtitle,
                                              descriptions: widget.description,
                                              timeStamp: getCurrentTimestamp,
                                              isRead: false,
                                              eventDate: widget.datetime,
                                              notificationImages:
                                                  widget.images,
                                            ),
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          createDate: getCurrentTimestamp,
                                          isread: false,
                                          tag: widget.eventname,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'userref': functions
                                                .filterClassesByReferences(
                                                    _model.classses123!
                                                        .where((e) => _model
                                                            .schoolclassref
                                                            .contains(
                                                                e.reference))
                                                        .toList()),
                                          },
                                        ),
                                      });
                                      _model.students3 =
                                          await queryStudentsRecordOnce();
                                      while (FFAppState().loopmin ==
                                          _model.schoolclassref.length) {
                                        _model.classselect3 =
                                            await SchoolClassRecord
                                                .getDocumentOnce(_model
                                                    .schoolclassref
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)!);
                                        triggerPushNotification(
                                          notificationTitle: widget.eventname!,
                                          notificationText: widget.eventtitle!,
                                          scheduledTime: functions
                                              .noticedate(widget.datetime)!,
                                          userRefs: functions
                                              .extractParentUserRefs(_model
                                                  .students3!
                                                  .where((e) => _model
                                                      .classselect3!
                                                      .studentsList
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
                                                '${widget.eventname} : ${widget.eventtitle} on ${dateTimeFormat("yMMMd", widget.datetime)}',
                                            descri: widget.description,
                                            datetimeofevent: widget.datetime,
                                            createDate: getCurrentTimestamp,
                                            notification:
                                                updateNotificationStruct(
                                              NotificationStruct(
                                                notificationTitle:
                                                    widget.eventtitle,
                                                descriptions:
                                                    widget.description,
                                                timeStamp: getCurrentTimestamp,
                                                isRead: false,
                                                eventDate: widget.datetime,
                                                notificationImages:
                                                    widget.images,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            isread: false,
                                            tag: widget.eventname,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': functions
                                                  .extractParentUserRefs(_model
                                                      .students3!
                                                      .where((e) => _model
                                                          .classselect3!
                                                          .studentsList
                                                          .contains(
                                                              e.reference))
                                                      .toList()),
                                            },
                                          ),
                                        });
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Event Updated ',
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
                                      FFAppState().eventnoticeimage = [];
                                      safeSetState(() {});
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: const AlignmentDirectional(
                                                    0.0, -0.8)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.08,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.6,
                                              child:
                                                  const EventpostedsuccessfullyWidget(),
                                            ),
                                          );
                                        },
                                      );

                                      Navigator.pop(context);
                                    }

                                    safeSetState(() {});
                                  },
                                  text: 'Send',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
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
                                              .secondary,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFFEFF0F6),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ].divide(const SizedBox(height: 5.0)),
                      ),
                    ),
                  );
                },
              );
            } else {
              return StreamBuilder<List<TeachersRecord>>(
                stream: queryTeachersRecord(
                  queryBuilder: (teachersRecord) => teachersRecord.where(
                    'useref',
                    isEqualTo: currentUserReference,
                  ),
                  singleRecord: true,
                ),
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
                  List<TeachersRecord> containerTeachersRecordList =
                      snapshot.data!;
                  // Return an empty Container when the item does not exist.
                  if (snapshot.data!.isEmpty) {
                    return Container();
                  }
                  final containerTeachersRecord =
                      containerTeachersRecordList.isNotEmpty
                          ? containerTeachersRecordList.first
                          : null;

                  return Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiary,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StreamBuilder<List<SchoolClassRecord>>(
                            stream: querySchoolClassRecord(
                              queryBuilder: (schoolClassRecord) =>
                                  schoolClassRecord.where(
                                'teachers_list',
                                arrayContains:
                                    containerTeachersRecord?.reference,
                              ),
                            ),
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
                              List<SchoolClassRecord>
                                  containerSchoolClassRecordList =
                                  snapshot.data!;

                              return Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).tertiary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Select class',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryText,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: Builder(
                                            builder: (context) {
                                              final clases =
                                                  containerSchoolClassRecordList
                                                      .toList();

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: clases.length,
                                                itemBuilder:
                                                    (context, clasesIndex) {
                                                  final clasesItem =
                                                      clases[clasesIndex];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 12.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (!_model
                                                            .schoolclassref
                                                            .contains(clasesItem
                                                                .reference)) {
                                                          _model.addToSchoolclassref(
                                                              clasesItem
                                                                  .reference);
                                                          _model.addToToWhome(
                                                              clasesItem
                                                                  .className);
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.removeFromSchoolclassref(
                                                              clasesItem
                                                                  .reference);
                                                          _model.toWhome = functions
                                                              .removeaname(
                                                                  _model.toWhome
                                                                      .toList(),
                                                                  clasesItem
                                                                      .className)
                                                              .toList()
                                                              .cast<String>();
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.8,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: _model
                                                                    .schoolclassref
                                                                    .contains(
                                                                        clasesItem
                                                                            .reference)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .lightblue
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14.0),
                                                            border: Border.all(
                                                              color: const Color(
                                                                  0xFFDDF1F6),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            2.0),
                                                                child: Text(
                                                                  clasesItem
                                                                      .className,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'Students : ${clasesItem.studentsList.length.toString()}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ].addToEnd(const SizedBox(height: 20.0)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancel',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFFEFF0F6),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.schoolclassref.isNotEmpty) {
                                        while (FFAppState().loopmin <
                                            _model.schoolclassref.length) {
                                          await _model.schoolclassref
                                              .elementAtOrNull(
                                                  FFAppState().loopmin)!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'calendar':
                                                    FieldValue.arrayUnion([
                                                  getEventsNoticeFirestoreData(
                                                    updateEventsNoticeStruct(
                                                      EventsNoticeStruct(
                                                        eventId: functions
                                                            .generateUniqueId(),
                                                        eventName:
                                                            widget.eventname,
                                                        eventTitle:
                                                            widget.eventtitle,
                                                        eventDescription:
                                                            widget.description,
                                                        eventDate:
                                                            widget.datetime,
                                                        eventImages:
                                                            widget.images,
                                                      ),
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });
                                          _model.schoolClassT3 =
                                              await SchoolClassRecord
                                                  .getDocumentOnce(_model
                                                      .schoolclassref
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        _model.classses1233 =
                                            await querySchoolClassRecordOnce();
                                        triggerPushNotification(
                                          notificationTitle: widget.eventname!,
                                          notificationText: widget.eventtitle!,
                                          userRefs: functions
                                              .filterClassesByReferences(_model
                                                  .classses1233!
                                                  .where((e) => _model
                                                      .schoolclassref
                                                      .contains(e.reference))
                                                  .toList())
                                              .toList(),
                                          initialPageName:
                                              'Notification_Teacher',
                                          parameterData: {
                                            'schoolref': widget.schoolref,
                                          },
                                        );

                                        await NotificationsRecord.collection
                                            .doc()
                                            .set({
                                          ...createNotificationsRecordData(
                                            content: widget.eventtitle,
                                            descri: widget.description,
                                            datetimeofevent: widget.datetime,
                                            notification:
                                                updateNotificationStruct(
                                              NotificationStruct(
                                                notificationTitle:
                                                    widget.eventtitle,
                                                descriptions:
                                                    widget.description,
                                                timeStamp: getCurrentTimestamp,
                                                isRead: false,
                                                eventDate: widget.datetime,
                                                notificationImages:
                                                    widget.images,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            createDate: getCurrentTimestamp,
                                            isread: false,
                                            tag: widget.eventname,
                                            addedby: currentUserReference,
                                            heading: 'Added a event',
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': functions
                                                  .filterClassesByReferences(
                                                      _model.classses1233!
                                                          .where((e) => _model
                                                              .schoolclassref
                                                              .contains(
                                                                  e.reference))
                                                          .toList()),
                                              'schoolref': [widget.schoolref],
                                              'towhome': _model.toWhome,
                                            },
                                          ),
                                        });
                                        _model.students33 =
                                            await queryStudentsRecordOnce();
                                        while (FFAppState().loopmin ==
                                            _model.schoolclassref.length) {
                                          _model.classselect33 =
                                              await SchoolClassRecord
                                                  .getDocumentOnce(_model
                                                      .schoolclassref
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventname!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: functions
                                                .extractParentUserRefs(_model
                                                    .students33!
                                                    .where((e) => _model
                                                        .classselect33!
                                                        .studentsList
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
                                              content: widget.eventtitle,
                                              descri: widget.description,
                                              datetimeofevent: widget.datetime,
                                              createDate: getCurrentTimestamp,
                                              notification:
                                                  updateNotificationStruct(
                                                NotificationStruct(
                                                  notificationTitle:
                                                      widget.eventtitle,
                                                  descriptions:
                                                      widget.description,
                                                  timeStamp:
                                                      getCurrentTimestamp,
                                                  isRead: false,
                                                  eventDate: widget.datetime,
                                                  notificationImages:
                                                      widget.images,
                                                ),
                                                clearUnsetFields: false,
                                                create: true,
                                              ),
                                              isread: false,
                                              tag: widget.eventname,
                                              addedby: currentUserReference,
                                              heading: 'Added a event',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': functions
                                                    .extractParentUserRefs(
                                                        _model.students33!
                                                            .where((e) => _model
                                                                .classselect33!
                                                                .studentsList
                                                                .contains(e
                                                                    .reference))
                                                            .toList()),
                                                'towhome': _model.toWhome,
                                              },
                                            ),
                                          });
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventname!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: _model.classselect33!
                                                .listOfteachersUser
                                                .toList(),
                                            initialPageName: 'Dashboard',
                                            parameterData: {},
                                          );

                                          await NotificationsRecord.collection
                                              .doc()
                                              .set({
                                            ...createNotificationsRecordData(
                                              content: widget.eventtitle,
                                              descri: widget.description,
                                              datetimeofevent: widget.datetime,
                                              createDate: getCurrentTimestamp,
                                              notification:
                                                  updateNotificationStruct(
                                                NotificationStruct(
                                                  notificationTitle:
                                                      widget.eventtitle,
                                                  descriptions:
                                                      widget.description,
                                                  timeStamp:
                                                      getCurrentTimestamp,
                                                  isRead: false,
                                                  eventDate: widget.datetime,
                                                  notificationImages:
                                                      widget.images,
                                                ),
                                                clearUnsetFields: false,
                                                create: true,
                                              ),
                                              isread: false,
                                              tag: widget.eventname,
                                              addedby: containerTeachersRecord
                                                  ?.useref,
                                              heading: 'Added a event',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': _model.classselect33
                                                    ?.listOfteachersUser,
                                                'towhome': _model.toWhome,
                                              },
                                            ),
                                          });
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              ' The event has been added successfully.',
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
                                        FFAppState().eventnoticeimage = [];
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
                                                    const EventpostedsuccessfullyWidget(),
                                              ),
                                            );
                                          },
                                        );

                                        context.goNamed(
                                          'Dashboard',
                                          queryParameters: {
                                            'tabindex': serializeParam(
                                              0,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Alert!'),
                                              content: const Text(
                                                  ' Please select at least one class.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: const Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Send',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.06,
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
                                                .secondary,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEFF0F6),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
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
            }
          },
        ),
      ],
    );
  }
}
