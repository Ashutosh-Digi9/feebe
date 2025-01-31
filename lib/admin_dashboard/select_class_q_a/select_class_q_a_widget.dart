import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/quick_action_selectclass/quick_action_selectclass_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'select_class_q_a_model.dart';
export 'select_class_q_a_model.dart';

class SelectClassQAWidget extends StatefulWidget {
  const SelectClassQAWidget({
    super.key,
    required this.activityId,
    required this.schoolref,
    required this.activityNAme,
  });

  final int? activityId;
  final DocumentReference? schoolref;
  final String? activityNAme;

  @override
  State<SelectClassQAWidget> createState() => _SelectClassQAWidgetState();
}

class _SelectClassQAWidgetState extends State<SelectClassQAWidget>
    with TickerProviderStateMixin {
  late SelectClassQAModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectClassQAModel());

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
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
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
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          final schoolClassref =
                                              containerSchoolRecord.listOfClass
                                                  .toList();

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: schoolClassref.length,
                                            itemBuilder:
                                                (context, schoolClassrefIndex) {
                                              final schoolClassrefItem =
                                                  schoolClassref[
                                                      schoolClassrefIndex];
                                              return Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                child: StreamBuilder<
                                                    SchoolClassRecord>(
                                                  stream: SchoolClassRecord
                                                      .getDocument(
                                                          schoolClassrefItem),
                                                  builder: (context, snapshot) {
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
                                                                0.5,
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
                                                        _model.schoolclass =
                                                            schoolClassrefItem;
                                                        safeSetState(() {});
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
                                                                      16.0),
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
                                                                        .schoolclass ==
                                                                    schoolClassrefItem
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .lightblue
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                blurRadius:
                                                                    20.0,
                                                                color: Color(
                                                                    0x0000001F),
                                                                offset: Offset(
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
                                                                        16.0),
                                                            border: Border.all(
                                                              color: const Color(
                                                                  0xFFC3E2FF),
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
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  containerSchoolClassRecord
                                                                      .studentsList
                                                                      .length
                                                                      .toString(),
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
                                                              ].addToEnd(
                                                                  const SizedBox(
                                                                      height:
                                                                          10.0)),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.safePop();
                                  },
                                  text: 'Back',
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
                                      shadows: [
                                        const Shadow(
                                          color: Color(0xF4F5FA99),
                                          offset: Offset(0.0, -3.0),
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    elevation: 1.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFFEFF0F6),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.schoolclass != null) {
                                      Navigator.pop(context);

                                      context.pushNamed(
                                        'students_timeline_activities',
                                        queryParameters: {
                                          'schoolref': serializeParam(
                                            containerSchoolRecord.reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'classref': serializeParam(
                                            _model.schoolclass,
                                            ParamType.DocumentReference,
                                          ),
                                          'activityId': serializeParam(
                                            widget.activityId,
                                            ParamType.int,
                                          ),
                                          'activityName': serializeParam(
                                            widget.activityNAme,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Alert!'),
                                            content:
                                                const Text('Please select class'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  text: 'Next',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.05,
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
                                      shadows: [
                                        const Shadow(
                                          color: Color(0x253EA77A),
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 2.0,
                                        )
                                      ],
                                    ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFFEFF0F6),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ].addToEnd(const SizedBox(height: 10.0)),
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
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: const QuickActionSelectclassWidget(),
                    );
                  }
                  List<TeachersRecord> containerTeachersRecordList =
                      snapshot.data!;
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
                                      MediaQuery.sizeOf(context).height * 0.58,
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
                                child: SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 0.0),
                                        child: Builder(
                                          builder: (context) {
                                            final schoolClassref =
                                                containerSchoolClassRecordList
                                                    .toList();

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: schoolClassref.length,
                                              itemBuilder: (context,
                                                  schoolClassrefIndex) {
                                                final schoolClassrefItem =
                                                    schoolClassref[
                                                        schoolClassrefIndex];
                                                return Visibility(
                                                  visible: schoolClassrefItem
                                                          .studentsList.isNotEmpty,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 10.0),
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
                                                        if (_model
                                                                .schoolclass !=
                                                            schoolClassrefItem
                                                                .reference) {
                                                          _model.schoolclass =
                                                              schoolClassrefItem
                                                                  .reference;
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.schoolclass =
                                                              null;
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
                                                                      16.0),
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
                                                                        .schoolclass ==
                                                                    schoolClassrefItem
                                                                        .reference
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .lightblue
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                blurRadius:
                                                                    20.0,
                                                                color: Color(
                                                                    0x0000001F),
                                                                offset: Offset(
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            border: Border.all(
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
                                                                    .center,
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
                                                                  schoolClassrefItem
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
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                schoolClassrefItem
                                                                    .studentsList
                                                                    .length
                                                                    .toString(),
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
                                                            ].addToEnd(const SizedBox(
                                                                height: 10.0)),
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
                                    ].addToEnd(const SizedBox(height: 10.0)),
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
                                    context.safePop();
                                  },
                                  text: 'Back',
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
                                      shadows: [
                                        const Shadow(
                                          color: Color(0xF4F5FA99),
                                          offset: Offset(0.0, -3.0),
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFEFF0F6),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.schoolclass != null) {
                                      context.pushNamed(
                                        'students_timeline_activities',
                                        queryParameters: {
                                          'schoolref': serializeParam(
                                            widget.schoolref,
                                            ParamType.DocumentReference,
                                          ),
                                          'classref': serializeParam(
                                            _model.schoolclass,
                                            ParamType.DocumentReference,
                                          ),
                                          'activityId': serializeParam(
                                            widget.activityId,
                                            ParamType.int,
                                          ),
                                          'activityName': serializeParam(
                                            widget.activityNAme,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );

                                      Navigator.pop(context);
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Alert!'),
                                            content:
                                                const Text('Please select class'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: const Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  text: 'Next',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.05,
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
                              ],
                            ),
                          ),
                        ].addToEnd(const SizedBox(height: 10.0)),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
