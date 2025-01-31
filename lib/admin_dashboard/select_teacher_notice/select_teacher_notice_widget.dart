import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/nosearchresults_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'select_teacher_notice_model.dart';
export 'select_teacher_notice_model.dart';

class SelectTeacherNoticeWidget extends StatefulWidget {
  const SelectTeacherNoticeWidget({
    super.key,
    required this.eventtitle,
    required this.description,
    required this.datetime,
    this.images,
    required this.scoolref,
    required this.eventname,
  });

  final String? eventtitle;
  final String? description;
  final DateTime? datetime;
  final List<String>? images;
  final DocumentReference? scoolref;
  final String? eventname;

  @override
  State<SelectTeacherNoticeWidget> createState() =>
      _SelectTeacherNoticeWidgetState();
}

class _SelectTeacherNoticeWidgetState extends State<SelectTeacherNoticeWidget>
    with TickerProviderStateMixin {
  late SelectTeacherNoticeModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectTeacherNoticeModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().SelectedTeachers = [];
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
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

    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.scoolref!),
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
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.7,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: StreamBuilder<List<TeachersRecord>>(
            stream: queryTeachersRecord(),
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
              List<TeachersRecord> containerTeachersRecordList = snapshot.data!;

              return Container(
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Select teachers',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Nunito',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController',
                              const Duration(milliseconds: 2000),
                              () async {
                                _model.search = true;
                                safeSetState(() {});
                                safeSetState(() {
                                  _model.simpleSearchResults = TextSearch(
                                    containerTeachersRecordList
                                        .where((e) => containerSchoolRecord
                                            .listOfTeachers
                                            .contains(e.reference))
                                        .toList()
                                        .map(
                                          (record) => TextSearchItem.fromTerms(
                                              record, [record.teacherName]),
                                        )
                                        .toList(),
                                  )
                                      .search(_model.textController.text)
                                      .map((r) => r.object)
                                      .toList();
                                });
                              },
                            ),
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: 'Search teacher',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
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
                                  color: FlutterFlowTheme.of(context).dIsable,
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
                              prefixIcon: const Icon(
                                Icons.search_sharp,
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.0,
                                ),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        if (_model.search)
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.search = false;
                              safeSetState(() {});
                              safeSetState(() {
                                _model.textController?.clear();
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ),
                      ],
                    ),
                    if (_model.search == false)
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        decoration: const BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send to',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    AuthUserStreamWidget(
                                      builder: (context) => Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                          ),
                                          unselectedWidgetColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                        ),
                                        child: Checkbox(
                                          value: _model.checkboxValue ??= _model
                                                  .schoolref.length ==
                                              (currentUserDocument?.listofSchool
                                                          .toList() ??
                                                      [])
                                                  .length,
                                          onChanged: (newValue) async {
                                            safeSetState(() => _model
                                                .checkboxValue = newValue!);
                                            if (newValue!) {
                                              FFAppState().SelectedTeachers =
                                                  containerSchoolRecord
                                                      .teachersDataList
                                                      .map((e) => e.teachersId)
                                                      .withoutNulls
                                                      .toList()
                                                      .cast<
                                                          DocumentReference>();
                                              safeSetState(() {});
                                              _model.towhome = [];
                                              safeSetState(() {});
                                              _model.addToTowhome('');
                                              safeSetState(() {});
                                            } else {
                                              FFAppState().SelectedTeachers =
                                                  [];
                                              safeSetState(() {});
                                              _model.towhome = [];
                                              safeSetState(() {});
                                            }
                                          },
                                          side: BorderSide(
                                            width: 2,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          checkColor:
                                              FlutterFlowTheme.of(context).info,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Select all',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (_model.search == false)
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.45,
                        decoration: const BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            final schools =
                                containerSchoolRecord.teachersDataList.toList();
                            if (schools.isEmpty) {
                              return Center(
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  child: const NosearchresultsWidget(),
                                ),
                              );
                            }

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1.0,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: schools.length,
                              itemBuilder: (context, schoolsIndex) {
                                final schoolsItem = schools[schoolsIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (!FFAppState()
                                        .SelectedTeachers
                                        .contains(schoolsItem.teachersId)) {
                                      FFAppState().addToSelectedTeachers(
                                          schoolsItem.teachersId!);
                                      safeSetState(() {});
                                      _model.towhome = functions
                                          .removeaname(_model.towhome.toList(),
                                              'Everyone')
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                      _model.addToTowhome(
                                          schoolsItem.teacherName);
                                      safeSetState(() {});
                                    } else {
                                      FFAppState().removeFromSelectedTeachers(
                                          schoolsItem.teachersId!);
                                      safeSetState(() {});
                                      _model.towhome = functions
                                          .removeaname(_model.towhome.toList(),
                                              schoolsItem.teacherName)
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.15,
                                        height:
                                            MediaQuery.sizeOf(context).width *
                                                0.15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: FFAppState()
                                                    .SelectedTeachers
                                                    .contains(
                                                        schoolsItem.teachersId)
                                                ? const Color(0xFF4CBAFA)
                                                : FlutterFlowTheme.of(context)
                                                    .secondary,
                                            width: 5.0,
                                          ),
                                        ),
                                        child: Stack(
                                          alignment:
                                              const AlignmentDirectional(1.0, 1.0),
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                schoolsItem.teacherImage,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            if (FFAppState()
                                                .SelectedTeachers
                                                .contains(
                                                    schoolsItem.teachersId))
                                              Container(
                                                width: 18.0,
                                                height: 18.0,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF4CBAFA),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 15.0,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        schoolsItem.teacherName,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    if (_model.search == true)
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.45,
                        decoration: const BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            final schools = _model.simpleSearchResults.toList();
                            if (schools.isEmpty) {
                              return Center(
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  child: const NosearchresultsWidget(),
                                ),
                              );
                            }

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1.0,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: schools.length,
                              itemBuilder: (context, schoolsIndex) {
                                final schoolsItem = schools[schoolsIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (!FFAppState()
                                        .SelectedTeachers
                                        .contains(schoolsItem.reference)) {
                                      FFAppState().addToSelectedTeachers(
                                          schoolsItem.reference);
                                      safeSetState(() {});
                                      _model.towhome = functions
                                          .removeaname(_model.towhome.toList(),
                                              'Everyone')
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                      _model.addToTowhome(
                                          schoolsItem.teacherName);
                                      safeSetState(() {});
                                    } else {
                                      FFAppState().removeFromSelectedTeachers(
                                          schoolsItem.reference);
                                      safeSetState(() {});
                                      _model.towhome = functions
                                          .removeaname(_model.towhome.toList(),
                                              schoolsItem.teacherName)
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                    }
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.15,
                                        height:
                                            MediaQuery.sizeOf(context).width *
                                                0.15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: FFAppState()
                                                    .SelectedTeachers
                                                    .contains(
                                                        schoolsItem.reference)
                                                ? const Color(0xFF4CBAFA)
                                                : FlutterFlowTheme.of(context)
                                                    .secondary,
                                            width: 5.0,
                                          ),
                                        ),
                                        child: Stack(
                                          alignment:
                                              const AlignmentDirectional(1.0, 1.0),
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                schoolsItem.teacherImage,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            if (FFAppState()
                                                .SelectedTeachers
                                                .contains(
                                                    schoolsItem.reference))
                                              Container(
                                                width: 18.0,
                                                height: 18.0,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF4CBAFA),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 15.0,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        schoolsItem.teacherName,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              'class_dashboard',
                              queryParameters: {
                                'schoolref': serializeParam(
                                  containerSchoolRecord.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: 'Cancel',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).height * 0.04,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).dIsable,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (FFAppState().SelectedTeachers.isNotEmpty) {
                              FFAppState().loopmin = 0;
                              safeSetState(() {});
                              while (FFAppState().loopmin <
                                  FFAppState().SelectedTeachers.length) {
                                await FFAppState()
                                    .SelectedTeachers
                                    .elementAtOrNull(FFAppState().loopmin)!
                                    .update({
                                  ...mapToFirestore(
                                    {
                                      'notices': FieldValue.arrayUnion([
                                        getEventsNoticeFirestoreData(
                                          updateEventsNoticeStruct(
                                            EventsNoticeStruct(
                                              eventId:
                                                  functions.generateUniqueId(),
                                              eventTitle: widget.eventtitle,
                                              eventDescription:
                                                  widget.description,
                                              eventDate: widget.datetime,
                                              eventImages: widget.images,
                                              eventName: widget.eventname,
                                            ),
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
                              triggerPushNotification(
                                notificationTitle: 'Notice',
                                notificationText: widget.eventtitle!,
                                userRefs: containerTeachersRecordList
                                    .where((e) => FFAppState()
                                        .SelectedTeachers
                                        .contains(e.reference))
                                    .toList()
                                    .map((e) => e.useref)
                                    .withoutNulls
                                    .toList(),
                                initialPageName: 'Teacher_noticeTeacher',
                                parameterData: {},
                              );

                              await NotificationsRecord.collection.doc().set({
                                ...createNotificationsRecordData(
                                  content: widget.eventname,
                                  descri: widget.description,
                                  datetimeofevent: widget.datetime,
                                  notification: updateNotificationStruct(
                                    NotificationStruct(
                                      notificationTitle: widget.eventtitle,
                                      descriptions: widget.description,
                                      timeStamp: getCurrentTimestamp,
                                      isRead: false,
                                      eventDate: widget.datetime,
                                      notificationImages: widget.images,
                                    ),
                                    clearUnsetFields: false,
                                    create: true,
                                  ),
                                  isread: false,
                                  createDate: getCurrentTimestamp,
                                  addedby: currentUserReference,
                                  heading: 'Added a notice',
                                ),
                                ...mapToFirestore(
                                  {
                                    'userref': containerTeachersRecordList
                                        .where((e) => FFAppState()
                                            .SelectedTeachers
                                            .contains(e.reference))
                                        .toList()
                                        .map((e) => e.useref)
                                        .withoutNulls
                                        .toList(),
                                    'towhome': _model.towhome,
                                  },
                                ),
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Notice Sent',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 3200),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              );
                              FFAppState().loopmin = 0;
                              FFAppState().SelectedTeachers = [];
                              safeSetState(() {});
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Alert!'),
                                    content: const Text(
                                        'Please select at least one teacher.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          text: 'Send',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).height * 0.04,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).dIsable,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
      },
    );
  }
}
