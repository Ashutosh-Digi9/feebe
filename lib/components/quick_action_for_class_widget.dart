import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'quick_action_for_class_model.dart';
export 'quick_action_for_class_model.dart';

class QuickActionForClassWidget extends StatefulWidget {
  const QuickActionForClassWidget({
    super.key,
    required this.schoolref,
    required this.classref,
  });

  final DocumentReference? schoolref;
  final DocumentReference? classref;

  @override
  State<QuickActionForClassWidget> createState() =>
      _QuickActionForClassWidgetState();
}

class _QuickActionForClassWidgetState extends State<QuickActionForClassWidget>
    with TickerProviderStateMixin {
  late QuickActionForClassModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuickActionForClassModel());

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
    return Material(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.22,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lightblue,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);

                    context.pushNamed(
                      'students_timeline_activities',
                      queryParameters: {
                        'schoolref': serializeParam(
                          widget.schoolref,
                          ParamType.DocumentReference,
                        ),
                        'classref': serializeParam(
                          widget.classref,
                          ParamType.DocumentReference,
                        ),
                        'activityId': serializeParam(
                          0,
                          ParamType.int,
                        ),
                        'activityName': serializeParam(
                          'Food',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/fork_and_knife_with_plate.png',
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          fit: BoxFit.none,
                        ),
                      ),
                      Text(
                        'Food',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final selectedMedia =
                        await selectMediaWithSourceBottomSheet(
                      context: context,
                      imageQuality: 20,
                      allowPhoto: true,
                      allowVideo: true,
                    );
                    if (selectedMedia != null &&
                        selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                      safeSetState(() => _model.isDataUploading = true);
                      var selectedUploadedFiles = <FFUploadedFile>[];

                      var downloadUrls = <String>[];
                      try {
                        showUploadMessage(
                          context,
                          'Uploading file...',
                          showLoading: true,
                        );
                        selectedUploadedFiles = selectedMedia
                            .map((m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                  height: m.dimensions?.height,
                                  width: m.dimensions?.width,
                                  blurHash: m.blurHash,
                                ))
                            .toList();

                        downloadUrls = (await Future.wait(
                          selectedMedia.map(
                            (m) async =>
                                await uploadData(m.storagePath, m.bytes),
                          ),
                        ))
                            .where((u) => u != null)
                            .map((u) => u!)
                            .toList();
                      } finally {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        _model.isDataUploading = false;
                      }
                      if (selectedUploadedFiles.length ==
                              selectedMedia.length &&
                          downloadUrls.length == selectedMedia.length) {
                        safeSetState(() {
                          _model.uploadedLocalFile =
                              selectedUploadedFiles.first;
                          _model.uploadedFileUrl = downloadUrls.first;
                        });
                        showUploadMessage(context, 'Success!');
                      } else {
                        safeSetState(() {});
                        showUploadMessage(context, 'Failed to upload data');
                        return;
                      }
                    }

                    if (_model.uploadedFileUrl != '') {
                      _model.videouploaded = await actions.videoLimit(
                        _model.uploadedFileUrl,
                      );
                      if (_model.videouploaded!) {
                        if (_model.uploadedFileUrl != '') {
                          FFAppState().studenttimelineimage =
                              _model.uploadedFileUrl;
                          FFAppState().studentphotovideo =
                              _model.uploadedFileUrl;
                          safeSetState(() {});

                          context.pushNamed(
                            'students_timeline_activities',
                            queryParameters: {
                              'schoolref': serializeParam(
                                widget.schoolref,
                                ParamType.DocumentReference,
                              ),
                              'classref': serializeParam(
                                widget.classref,
                                ParamType.DocumentReference,
                              ),
                              'activityId': serializeParam(
                                2,
                                ParamType.int,
                              ),
                              'activityName': serializeParam(
                                'Camera',
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        }
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: const Text('Alert'),
                              content: const Text('video size should not exceed 40'),
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
                    }

                    safeSetState(() {});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_model.isDataUploading)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/Animation_-_1735217758165.gif',
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.08,
                                fit: BoxFit.none,
                              ),
                            ),
                          if (!_model.isDataUploading)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/camera.png',
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.08,
                                fit: BoxFit.none,
                              ),
                            ),
                        ],
                      ),
                      Text(
                        'Camera',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);

                    context.pushNamed(
                      'students_timeline_activities',
                      queryParameters: {
                        'schoolref': serializeParam(
                          widget.schoolref,
                          ParamType.DocumentReference,
                        ),
                        'classref': serializeParam(
                          widget.classref,
                          ParamType.DocumentReference,
                        ),
                        'activityId': serializeParam(
                          4,
                          ParamType.int,
                        ),
                        'activityName': serializeParam(
                          'Potty',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/potty_(2).png',
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          fit: BoxFit.none,
                        ),
                      ),
                      Text(
                        'Potty',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);

                    context.pushNamed(
                      'students_timeline_activities',
                      queryParameters: {
                        'schoolref': serializeParam(
                          widget.schoolref,
                          ParamType.DocumentReference,
                        ),
                        'classref': serializeParam(
                          widget.classref,
                          ParamType.DocumentReference,
                        ),
                        'activityId': serializeParam(
                          1,
                          ParamType.int,
                        ),
                        'activityName': serializeParam(
                          'Nap',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Bitmap.png',
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          fit: BoxFit.none,
                        ),
                      ),
                      Text(
                        'Nap',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);

                    context.pushNamed(
                      'students_timeline_activities',
                      queryParameters: {
                        'schoolref': serializeParam(
                          widget.schoolref,
                          ParamType.DocumentReference,
                        ),
                        'classref': serializeParam(
                          widget.classref,
                          ParamType.DocumentReference,
                        ),
                        'activityId': serializeParam(
                          3,
                          ParamType.int,
                        ),
                        'activityName': serializeParam(
                          'Good deed',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Appreciation.png',
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          fit: BoxFit.none,
                        ),
                      ),
                      Text(
                        'Good Indeed',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);

                    context.pushNamed(
                      'students_timeline_activities',
                      queryParameters: {
                        'schoolref': serializeParam(
                          widget.schoolref,
                          ParamType.DocumentReference,
                        ),
                        'classref': serializeParam(
                          widget.classref,
                          ParamType.DocumentReference,
                        ),
                        'activityId': serializeParam(
                          5,
                          ParamType.int,
                        ),
                        'activityName': serializeParam(
                          'Incident',
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Incident.png',
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          fit: BoxFit.none,
                        ),
                      ),
                      Text(
                        'Incident',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ].addToEnd(const SizedBox(height: 5.0)),
        ),
      ),
    ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
  }
}
