import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'videoplayer_model.dart';
export 'videoplayer_model.dart';

class VideoplayerWidget extends StatefulWidget {
  const VideoplayerWidget({
    super.key,
    required this.studentref,
    required this.index,
  });

  final DocumentReference? studentref;
  final int? index;

  @override
  State<VideoplayerWidget> createState() => _VideoplayerWidgetState();
}

class _VideoplayerWidgetState extends State<VideoplayerWidget> {
  late VideoplayerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoplayerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StudentsRecord>(
      stream: StudentsRecord.getDocument(widget.studentref!),
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

        final containerStudentsRecord = snapshot.data!;

        return Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Stack(
            children: [
              FlutterFlowVideoPlayer(
                path: containerStudentsRecord.timelineVideo
                    .elementAtOrNull(widget.index!)!,
                videoType: VideoType.network,
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                autoPlay: false,
                looping: true,
                showControls: true,
                allowFullScreen: true,
                allowPlaybackSpeedMenu: false,
              ),
              Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).text1,
                        borderRadius: 30.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).text1,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await downloadFile(
                                filename: functions
                                    .extractFileNameFromFirebaseLinkCopy(
                                        containerStudentsRecord.timelineVideo
                                            .elementAtOrNull(widget.index!)!),
                                url: functions.convertvideoPathToString(
                                    containerStudentsRecord.timelineVideo
                                        .elementAtOrNull(widget.index!)!),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Video downloaded successfully',
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
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.download,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                          ),
                          Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Share.share(
                                  functions.convertvideoPathToString(
                                      containerStudentsRecord.timelineVideo
                                          .elementAtOrNull(widget.index!)!),
                                  sharePositionOrigin:
                                      getWidgetBoundingBox(context),
                                );
                              },
                              child: Icon(
                                Icons.share,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ]
                            .divide(const SizedBox(height: 30.0))
                            .around(const SizedBox(height: 30.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
