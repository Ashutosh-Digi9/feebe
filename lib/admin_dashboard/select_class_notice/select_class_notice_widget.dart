import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/notice_created_widget.dart';
import '/confirmationpages/noticecreated/noticecreated_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/quick_action_selectclass/quick_action_selectclass_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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
            begin: Offset(0.0, 30.0),
            end: Offset(0.0, 0.0),
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
            begin: Offset(0.0, 30.0),
            end: Offset(0.0, 0.0),
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
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: QuickActionSelectclassWidget(),
                    );
                  }

                  final containerSchoolRecord = snapshot.data!;

                  return Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiary,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 16.0,
                          color: Color(0x07000000),
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'Select class',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    if ((_model.everyone == 0) ||
                                        (_model.everyone == 1))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 12.0),
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
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
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
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 20.0,
                                                    color: Color(0x05000000),
                                                    offset: Offset(
                                                      0.0,
                                                      0.0,
                                                    ),
                                                    spreadRadius: 0.0,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: Color(0xFFDDF1F6),
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
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Text(
                                                      'Everyone',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
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
                                                                  font: GoogleFonts
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
                                                                      .tertiaryText,
                                                                  fontSize:
                                                                      12.0,
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 12.0),
                                                  child: StreamBuilder<
                                                      SchoolClassRecord>(
                                                    stream: SchoolClassRecord
                                                        .getDocument(
                                                            schoolClassrefItem),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Container(
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
                                                              QuickActionSelectclassWidget(),
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

                                                          if (_model.classref
                                                                  .length !=
                                                              0) {
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
                                                          elevation: 2.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
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
                                                              color: _model.classref
                                                                      .contains(
                                                                          schoolClassrefItem)
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .lightblue
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      20.0,
                                                                  color: Color(
                                                                      0x06000000),
                                                                  offset:
                                                                      Offset(
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                                  spreadRadius:
                                                                      0.0,
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFDDF1F6),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
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
                                                                    padding: EdgeInsetsDirectional
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
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Student : ${containerSchoolClassRecord.studentsList.length.toString()}',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiaryText,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
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
                                  ].addToEnd(SizedBox(height: 20.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    FFAppState().eventfiles = [];
                                    safeSetState(() {});
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancel',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.055,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                      shadows: [
                                        Shadow(
                                          color: Color(0x0CF4F5FA),
                                          offset: Offset(0.0, -3.0),
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      _model.id = functions.generateUniqueId();
                                      safeSetState(() {});
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
                                                          eventId: _model.id,
                                                          eventName:
                                                              widget.eventname,
                                                          eventTitle: widget
                                                              .eventtitle,
                                                          eventDescription:
                                                              widget
                                                                  .description,
                                                          eventDate:
                                                              widget.datetime,
                                                          eventfiles:
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

                                          await widget.schoolref!.update({
                                            ...mapToFirestore(
                                              {
                                                'List_of_notice':
                                                    FieldValue.arrayUnion([
                                                  getEventsNoticeFirestoreData(
                                                    createEventsNoticeStruct(
                                                      eventId: _model.id,
                                                      eventName:
                                                          widget.eventname,
                                                      eventTitle:
                                                          widget.eventtitle,
                                                      eventDescription:
                                                          widget.description,
                                                      eventDate:
                                                          widget.datetime,
                                                      fieldValues: {
                                                        'eventfiles':
                                                            widget.images,
                                                        'classref':
                                                            _model.classref,
                                                      },
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });
                                          _model.listofclasses =
                                              await querySchoolClassRecordOnce();
                                          triggerPushNotification(
                                            notificationTitle: 'Notice',
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
                                              content: widget.eventtitle,
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
                                                  notificationFiles:
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
                                                'towhome': _model.toWHome,
                                                'schoolref': [
                                                  containerSchoolRecord
                                                      .reference
                                                ],
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
                                              notificationTitle: 'Notice',
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
                                                  Duration(milliseconds: 1700),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
                                          FFAppState().eventfiles = [];
                                          FFAppState().update(() {});
                                          _model.everyone = 0;
                                          _model.toWHome = [];
                                          _model.classref = [];
                                          _model.color = Color(4294967295);
                                          _model.classname = [];
                                          _model.updatePage(() {});
                                          FFAppState().eventname = 'General';
                                          FFAppState().eventfiles = [];
                                          FFAppState().update(() {});
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, -0.8)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: Container(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.08,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.72,
                                                  child: NoticeCreatedWidget(
                                                    schoolref:
                                                        containerSchoolRecord
                                                            .reference,
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                          Navigator.pop(context);

                                          context.goNamed(
                                            ClassDashboardWidget.routeName,
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
                                                'List_of_notice':
                                                    FieldValue.arrayUnion([
                                                  getEventsNoticeFirestoreData(
                                                    updateEventsNoticeStruct(
                                                      EventsNoticeStruct(
                                                        eventId: _model.id,
                                                        eventName:
                                                            widget.eventname,
                                                        eventTitle:
                                                            widget.eventtitle,
                                                        eventDescription:
                                                            widget.description,
                                                        eventDate:
                                                            widget.datetime,
                                                        eventfiles:
                                                            widget.images,
                                                        classref:
                                                            containerSchoolRecord
                                                                .listOfClass,
                                                      ),
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });
                                          while (FFAppState().loopmin <
                                              containerSchoolRecord
                                                  .listOfClass.length) {
                                            await containerSchoolRecord
                                                .listOfClass
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
                                                          eventId: _model.id,
                                                          eventName:
                                                              widget.eventname,
                                                          eventTitle: widget
                                                              .eventtitle,
                                                          eventDescription:
                                                              widget
                                                                  .description,
                                                          eventDate:
                                                              widget.datetime,
                                                          eventfiles:
                                                              widget.images,
                                                          classref:
                                                              containerSchoolRecord
                                                                  .listOfClass,
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
                                          triggerPushNotification(
                                            notificationTitle: 'Notice',
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
                                              content: widget.eventtitle,
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
                                                  notificationFiles:
                                                      widget.images,
                                                ),
                                                clearUnsetFields: false,
                                                create: true,
                                              ),
                                              descri: '${widget.description}',
                                              datetimeofevent: widget.datetime,
                                              isread: false,
                                              createDate: getCurrentTimestamp,
                                              tag: widget.eventname,
                                              addedby: currentUserReference,
                                              heading: 'Posted a notice',
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'towhome': _model.toWHome,
                                                'schoolref': [
                                                  containerSchoolRecord
                                                      .reference
                                                ],
                                              },
                                            ),
                                          });
                                          _model.studentEveryone =
                                              await queryStudentsRecordOnce();
                                          triggerPushNotification(
                                            notificationTitle: 'Notice',
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
                                          FFAppState().eventname = 'General';
                                          FFAppState().eventfiles = [];
                                          FFAppState().update(() {});
                                          _model.everyone = 0;
                                          _model.toWHome = [];
                                          _model.classref = [];
                                          _model.color = Color(4294967295);
                                          _model.classname = [];
                                          _model.updatePage(() {});
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, -0.8)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: Container(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.08,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.72,
                                                  child: NoticeCreatedWidget(
                                                    schoolref:
                                                        containerSchoolRecord
                                                            .reference,
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                          Navigator.pop(context);

                                          context.goNamed(
                                            ClassDashboardWidget.routeName,
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
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Alert!'),
                                                content: Text(
                                                    'Please select class.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
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
                                                        eventId: _model.id,
                                                        eventTitle:
                                                            widget.eventtitle,
                                                        eventDescription:
                                                            widget.description,
                                                        eventDate:
                                                            widget.datetime,
                                                        eventName:
                                                            widget.eventname,
                                                        eventfiles: FFAppState()
                                                            .eventfiles,
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
                                            descri:
                                                '\"${widget.eventname}\"  Notice- \"${widget.eventtitle}\" ${widget.description}',
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
                                                notificationFiles:
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
                                                Duration(milliseconds: 4000),
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
                                              0.055,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xFF375DF8),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                          ),
                                          Shadow(
                                            color: Color(0x0B253EA7),
                                            offset: Offset(2.0, 1.0),
                                            blurRadius: 2.0,
                                          )
                                        ],
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Color(0xFFEFF0F6),
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
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
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: QuickActionSelectclassWidget(),
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
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 16.0,
                          color: Color(0x0A000000),
                          offset: Offset(
                            0.0,
                            20.0,
                          ),
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(24.0),
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
                                return Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.5,
                                  child: QuickActionSelectclassWidget(),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            'Select class',
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                        EdgeInsetsDirectional
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
                                                        elevation: 2.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
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
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius:
                                                                    20.0,
                                                                color: Color(
                                                                    0x07000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  20.0,
                                                                ),
                                                                spreadRadius:
                                                                    0.0,
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFDDF1F6),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        2.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
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
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Student : ${clasesItem.studentsList.length.toString()}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
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
                                      ].addToEnd(SizedBox(height: 20.0)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    FFAppState().eventfiles = [];
                                    safeSetState(() {});
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancel',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.35,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.055,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                      shadows: [
                                        Shadow(
                                          color: Color(0x14F4F5FA),
                                          offset: Offset(0.0, -3.0),
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      _model.id = functions.generateUniqueId();
                                      safeSetState(() {});
                                      if (_model.classref.length != 0) {
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
                                                        eventId: _model.id,
                                                        eventDescription:
                                                            widget.description,
                                                        eventDate:
                                                            widget.datetime,
                                                        eventTitle:
                                                            widget.eventtitle,
                                                        eventName:
                                                            widget.eventname,
                                                        eventfiles:
                                                            widget.images,
                                                        classref:
                                                            _model.classref,
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

                                        await _model.school!.reference.update({
                                          ...mapToFirestore(
                                            {
                                              'List_of_notice':
                                                  FieldValue.arrayUnion([
                                                getEventsNoticeFirestoreData(
                                                  updateEventsNoticeStruct(
                                                    EventsNoticeStruct(
                                                      eventId: _model.id,
                                                      eventDescription:
                                                          widget.description,
                                                      eventDate:
                                                          widget.datetime,
                                                      eventTitle:
                                                          widget.eventtitle,
                                                      eventName:
                                                          widget.eventname,
                                                      eventfiles:
                                                          widget.images,
                                                      classref: _model.classref,
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
                                          notificationTitle: 'Notice',
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
                                                notificationFiles:
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
                                            heading: 'Posted a notice',
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
                                            notificationTitle: 'Notice',
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
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        FFAppState().eventname = 'General';
                                        FFAppState().eventfiles = [];
                                        _model.updatePage(() {});
                                        _model.everyone = 0;
                                        _model.toWHome = [];
                                        _model.classref = [];
                                        _model.color = Color(4294967295);
                                        _model.classname = [];
                                        safeSetState(() {});
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment: AlignmentDirectional(
                                                      0.0, -0.8)
                                                  .resolve(Directionality.of(
                                                      context)),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.08,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.7,
                                                child: NoticecreatedWidget(),
                                              ),
                                            );
                                          },
                                        );

                                        context.goNamed(
                                          DashboardWidget.routeName,
                                          queryParameters: {
                                            'tabindex': serializeParam(
                                              1,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );

                                        Navigator.pop(context);
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Alert!'),
                                              content:
                                                  Text('Please select class.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
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
                                          0.35,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.055,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                        shadows: [
                                          Shadow(
                                            color: Color(0xFF375DFB),
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                          ),
                                          Shadow(
                                            color: Color(0x09253EA7),
                                            offset: Offset(0.0, 1.0),
                                            blurRadius: 2.0,
                                          )
                                        ],
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: Color(0xFFEFF0F6),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
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
