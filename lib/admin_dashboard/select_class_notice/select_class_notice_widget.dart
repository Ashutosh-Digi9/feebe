import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/confirmationpages/noticecreated/noticecreated_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/quick_action_selectclass/quick_action_selectclass_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'select_class_notice_model.dart';
export 'select_class_notice_model.dart';

class SelectClassNoticeWidget extends StatefulWidget {
  const SelectClassNoticeWidget({
    super.key,
    required this.schoolref,
    required this.eventtitle,
    required this.description,
    required this.datetime,
    this.images,
    required this.eventname,
  });

  final DocumentReference? schoolref;
  final String? eventtitle;
  final String? description;
  final DateTime? datetime;
  final List<String>? images;
  final String? eventname;

  @override
  State<SelectClassNoticeWidget> createState() =>
      _SelectClassNoticeWidgetState();
}

class _SelectClassNoticeWidgetState extends State<SelectClassNoticeWidget>
    with TickerProviderStateMixin {
  late SelectClassNoticeModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectClassNoticeModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 30.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 30.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
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
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: const QuickActionSelectclassWidget(),
                    );
                  }

                  final containerSchoolRecord = snapshot.data!;

                  return Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiary,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            decoration: const BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
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
                                    ),
                                    if ((_model.everyone == 0) ||
                                        (_model.everyone == 1))
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 14.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (_model.everyone == 1) {
                                              _model.everyone = 0;
                                              _model.toWHome = [];
                                              safeSetState(() {});
                                            } else {
                                              _model.everyone = 1;
                                              _model.toWHome = [];
                                              safeSetState(() {});
                                              _model.addToToWHome('Everyone');
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
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.8,
                                              height: MediaQuery.sizeOf(context)
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
                                                    BorderRadius.circular(14.0),
                                                border: Border.all(
                                                  color: const Color(0xFFDDF1F6),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Text(
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
                                                  ),
                                                  StreamBuilder<
                                                      List<StudentsRecord>>(
                                                    stream: queryStudentsRecord(
                                                      queryBuilder:
                                                          (studentsRecord) =>
                                                              studentsRecord
                                                                  .where(
                                                                    'schoolref',
                                                                    isEqualTo:
                                                                        containerSchoolRecord
                                                                            .reference,
                                                                  )
                                                                  .where(
                                                                    'isDraft',
                                                                    isEqualTo:
                                                                        false,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
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
                                                      List<StudentsRecord>
                                                          textStudentsRecordList =
                                                          snapshot.data!;

                                                      return Text(
                                                        'Student : ${containerSchoolRecord.studentDataList.where((e) => e.isDraft == false).toList().length.toString()}',
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
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      );
                                                    },
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
                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                              itemCount: schoolClassref.length,
                                              itemBuilder: (context,
                                                  schoolClassrefIndex) {
                                                final schoolClassrefItem =
                                                    schoolClassref[
                                                        schoolClassrefIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 14.0),
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
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height:
                                                              MediaQuery.sizeOf(
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
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          if (!_model.classref
                                                              .contains(
                                                                  schoolClassrefItem)) {
                                                            _model.addToClassref(
                                                                schoolClassrefItem);
                                                            _model.toWHome = functions
                                                                .removeaname(
                                                                    _model
                                                                        .toWHome
                                                                        .toList(),
                                                                    'Everyone')
                                                                .toList()
                                                                .cast<String>();
                                                            safeSetState(() {});
                                                            _model.addToToWHome(
                                                                containerSchoolClassRecord
                                                                    .className);
                                                            safeSetState(() {});
                                                          } else {
                                                            _model.removeFromClassref(
                                                                schoolClassrefItem);
                                                            _model.toWHome = functions
                                                                .removeaname(
                                                                    _model
                                                                        .toWHome
                                                                        .toList(),
                                                                    containerSchoolClassRecord
                                                                        .className)
                                                                .toList()
                                                                .cast<String>();
                                                            safeSetState(() {});
                                                          }

                                                          if (_model.classref.isNotEmpty) {
                                                            _model.everyone = 2;
                                                            safeSetState(() {});
                                                          } else {
                                                            _model.everyone = 0;
                                                            safeSetState(() {});
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
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.1,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: _model.classref
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
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child: Text(
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
                                                                  ),
                                                                  Text(
                                                                    'Student : ${containerSchoolClassRecord.studentsList.length.toString()}',
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
                          Padding(
                            padding: const EdgeInsets.all(20.0),
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
                                        0.05,
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
                                      if (valueOrDefault(
                                              currentUserDocument?.userRole,
                                              0) ==
                                          2) {
                                        if (_model.everyone == 2) {
                                          while (FFAppState().loopmin <
                                              _model.classref.length) {
                                            await _model.classref
                                                .elementAtOrNull(
                                                    FFAppState().loopmin)!
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'notice':
                                                      FieldValue.arrayUnion([
                                                    getEventsNoticeFirestoreData(
                                                      updateEventsNoticeStruct(
                                                        EventsNoticeStruct(
                                                          eventId: functions
                                                              .generateUniqueId(),
                                                          eventName:
                                                              widget.eventname,
                                                          eventTitle: widget
                                                              .eventtitle,
                                                          eventDescription:
                                                              widget
                                                                  .description,
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
                                            _model.classdoc =
                                                await SchoolClassRecord
                                                    .getDocumentOnce(_model
                                                        .classref
                                                        .elementAtOrNull(
                                                            FFAppState()
                                                                .loopmin)!);
                                            FFAppState().loopmin =
                                                FFAppState().loopmin + 1;
                                            safeSetState(() {});
                                          }
                                          FFAppState().loopmin = 0;
                                          safeSetState(() {});
                                          _model.listofclasses =
                                              await querySchoolClassRecordOnce();
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventtitle!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: functions
                                                .filterClassesByReferences(
                                                    _model.listofclasses!
                                                        .where((e) => _model
                                                            .classref
                                                            .contains(
                                                                e.reference))
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
                                              content: 'Notice',
                                              descri: widget.description,
                                              datetimeofevent: widget.datetime,
                                              isread: false,
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
                                              createDate: getCurrentTimestamp,
                                              tag: widget.eventname,
                                              addedby: currentUserReference,
                                              heading: 'Added a notice',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': functions
                                                    .filterClassesByReferences(
                                                        _model.listofclasses!
                                                            .where((e) => _model
                                                                .classref
                                                                .contains(e
                                                                    .reference))
                                                            .toList()),
                                                'towhome': _model.toWHome,
                                              },
                                            ),
                                          });
                                          _model.students =
                                              await queryStudentsRecordOnce();
                                          while (FFAppState().loopmin <
                                              _model.classref.length) {
                                            _model.classStudnt =
                                                await SchoolClassRecord
                                                    .getDocumentOnce(_model
                                                        .classref
                                                        .elementAtOrNull(
                                                            FFAppState()
                                                                .loopmin)!);
                                            triggerPushNotification(
                                              notificationTitle:
                                                  widget.eventtitle!,
                                              notificationText:
                                                  widget.eventtitle!,
                                              userRefs: functions
                                                  .extractParentUserRefs(_model
                                                      .students!
                                                      .where((e) => _model
                                                          .classStudnt!
                                                          .studentsList
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
                                                content: 'Notice',
                                                descri: widget.description,
                                                datetimeofevent:
                                                    widget.datetime,
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
                                                heading: 'Added a notice',
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'userref': functions
                                                      .extractParentUserRefs(_model
                                                          .students!
                                                          .where((e) => _model
                                                              .classStudnt!
                                                              .studentsList
                                                              .contains(
                                                                  e.reference))
                                                          .toList()),
                                                  'towhome': _model.toWHome,
                                                },
                                              ),
                                            });
                                            FFAppState().loopmin =
                                                FFAppState().loopmin + 1;
                                            safeSetState(() {});
                                          }
                                          FFAppState().loopmin = 0;
                                          FFAppState().update(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'The notice has been added successfully.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 1700),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
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
                                                  child: const NoticecreatedWidget(),
                                                ),
                                              );
                                            },
                                          );

                                          context.goNamed(
                                            'class_dashboard',
                                            queryParameters: {
                                              'schoolref': serializeParam(
                                                widget.schoolref,
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
                                                'List_of_notice':
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
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventtitle!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: containerSchoolRecord
                                                .listOfteachersuser
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
                                              content: 'Notice',
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
                                              descri: widget.description,
                                              datetimeofevent: widget.datetime,
                                              isread: false,
                                              createDate: getCurrentTimestamp,
                                              tag: widget.eventname,
                                              addedby: currentUserReference,
                                              heading: 'Added a notice',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': containerSchoolRecord
                                                    .listOfteachersuser,
                                                'towhome': _model.toWHome,
                                              },
                                            ),
                                          });
                                          _model.studentEveryone =
                                              await queryStudentsRecordOnce();
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventtitle!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: functions
                                                .extractParentUserRefs(_model
                                                    .studentEveryone!
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
                                              content: 'Notice',
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
                                              descri: widget.description,
                                              datetimeofevent: widget.datetime,
                                              isread: false,
                                              createDate: getCurrentTimestamp,
                                              tag: widget.eventname,
                                              addedby: currentUserReference,
                                              heading: 'Added a notice',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': functions
                                                    .extractParentUserRefs(_model
                                                        .studentEveryone!
                                                        .where((e) =>
                                                            containerSchoolRecord
                                                                .listOfStudents
                                                                .contains(e
                                                                    .reference))
                                                        .toList()),
                                                'towhome': _model.toWHome,
                                              },
                                            ),
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'The notice has been added successfully.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 1700),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
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
                                                  child: const NoticecreatedWidget(),
                                                ),
                                              );
                                            },
                                          );

                                          context.goNamed(
                                            'class_dashboard',
                                            queryParameters: {
                                              'schoolref': serializeParam(
                                                widget.schoolref,
                                                ParamType.DocumentReference,
                                              ),
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
                                                title: const Text('Select Class.'),
                                                content: const Text(
                                                    'Please select at least one class to send the notice.'),
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
                                              currentUserDocument?.userRole,
                                              0) ==
                                          3) {
                                        while (FFAppState().loopmin <
                                            _model.classref.length) {
                                          await _model.classref
                                              .elementAtOrNull(
                                                  FFAppState().loopmin)!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'notice':
                                                    FieldValue.arrayUnion([
                                                  getEventsNoticeFirestoreData(
                                                    updateEventsNoticeStruct(
                                                      EventsNoticeStruct(
                                                        eventId: functions
                                                            .generateUniqueId(),
                                                        eventTitle:
                                                            widget.eventtitle,
                                                        eventDescription:
                                                            widget.description,
                                                        eventDate:
                                                            widget.datetime,
                                                        eventImages:
                                                            widget.images,
                                                        eventName:
                                                            widget.eventname,
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
                                                      .classref
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        _model.listofclasses1 =
                                            await querySchoolClassRecordOnce();
                                        triggerPushNotification(
                                          notificationTitle:
                                              widget.eventtitle!,
                                          notificationText: widget.eventtitle!,
                                          userRefs: functions
                                              .filterClassesByReferences(_model
                                                  .listofclasses1!
                                                  .where((e) => _model.classref
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
                                            content:
                                                '${widget.eventtitle} on ${dateTimeFormat("yMMMd", widget.datetime)}',
                                            descri: widget.description,
                                            datetimeofevent: widget.datetime,
                                            isread: false,
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
                                            tag: widget.eventname,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'userref': functions
                                                  .filterClassesByReferences(
                                                      _model.listofclasses1!
                                                          .where((e) => _model
                                                              .classref
                                                              .contains(
                                                                  e.reference))
                                                          .toList()),
                                            },
                                          ),
                                        });
                                        _model.students1234 =
                                            await queryStudentsRecordOnce();
                                        while (FFAppState().loopmin <
                                            _model.classref.length) {
                                          _model.classStudnt123 =
                                              await SchoolClassRecord
                                                  .getDocumentOnce(_model
                                                      .classref
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventtitle!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: functions
                                                .extractParentUserRefs(_model
                                                    .students1234!
                                                    .where((e) => _model
                                                        .classStudnt123!
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
                                              content: 'Notice',
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
                                              heading: 'Added a notice',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': functions
                                                    .extractParentUserRefs(
                                                        _model.students1234!
                                                            .where((e) => _model
                                                                .classStudnt123!
                                                                .studentsList
                                                                .contains(e
                                                                    .reference))
                                                            .toList()),
                                                'towhome': _model.toWHome,
                                              },
                                            ),
                                          });
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'The notice has been added successfully.',
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
                                        Navigator.pop(context);
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Send',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
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
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation1']!);
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
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: const QuickActionSelectclassWidget(),
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
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiary,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
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
                                return SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  child: const QuickActionSelectclassWidget(),
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
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Select class',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Builder(
                                            builder: (context) {
                                              final clases =
                                                  containerSchoolClassRecordList
                                                      .toList();

                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                primary: false,
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
                                                        if (!_model.classref
                                                            .contains(clasesItem
                                                                .reference)) {
                                                          _model.addToClassref(
                                                              clasesItem
                                                                  .reference);
                                                          _model.addToClassname(
                                                              clasesItem
                                                                  .className);
                                                          _model.addToToWHome(
                                                              clasesItem
                                                                  .className);
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.removeFromClassref(
                                                              clasesItem
                                                                  .reference);
                                                          _model.removeFromClassname(
                                                              clasesItem
                                                                  .className);
                                                          _model.toWHome = []
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
                                                                  0.7,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: _model
                                                                    .classref
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
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                  child: Text(
                                                                    clasesItem
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
                                                                ),
                                                                Text(
                                                                  'Student : ${clasesItem.studentsList.length.toString()}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryText,
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
                            padding: const EdgeInsets.all(20.0),
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
                                        MediaQuery.sizeOf(context).width * 0.35,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.05,
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
                                      if (_model.classref.isNotEmpty) {
                                        while (FFAppState().loopmin <
                                            _model.classref.length) {
                                          await _model.classref
                                              .elementAtOrNull(
                                                  FFAppState().loopmin)!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'notice':
                                                    FieldValue.arrayUnion([
                                                  getEventsNoticeFirestoreData(
                                                    updateEventsNoticeStruct(
                                                      EventsNoticeStruct(
                                                        eventId: functions
                                                            .generateUniqueId(),
                                                        eventDescription:
                                                            widget.description,
                                                        eventDate:
                                                            widget.datetime,
                                                        eventTitle:
                                                            widget.eventtitle,
                                                        eventImages:
                                                            widget.images,
                                                        eventName:
                                                            widget.eventname,
                                                      ),
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        _model.school =
                                            await SchoolRecord.getDocumentOnce(
                                                widget.schoolref!);
                                        triggerPushNotification(
                                          notificationTitle:
                                              widget.eventtitle!,
                                          notificationText: widget.eventtitle!,
                                          userRefs: [
                                            _model.school!.principalDetails
                                                .principalId!
                                          ],
                                          initialPageName: 'Dashboard',
                                          parameterData: {},
                                        );

                                        await NotificationsRecord.collection
                                            .doc()
                                            .set({
                                          ...createNotificationsRecordData(
                                            content: 'Notice',
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
                                            addedby:
                                                containerTeachersRecord?.useref,
                                            heading: 'Added a Notice',
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'schoolref': [widget.schoolref],
                                              'towhome': _model.toWHome,
                                            },
                                          ),
                                        });
                                        _model.studentquery =
                                            await queryStudentsRecordOnce();
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        while (FFAppState().loopmin <
                                            _model.classref.length) {
                                          _model.classesstudentQuery =
                                              await SchoolClassRecord
                                                  .getDocumentOnce(_model
                                                      .classref
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);
                                          triggerPushNotification(
                                            notificationTitle:
                                                widget.eventtitle!,
                                            notificationText:
                                                widget.eventtitle!,
                                            userRefs: functions
                                                .extractParentUserRefs(_model
                                                    .studentquery!
                                                    .where((e) => _model
                                                        .classesstudentQuery!
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
                                              content: 'Notice',
                                              descri: widget.description,
                                              datetimeofevent: widget.datetime,
                                              isread: false,
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
                                              createDate: getCurrentTimestamp,
                                              tag: widget.eventname,
                                              addedby: currentUserReference,
                                              heading: 'Added a notice',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'userref': functions
                                                    .extractParentUserRefs(_model
                                                        .studentquery!
                                                        .where((e) => _model
                                                            .classesstudentQuery!
                                                            .studentsList
                                                            .contains(
                                                                e.reference))
                                                        .toList()),
                                                'towhome': _model.toWHome,
                                              },
                                            ),
                                          });
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        FFAppState().eventnoticeimage = [];
                                        _model.updatePage(() {});
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
                                                child: const NoticecreatedWidget(),
                                              ),
                                            );
                                          },
                                        );

                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Atleast one class needs to be selected ',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            duration:
                                                const Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Send',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.35,
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
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation2']!);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
