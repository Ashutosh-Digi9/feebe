import '/admin_dashboard/class_calendar_edit/class_calendar_edit_widget.dart';
import '/admin_dashboard/edit_delete_notice/edit_delete_notice_widget.dart';
import '/admin_dashboard/editclass/editclass_widget.dart';
import '/admin_dashboard/options_add_students/options_add_students_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/emptynotice_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_view_model.dart';
export 'class_view_model.dart';

class ClassViewWidget extends StatefulWidget {
  const ClassViewWidget({
    super.key,
    this.schoolclassref,
    this.schoolref,
    required this.datePick,
  });

  final DocumentReference? schoolclassref;
  final DocumentReference? schoolref;
  final DateTime? datePick;

  @override
  State<ClassViewWidget> createState() => _ClassViewWidgetState();
}

class _ClassViewWidgetState extends State<ClassViewWidget> {
  late ClassViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassViewModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.date = widget.datePick;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SchoolClassRecord>(
      stream: SchoolClassRecord.getDocument(widget.schoolclassref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final classViewSchoolClassRecord = snapshot.data!;

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
                  if (valueOrDefault(currentUserDocument?.userRole, 0) == 2) {
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed(
                      'class_dashboard',
                      queryParameters: {
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
                  } else if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                      1) {
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed(
                      'class_dashboard',
                      queryParameters: {
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
                  } else {
                    context.pushNamed(
                      'Dashboard',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  }
                },
              ),
              title: Text(
                'Class',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: [
                Visibility(
                  visible:
                      valueOrDefault(currentUserDocument?.userRole, 0) == 2,
                  child: Builder(
                    builder: (context) => AuthUserStreamWidget(
                      builder: (context) => FlutterFlowIconButton(
                        buttonSize: MediaQuery.sizeOf(context).width * 0.2,
                        icon: Icon(
                          Icons.more_vert,
                          color: FlutterFlowTheme.of(context).alternate,
                          size: 25.0,
                        ),
                        onPressed: () async {
                          await showAlignedDialog(
                            context: context,
                            isGlobal: false,
                            avoidOverflow: false,
                            targetAnchor: const AlignmentDirectional(1.0, -1.0)
                                .resolve(Directionality.of(context)),
                            followerAnchor: const AlignmentDirectional(1.0, -1.0)
                                .resolve(Directionality.of(context)),
                            builder: (dialogContext) {
                              return Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    child: EditclassWidget(
                                      schoolRef: widget.schoolref!,
                                      classref:
                                          classViewSchoolClassRecord.reference,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.9,
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              classViewSchoolClassRecord.className,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.12,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).lightblue,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 2.0, 0.0, 0.0),
                                    child: RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Teachers : ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          TextSpan(
                                            text: classViewSchoolClassRecord
                                                .listOfteachers.length
                                                .toString(),
                                            style: GoogleFonts.getFont(
                                              'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Builder(
                                      builder: (context) {
                                        final teachersref =
                                            classViewSchoolClassRecord
                                                .listOfteachers
                                                .sortedList(
                                                    keyOf: (e) => e.teacherName,
                                                    desc: false)
                                                .toList();

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: List.generate(
                                                teachersref.length,
                                                (teachersrefIndex) {
                                              final teachersrefItem =
                                                  teachersref[teachersrefIndex];
                                              return Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 5.0, 0.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.1,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.1,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            teachersrefItem
                                                                .teacherImage,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Text(
                                                          teachersrefItem
                                                              .teacherName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 20.0, 10.0, 0.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 0.0, 0.0),
                                      child: RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Students : ',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryText,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: classViewSchoolClassRecord
                                                  .studentsList.length
                                                  .toString(),
                                              style: GoogleFonts.getFont(
                                                'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0,
                                              ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.08,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x491D61E7),
                                                    offset: Offset(
                                                      0.0,
                                                      2.0,
                                                    ),
                                                    spreadRadius: 0.0,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'calender_class',
                                                    queryParameters: {
                                                      'schoolclassref':
                                                          serializeParam(
                                                        classViewSchoolClassRecord
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                      'schoolref':
                                                          serializeParam(
                                                        widget.schoolref,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                      'mainpage':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/Saly-42_(1).png',
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.2,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.04,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Calendar',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.08,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x491D61E7),
                                                    offset: Offset(
                                                      0.0,
                                                      2.0,
                                                    ),
                                                    spreadRadius: 0.0,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.userRole,
                                                          0) ==
                                                      1) {
                                                    context.pushNamed(
                                                      'selectedstudents_sadmin',
                                                      queryParameters: {
                                                        'schoolref':
                                                            serializeParam(
                                                          widget.schoolref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'classref':
                                                            serializeParam(
                                                          widget
                                                              .schoolclassref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  } else {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child: SizedBox(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.3,
                                                              child:
                                                                  OptionsAddStudentsWidget(
                                                                classref: widget
                                                                    .schoolclassref!,
                                                                schoolRef: widget
                                                                    .schoolref!,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/_Group_404.png',
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.2,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.04,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Students',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.08,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x491D61E7),
                                                    offset: Offset(
                                                      0.0,
                                                      2.0,
                                                    ),
                                                    spreadRadius: 0.0,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (valueOrDefault(
                                                          currentUserDocument
                                                              ?.userRole,
                                                          0) ==
                                                      1) {
                                                    context.pushNamed(
                                                      'class_attendence',
                                                      queryParameters: {
                                                        'classRef':
                                                            serializeParam(
                                                          classViewSchoolClassRecord
                                                              .reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'schoolref':
                                                            serializeParam(
                                                          widget.schoolref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'classattendence':
                                                            serializeParam(
                                                          false,
                                                          ParamType.bool,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  } else {
                                                    if (classViewSchoolClassRecord
                                                            .attendance
                                                            .where((e) =>
                                                                dateTimeFormat(
                                                                    "yMd",
                                                                    e.date) ==
                                                                dateTimeFormat(
                                                                    "yMd",
                                                                    getCurrentTimestamp))
                                                            .toList().isNotEmpty) {
                                                      context.pushNamed(
                                                        'class_attendence',
                                                        queryParameters: {
                                                          'classRef':
                                                              serializeParam(
                                                            classViewSchoolClassRecord
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'schoolref':
                                                              serializeParam(
                                                            widget.schoolref,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'classattendence':
                                                              serializeParam(
                                                            false,
                                                            ParamType.bool,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    } else {
                                                      context.pushNamed(
                                                        'mark_attendence',
                                                        queryParameters: {
                                                          'classRef':
                                                              serializeParam(
                                                            classViewSchoolClassRecord
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'schoolref':
                                                              serializeParam(
                                                            widget.schoolref,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                          ),
                                                        },
                                                      );
                                                    }
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/Chart_perspective_matte.png',
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.2,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.04,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Attendance',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
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
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 0.0, 0.0),
                            child: Text(
                              'Upcoming Events for this class',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if ((classViewSchoolClassRecord.calendar
                                                .sortedList(
                                                    keyOf: (e) => e.eventDate!,
                                                    desc: false)
                                                .where((e) =>
                                                    functions.isDatePassed(
                                                        e.eventDate!) ==
                                                    false)
                                                .toList().isEmpty) &&
                                        (valueOrDefault(
                                                currentUserDocument?.userRole,
                                                0) !=
                                            1))
                                      AuthUserStreamWidget(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              'calender_class',
                                              queryParameters: {
                                                'schoolclassref':
                                                    serializeParam(
                                                  classViewSchoolClassRecord
                                                      .reference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'schoolref': serializeParam(
                                                  widget.schoolref,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          text: 'Add Event',
                                          icon: Icon(
                                            Icons.add,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            size: 20.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconAlignment: IconAlignment.end,
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    if ((classViewSchoolClassRecord.calendar
                                                .sortedList(
                                                    keyOf: (e) => e.eventDate!,
                                                    desc: false)
                                                .where((e) =>
                                                    functions.isDatePassed(
                                                        e.eventDate!) ==
                                                    false)
                                                .toList().isNotEmpty) &&
                                        (valueOrDefault(
                                                currentUserDocument?.userRole,
                                                0) !=
                                            1))
                                      AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          decoration: const BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'calender_class',
                                                  queryParameters: {
                                                    'schoolclassref':
                                                        serializeParam(
                                                      classViewSchoolClassRecord
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                    'schoolref': serializeParam(
                                                      widget.schoolref,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.add_circle_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    size: 35.0,
                                                  ),
                                                  Text(
                                                    'Add',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    Builder(
                                      builder: (context) {
                                        final event = classViewSchoolClassRecord
                                            .calendar
                                            .sortedList(
                                                keyOf: (e) => e.eventDate!,
                                                desc: false)
                                            .where((e) =>
                                                functions.isDatePassed(
                                                    e.eventDate!) ==
                                                false)
                                            .toList()
                                            .take(5)
                                            .toList()
                                            .take(5)
                                            .toList();

                                        return Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: List.generate(event.length,
                                              (eventIndex) {
                                            final eventItem = event[eventIndex];
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
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
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child: SizedBox(
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.6,
                                                                child:
                                                                    ClassCalendarEditWidget(
                                                                  classref:
                                                                      classViewSchoolClassRecord
                                                                          .reference,
                                                                  eventid:
                                                                      eventItem
                                                                          .eventId,
                                                                  school: widget
                                                                      .schoolref!,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Container(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.05,
                                                      decoration: BoxDecoration(
                                                        color: () {
                                                          if (eventItem
                                                                  .eventName ==
                                                              'Event') {
                                                            return const Color(
                                                                0xFFFFFCF0);
                                                          } else if (eventItem
                                                                  .eventName ==
                                                              'Birthday') {
                                                            return const Color(
                                                                0xFFF0F0FF);
                                                          } else {
                                                            return const Color(
                                                                0xFFFBFCFF);
                                                          }
                                                        }(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: () {
                                                            if (eventItem
                                                                    .eventName ==
                                                                'Event') {
                                                              return const Color(
                                                                  0xFFF8BA0B);
                                                            } else if (eventItem
                                                                    .eventName ==
                                                                'Birthday') {
                                                              return const Color(
                                                                  0xFF635AAC);
                                                            } else {
                                                              return const Color(
                                                                  0xFF7DD7FE);
                                                            }
                                                          }(),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (eventItem
                                                                    .eventName ==
                                                                'Event')
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .bolt_sharp,
                                                                  color: Color(
                                                                      0xFFF8BA0B),
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            if (eventItem
                                                                    .eventName ==
                                                                'Birthday')
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .birthdayCake,
                                                                  color: Color(
                                                                      0xFFB0A7FD),
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            if (eventItem
                                                                    .eventName ==
                                                                'Holiday')
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .celebration_sharp,
                                                                  color: Color(
                                                                      0xFF072F78),
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                eventItem
                                                                    .eventTitle,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color:
                                                                          () {
                                                                        if (eventItem.eventName ==
                                                                            'Event') {
                                                                          return const Color(
                                                                              0xFFF8BA0B);
                                                                        } else if (eventItem.eventName ==
                                                                            'Birthday') {
                                                                          return const Color(
                                                                              0xFF635AAC);
                                                                        } else {
                                                                          return const Color(
                                                                              0xFF072F78);
                                                                        }
                                                                      }(),
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    functions.formatDate(eventItem
                                                                .eventDate!) ==
                                                            functions.formatDate(
                                                                getCurrentTimestamp)
                                                        ? 'Today'
                                                        : dateTimeFormat(
                                                            "MMM/d",
                                                            eventItem
                                                                .eventDate!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: valueOrDefault<
                                                              Color>(
                                                            functions.formatDate(
                                                                        eventItem
                                                                            .eventDate!) ==
                                                                    functions
                                                                        .formatDate(
                                                                            getCurrentTimestamp)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground
                                                                : const Color(
                                                                    0xFFA0A0A1),
                                                            const Color(0xFFA0A0A1),
                                                          ),
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).divide(const SizedBox(width: 10.0)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.06,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F3F3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Latest Notices',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              final datePickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    getCurrentTimestamp,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2050),
                                                builder: (context, child) {
                                                  return wrapInMaterialDatePickerTheme(
                                                    context,
                                                    child!,
                                                    headerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .override(
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: 32.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                    pickerBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    iconSize: 24.0,
                                                  );
                                                },
                                              );

                                              if (datePickedDate != null) {
                                                safeSetState(() {
                                                  _model.datePicked = DateTime(
                                                    datePickedDate.year,
                                                    datePickedDate.month,
                                                    datePickedDate.day,
                                                  );
                                                });
                                              }
                                              _model.date = _model.datePicked;
                                              safeSetState(() {});
                                            },
                                            child: Icon(
                                              Icons.date_range_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 32.0,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          dateTimeFormat(
                                              "dd MMM y", _model.datePicked),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if ((classViewSchoolClassRecord.notice
                                            .sortedList(
                                                keyOf: (e) => e.eventDate!,
                                                desc: true)
                                            .where((e) =>
                                                functions.isDatePassed(
                                                    e.eventDate!) ==
                                                false)
                                            .toList().isNotEmpty) &&
                                    (valueOrDefault(
                                            currentUserDocument?.userRole, 0) !=
                                        1))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 20.0, 0.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => FFButtonWidget(
                                        onPressed: () async {
                                          context.pushNamed(
                                            'ClassNotice_Admin_Teacher',
                                            queryParameters: {
                                              'classref': serializeParam(
                                                classViewSchoolClassRecord
                                                    .reference,
                                                ParamType.DocumentReference,
                                              ),
                                              'schoolref': serializeParam(
                                                widget.schoolref,
                                                ParamType.DocumentReference,
                                              ),
                                              'date': serializeParam(
                                                _model.date,
                                                ParamType.DateTime,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        text: 'Create New',
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconAlignment: IconAlignment.end,
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                letterSpacing: 0.0,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if ((classViewSchoolClassRecord.notice
                                      .sortedList(
                                          keyOf: (e) => e.eventDate!,
                                          desc: true)
                                      .where((e) =>
                                          functions
                                              .isDatePassed(e.eventDate!) ==
                                          false)
                                      .toList().isEmpty) &&
                              (valueOrDefault(
                                      currentUserDocument?.userRole, 0) !=
                                  1))
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      'ClassNotice_Admin_Teacher',
                                      queryParameters: {
                                        'classref': serializeParam(
                                          classViewSchoolClassRecord.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'schoolref': serializeParam(
                                          widget.schoolref,
                                          ParamType.DocumentReference,
                                        ),
                                        'date': serializeParam(
                                          _model.date,
                                          ParamType.DateTime,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  text: 'Add Notice',
                                  icon: Icon(
                                    Icons.add,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 20.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconAlignment: IconAlignment.end,
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Builder(
                              builder: (context) {
                                final noticeboard = classViewSchoolClassRecord
                                    .notice
                                    .sortedList(
                                        keyOf: (e) => e.eventDate!, desc: true)
                                    .where((e) =>
                                        dateTimeFormat("yMMMd", _model.date) ==
                                        dateTimeFormat("yMMMd", e.eventDate))
                                    .toList();
                                if (noticeboard.isEmpty) {
                                  return const EmptynoticeWidget();
                                }

                                return ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    20.0,
                                  ),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: noticeboard.length,
                                  itemBuilder: (context, noticeboardIndex) {
                                    final noticeboardItem =
                                        noticeboard[noticeboardIndex];
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 8.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'Notice_details',
                                            queryParameters: {
                                              'eventDetails': serializeParam(
                                                noticeboardItem,
                                                ParamType.DataStruct,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 8.0, 8.0, 8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.3,
                                                            decoration:
                                                                const BoxDecoration(),
                                                            child: Text(
                                                              noticeboardItem
                                                                  .eventTitle,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.06,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: () {
                                                                  if (noticeboardItem
                                                                          .eventName ==
                                                                      'General') {
                                                                    return const Color(
                                                                        0xFFFFFCF0);
                                                                  } else if (noticeboardItem
                                                                          .eventName ==
                                                                      'Reminder') {
                                                                    return const Color(
                                                                        0xFFFBF0FF);
                                                                  } else {
                                                                    return const Color(
                                                                        0xFFFFFCF0);
                                                                  }
                                                                }(),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                border:
                                                                    Border.all(
                                                                  color: () {
                                                                    if (noticeboardItem
                                                                            .eventName ==
                                                                        'General') {
                                                                      return const Color(
                                                                          0xFFFF976A);
                                                                    } else if (noticeboardItem
                                                                            .eventName ==
                                                                        'Reminder') {
                                                                      return const Color(
                                                                          0xFFADA6EB);
                                                                    } else {
                                                                      return const Color(
                                                                          0xFFB0FF6A);
                                                                    }
                                                                  }(),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    if (noticeboardItem
                                                                            .eventName ==
                                                                        'Notice')
                                                                      Icon(
                                                                        Icons
                                                                            .push_pin,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .checkBg,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    if (noticeboardItem
                                                                            .eventName ==
                                                                        'Reminder')
                                                                      Icon(
                                                                        Icons
                                                                            .alarm,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    if (noticeboardItem
                                                                            .eventName ==
                                                                        'General')
                                                                      Icon(
                                                                        Icons
                                                                            .mode_comment,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .warning,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    Text(
                                                                      noticeboardItem
                                                                          .eventName,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ]
                                                                      .divide(const SizedBox(
                                                                          width:
                                                                              10.0))
                                                                      .around(const SizedBox(
                                                                          width:
                                                                              10.0)),
                                                                ),
                                                              ),
                                                            ),
                                                            if ((dateTimeFormat(
                                                                        "yMd",
                                                                        noticeboardItem
                                                                            .eventDate) !=
                                                                    dateTimeFormat(
                                                                        "yMd",
                                                                        getCurrentTimestamp)) &&
                                                                (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.userRole,
                                                                        0) !=
                                                                    1))
                                                              Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      AuthUserStreamWidget(
                                                                    builder:
                                                                        (context) =>
                                                                            FlutterFlowIconButton(
                                                                      borderRadius:
                                                                          38.0,
                                                                      buttonSize:
                                                                          38.0,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        if (noticeboardItem.eventImages.isEmpty) {
                                                                          await showAlignedDialog(
                                                                            context:
                                                                                context,
                                                                            isGlobal:
                                                                                false,
                                                                            avoidOverflow:
                                                                                false,
                                                                            targetAnchor:
                                                                                const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                            followerAnchor:
                                                                                const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                            builder:
                                                                                (dialogContext) {
                                                                              return Material(
                                                                                color: Colors.transparent,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(dialogContext).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: SizedBox(
                                                                                    height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                    width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                    child: EditDeleteNoticeWidget(
                                                                                      classref: classViewSchoolClassRecord.reference,
                                                                                      eventid: noticeboardItem.eventId,
                                                                                      classEvent: false,
                                                                                      event: EventsNoticeStruct(
                                                                                        eventId: noticeboardItem.eventId,
                                                                                        eventTitle: noticeboardItem.eventTitle,
                                                                                        eventDescription: noticeboardItem.eventDescription,
                                                                                        eventDate: noticeboardItem.eventDate,
                                                                                        eventName: noticeboardItem.eventName,
                                                                                      ),
                                                                                      noticebool: true,
                                                                                      schoolref: widget.schoolref!,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        } else {
                                                                          await showAlignedDialog(
                                                                            context:
                                                                                context,
                                                                            isGlobal:
                                                                                false,
                                                                            avoidOverflow:
                                                                                false,
                                                                            targetAnchor:
                                                                                const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                            followerAnchor:
                                                                                const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                            builder:
                                                                                (dialogContext) {
                                                                              return Material(
                                                                                color: Colors.transparent,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    FocusScope.of(dialogContext).unfocus();
                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                  },
                                                                                  child: SizedBox(
                                                                                    height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                    width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                    child: EditDeleteNoticeWidget(
                                                                                      classref: classViewSchoolClassRecord.reference,
                                                                                      eventid: noticeboardItem.eventId,
                                                                                      classEvent: false,
                                                                                      noticebool: true,
                                                                                      schoolref: widget.schoolref!,
                                                                                      eventImage: EventsNoticeStruct(
                                                                                        eventId: noticeboardItem.eventId,
                                                                                        eventTitle: noticeboardItem.eventTitle,
                                                                                        eventDescription: noticeboardItem.eventDescription,
                                                                                        eventDate: noticeboardItem.eventDate,
                                                                                        eventName: noticeboardItem.eventName,
                                                                                        eventImages: noticeboardItem.eventImages,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ].divide(const SizedBox(
                                                              width: 10.0)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 10.0),
                                                    child: Text(
                                                      dateTimeFormat(
                                                          "dd MMM , y",
                                                          noticeboardItem
                                                              .eventDate!),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiaryText,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 10.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.8,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Text(
                                                        noticeboardItem
                                                            .eventDescription,
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
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 0.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final uploadedImages =
                                                            noticeboardItem
                                                                .eventImages
                                                                .toList();

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                uploadedImages
                                                                    .length,
                                                                (uploadedImagesIndex) {
                                                              final uploadedImagesItem =
                                                                  uploadedImages[
                                                                      uploadedImagesIndex];
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  decoration:
                                                                      const BoxDecoration(),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        PageTransition(
                                                                          type:
                                                                              PageTransitionType.fade,
                                                                          child:
                                                                              FlutterFlowExpandedImageView(
                                                                            image:
                                                                                Image.network(
                                                                              uploadedImagesItem,
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                            allowRotation:
                                                                                false,
                                                                            tag:
                                                                                uploadedImagesItem,
                                                                            useHeroAnimation:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Hero(
                                                                      tag:
                                                                          uploadedImagesItem,
                                                                      transitionOnUserGestures:
                                                                          true,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          uploadedImagesItem,
                                                                          width:
                                                                              50.0,
                                                                          height:
                                                                              50.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
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
