import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'teacher_details_model.dart';
export 'teacher_details_model.dart';

class TeacherDetailsWidget extends StatefulWidget {
  const TeacherDetailsWidget({
    super.key,
    required this.teacherref,
    required this.schoolref,
    required this.mainschoolref,
    required this.teacher,
  });

  final DocumentReference? teacherref;
  final DocumentReference? schoolref;
  final DocumentReference? mainschoolref;
  final TeacherListStruct? teacher;

  @override
  State<TeacherDetailsWidget> createState() => _TeacherDetailsWidgetState();
}

class _TeacherDetailsWidgetState extends State<TeacherDetailsWidget>
    with TickerProviderStateMixin {
  late TeacherDetailsModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeacherDetailsModel());

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
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
      child: StreamBuilder<TeachersRecord>(
        stream: TeachersRecord.getDocument(widget.teacherref!),
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

          final taskDetailsTeachersRecord = snapshot.data!;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  offset: const Offset(
                    0.0,
                    1.0,
                  ),
                )
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              border: Border.all(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                width: 0.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.0, -1.0),
                        child: Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 15.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Share.share(
                                  'Here are your credentials to access feebe employee dashboard Mail ID - ${taskDetailsTeachersRecord.emailId} and password is ${taskDetailsTeachersRecord.phoneNumber}',
                                  sharePositionOrigin:
                                      getWidgetBoundingBox(context),
                                );
                              },
                              child: FaIcon(
                                FontAwesomeIcons.share,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 10.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              FFAppState().loopmin = 0;
                              safeSetState(() {});
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Are you sure ?'),
                                            content: const Text(
                                                'Are you sure you want to delete this teacher ?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: const Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                await Future.wait([
                                  Future(() async {
                                    await widget.schoolref!.update({
                                      ...mapToFirestore(
                                        {
                                          'List_of_teachers':
                                              FieldValue.arrayRemove(
                                                  [widget.teacherref]),
                                          'teachers_data_list':
                                              FieldValue.arrayRemove([
                                            getTeacherListFirestoreData(
                                              updateTeacherListStruct(
                                                widget.teacher,
                                                clearUnsetFields: false,
                                              ),
                                              true,
                                            )
                                          ]),
                                          'listOfteachersuser':
                                              FieldValue.arrayRemove([
                                            taskDetailsTeachersRecord.useref
                                          ]),
                                        },
                                      ),
                                    });
                                  }),
                                  Future(() async {
                                    await widget.teacherref!.delete();
                                  }),
                                  Future(() async {
                                    _model.apiResult41a =
                                        await DeleteUserCall.call(
                                      uid: widget.teacher?.userRef?.id,
                                    );
                                  }),
                                  Future(() async {
                                    _model.classes =
                                        await querySchoolClassRecordOnce(
                                      queryBuilder: (schoolClassRecord) =>
                                          schoolClassRecord.where(
                                        'teachers_list',
                                        arrayContains: widget.teacherref,
                                      ),
                                    );
                                    while (FFAppState().loopmin <
                                        _model.classes!.length) {
                                      await _model.classes!
                                          .elementAtOrNull(
                                              FFAppState().loopmin)!
                                          .reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'teachers_list':
                                                FieldValue.arrayUnion(
                                                    [widget.teacherref]),
                                            'listOfteachersUser':
                                                FieldValue.arrayRemove([
                                              taskDetailsTeachersRecord.useref
                                            ]),
                                            'ListOfteachers':
                                                FieldValue.arrayRemove([
                                              getTeacherListFirestoreData(
                                                updateTeacherListStruct(
                                                  TeacherListStruct(
                                                    teachersId:
                                                        widget.teacherref,
                                                    teacherName:
                                                        taskDetailsTeachersRecord
                                                            .teacherName,
                                                    phoneNumber:
                                                        taskDetailsTeachersRecord
                                                            .phoneNumber,
                                                    emailId:
                                                        taskDetailsTeachersRecord
                                                            .emailId,
                                                    teacherImage:
                                                        taskDetailsTeachersRecord
                                                            .teacherImage,
                                                    userRef:
                                                        taskDetailsTeachersRecord
                                                            .useref,
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
                                  }),
                                ]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Teacher deleted successfully!',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                FFAppState().loopmin = 0;
                                safeSetState(() {});
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                              }

                              safeSetState(() {});
                            },
                            child: Icon(
                              Icons.delete_rounded,
                              color: FlutterFlowTheme.of(context).alternate,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    valueOrDefault<String>(
                                      taskDetailsTeachersRecord.teacherImage,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png',
                                    ),
                                  ).image,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onLongPress: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.network(
                                          valueOrDefault<String>(
                                            taskDetailsTeachersRecord
                                                .teacherImage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: valueOrDefault<String>(
                                          taskDetailsTeachersRecord
                                              .teacherImage,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                        ),
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: valueOrDefault<String>(
                                    taskDetailsTeachersRecord.teacherImage,
                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                  ),
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        taskDetailsTeachersRecord.teacherImage,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                      ),
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    taskDetailsTeachersRecord.teacherName,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Text(
                                      taskDetailsTeachersRecord.phoneNumber,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Text(
                                      taskDetailsTeachersRecord.emailId,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
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
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 10.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await launchUrl(Uri(
                              scheme: 'tel',
                              path: taskDetailsTeachersRecord.phoneNumber,
                            ));
                          },
                          text: 'Contact',
                          icon: Icon(
                            Icons.call,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 20.0,
                          ),
                          options: FFButtonOptions(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 16.0, 10.0, 16.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
        },
      ),
    );
  }
}
