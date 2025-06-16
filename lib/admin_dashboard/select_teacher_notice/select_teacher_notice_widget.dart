import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/nosearchresults_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                ),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 0.0),
                          child: Text(
                            'Select teachers',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController',
                                  Duration(milliseconds: 2000),
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
                                              (record) =>
                                                  TextSearchItem.fromTerms(
                                                      record,
                                                      [record.teacherName]),
                                            )
                                            .toList(),
                                      )
                                          .search(_model.textController.text)
                                          .map((r) => r.object)
                                          .toList();
                                      ;
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
                                        font: GoogleFonts.nunito(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  hintText: 'Search teacher',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.nunito(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .textfieldText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .textfieldDisable,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).dIsable,
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
                                  prefixIcon: Icon(
                                    Icons.search_sharp,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                              ),
                          ],
                        ),
                        if (_model.search == false)
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Send to',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (containerSchoolRecord
                                                  .listOfTeachers.length ==
                                              FFAppState()
                                                  .SelectedTeachers
                                                  .length)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                              child: FlutterFlowIconButton(
                                                borderRadius: 4.0,
                                                buttonSize: 25.0,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 12.0,
                                                ),
                                                onPressed: () async {
                                                  FFAppState()
                                                      .SelectedTeachers = [];
                                                  safeSetState(() {});
                                                  _model.towhome = [];
                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                          if (containerSchoolRecord
                                                  .listOfTeachers.length !=
                                              FFAppState()
                                                  .SelectedTeachers
                                                  .length)
                                            FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              borderRadius: 4.0,
                                              borderWidth: 2.0,
                                              buttonSize: 25.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              icon: Icon(
                                                Icons.check,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                              onPressed: () async {
                                                FFAppState().SelectedTeachers =
                                                    containerSchoolRecord
                                                        .teachersDataList
                                                        .map(
                                                            (e) => e.teachersId)
                                                        .withoutNulls
                                                        .toList()
                                                        .cast<
                                                            DocumentReference>();
                                                safeSetState(() {});
                                                _model.towhome = [];
                                                safeSetState(() {});
                                                _model.towhome =
                                                    containerSchoolRecord
                                                        .teachersDataList
                                                        .map((e) =>
                                                            e.teacherName)
                                                        .toList()
                                                        .cast<String>();
                                                safeSetState(() {});
                                              },
                                            ),
                                        ],
                                      ),
                                      Text(
                                        FFAppState().SelectedTeachers.length ==
                                                containerSchoolRecord
                                                    .listOfTeachers.length
                                            ? 'Deselect All'
                                            : 'Select',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              fontSize: 10.0,
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
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_model.search == false)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 5.0, 5.0, 0.0),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.45,
                              decoration: BoxDecoration(),
                              child: Builder(
                                builder: (context) {
                                  final schools = containerSchoolRecord
                                      .teachersDataList
                                      .toList();
                                  if (schools.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        child: NosearchresultsWidget(),
                                      ),
                                    );
                                  }

                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 5.0,
                                      childAspectRatio: 0.9,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
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
                                              .contains(
                                                  schoolsItem.teachersId)) {
                                            FFAppState().addToSelectedTeachers(
                                                schoolsItem.teachersId!);
                                            safeSetState(() {});
                                            _model.towhome = functions
                                                .removeaname(
                                                    _model.towhome.toList(),
                                                    'Everyone')
                                                .toList()
                                                .cast<String>();
                                            safeSetState(() {});
                                            _model.addToTowhome(
                                                schoolsItem.teacherName);
                                            safeSetState(() {});
                                          } else {
                                            FFAppState()
                                                .removeFromSelectedTeachers(
                                                    schoolsItem.teachersId!);
                                            safeSetState(() {});
                                            _model.towhome = functions
                                                .removeaname(
                                                    _model.towhome.toList(),
                                                    schoolsItem.teacherName)
                                                .toList()
                                                .cast<String>();
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: FFAppState()
                                                          .SelectedTeachers
                                                          .contains(schoolsItem
                                                              .teachersId)
                                                      ? Color(0xFF4CBAFA)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                  width: 5.0,
                                                ),
                                              ),
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    1.0, 1.0),
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.15,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.15,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      schoolsItem.teacherImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  if (FFAppState()
                                                      .SelectedTeachers
                                                      .contains(schoolsItem
                                                          .teachersId))
                                                    Container(
                                                      width: 18.0,
                                                      height: 18.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF4CBAFA),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
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
                                                        fontSize: 12.0,
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
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        if (_model.search == true)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 5.0, 5.0, 0.0),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.45,
                              decoration: BoxDecoration(),
                              child: Builder(
                                builder: (context) {
                                  final schools =
                                      _model.simpleSearchResults.toList();
                                  if (schools.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        child: NosearchresultsWidget(),
                                      ),
                                    );
                                  }

                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 5.0,
                                      childAspectRatio: 0.9,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
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
                                              .contains(
                                                  schoolsItem.reference)) {
                                            FFAppState().addToSelectedTeachers(
                                                schoolsItem.reference);
                                            safeSetState(() {});
                                            _model.towhome = functions
                                                .removeaname(
                                                    _model.towhome.toList(),
                                                    'Everyone')
                                                .toList()
                                                .cast<String>();
                                            safeSetState(() {});
                                            _model.addToTowhome(
                                                schoolsItem.teacherName);
                                            safeSetState(() {});
                                          } else {
                                            FFAppState()
                                                .removeFromSelectedTeachers(
                                                    schoolsItem.reference);
                                            safeSetState(() {});
                                            _model.towhome = functions
                                                .removeaname(
                                                    _model.towhome.toList(),
                                                    schoolsItem.teacherName)
                                                .toList()
                                                .cast<String>();
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: FFAppState()
                                                          .SelectedTeachers
                                                          .contains(schoolsItem
                                                              .reference)
                                                      ? Color(0xFF4CBAFA)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                  width: 5.0,
                                                ),
                                              ),
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    1.0, 1.0),
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.15,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.15,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      schoolsItem.teacherImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  if (FFAppState()
                                                      .SelectedTeachers
                                                      .contains(schoolsItem
                                                          .reference))
                                                    Container(
                                                      width: 18.0,
                                                      height: 18.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF4CBAFA),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
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
                                                        fontSize: 12.0,
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
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    ClassDashboardWidget.routeName,
                                    queryParameters: {
                                      'schoolref': serializeParam(
                                        containerSchoolRecord.reference,
                                        ParamType.DocumentReference,
                                      ),
                                      'tabindex': serializeParam(
                                        3,
                                        ParamType.int,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                text: 'Cancel',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.35,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Color(0xFFEFF0F6),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  if (FFAppState().SelectedTeachers.length !=
                                      0) {
                                    FFAppState().loopmin = 0;
                                    safeSetState(() {});
                                    while (FFAppState().loopmin <
                                        FFAppState().SelectedTeachers.length) {
                                      await FFAppState()
                                          .SelectedTeachers
                                          .elementAtOrNull(
                                              FFAppState().loopmin)!
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'notices': FieldValue.arrayUnion([
                                              getEventsNoticeFirestoreData(
                                                updateEventsNoticeStruct(
                                                  EventsNoticeStruct(
                                                    eventId: functions
                                                        .generateUniqueId(),
                                                    eventTitle:
                                                        widget.eventtitle,
                                                    eventDescription:
                                                        widget.description,
                                                    eventDate: widget.datetime,
                                                    eventName:
                                                        widget.eventname,
                                                    eventfiles: widget.images,
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

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationsRecordData(
                                        content: widget.eventname,
                                        descri: widget.description,
                                        datetimeofevent: widget.datetime,
                                        notification: updateNotificationStruct(
                                          NotificationStruct(
                                            notificationTitle:
                                                widget.eventtitle,
                                            descriptions: widget.description,
                                            timeStamp: getCurrentTimestamp,
                                            isRead: false,
                                            eventDate: widget.datetime,
                                            notificationFiles: widget.images,
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
                                          'Notice sent successfully!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 3200),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
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
                                          title: Text('Alert!'),
                                          content: Text(
                                              'Please select at least one teacher.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                text: 'Send',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.35,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
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
                                            .secondaryBackground,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).dIsable,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
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
          ),
        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
      },
    );
  }
}
