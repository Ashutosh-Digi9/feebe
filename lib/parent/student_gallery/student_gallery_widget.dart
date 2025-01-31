import '/admin_dashboard/videoplayer/videoplayer_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/shimmer_effects/attenancemarkshimmer/attenancemarkshimmer_widget.dart';
import 'package:flutter/material.dart';
import 'student_gallery_model.dart';
export 'student_gallery_model.dart';

class StudentGalleryWidget extends StatefulWidget {
  const StudentGalleryWidget({
    super.key,
    required this.student,
  });

  final DocumentReference? student;

  @override
  State<StudentGalleryWidget> createState() => _StudentGalleryWidgetState();
}

class _StudentGalleryWidgetState extends State<StudentGalleryWidget>
    with TickerProviderStateMixin {
  late StudentGalleryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentGalleryModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StudentsRecord>(
      stream: StudentsRecord.getDocument(widget.student!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const AttenancemarkshimmerWidget(),
          );
        }

        final studentGalleryStudentsRecord = snapshot.data!;

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
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Color(0x58001B36),
                  size: 20.0,
                ),
                onPressed: () async {
                  context.pushNamed(
                    'Dashboard',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: const TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                      ),
                    },
                  );
                },
              ),
              title: Text(
                'Gallery',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          studentGalleryStudentsRecord.studentName,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Text(
                              'Class : ${studentGalleryStudentsRecord.className}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryText,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: const Alignment(0.0, 0),
                              child: TabBar(
                                labelColor: FlutterFlowTheme.of(context).text1,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).text1,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      letterSpacing: 0.0,
                                    ),
                                unselectedLabelStyle:
                                    FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          letterSpacing: 0.0,
                                        ),
                                indicatorColor:
                                    FlutterFlowTheme.of(context).primary,
                                tabs: [
                                  Tab(
                                    icon: Icon(
                                      Icons.photo_library,
                                      color: _model.tabBarCurrentIndex == 0
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .dIsable,
                                      size: 30.0,
                                    ),
                                    iconMargin: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      Icons.video_collection,
                                      color: _model.tabBarCurrentIndex == 1
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .dIsable,
                                      size: 30.0,
                                    ),
                                    iconMargin: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                  ),
                                ],
                                controller: _model.tabBarController,
                                onTap: (i) async {
                                  [() async {}, () async {}][i]();
                                },
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _model.tabBarController,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 20.0),
                                    child: Builder(
                                      builder: (context) {
                                        final images =
                                            studentGalleryStudentsRecord
                                                .imageslist
                                                .toList();

                                        return GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 10.0,
                                            childAspectRatio: 1.0,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: images.length,
                                          itemBuilder: (context, imagesIndex) {
                                            final imagesItem =
                                                images[imagesIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'indivi_image_view',
                                                  queryParameters: {
                                                    'student': serializeParam(
                                                      widget.student,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                    'index': serializeParam(
                                                      imagesIndex,
                                                      ParamType.int,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  imagesItem,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.3,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.09,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 20.0),
                                    child: Builder(
                                      builder: (context) {
                                        final video =
                                            studentGalleryStudentsRecord
                                                .timelineVideo
                                                .toList();

                                        return GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 10.0,
                                            childAspectRatio: 1.0,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: video.length,
                                          itemBuilder: (context, videoIndex) {
                                            final videoItem = video[videoIndex];
                                            return Container(
                                              decoration: const BoxDecoration(),
                                              child: Builder(
                                                builder: (context) => InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: const AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      dialogContext)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: SizedBox(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.9,
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.9,
                                                              child:
                                                                  VideoplayerWidget(
                                                                studentref:
                                                                    widget
                                                                        .student!,
                                                                index:
                                                                    videoIndex,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: FlutterFlowVideoPlayer(
                                                    path: videoItem,
                                                    videoType:
                                                        VideoType.network,
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.4,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.2,
                                                    autoPlay: false,
                                                    looping: false,
                                                    showControls: false,
                                                    allowFullScreen: false,
                                                    allowPlaybackSpeedMenu:
                                                        false,
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
                          ],
                        ),
                      ),
                    ].addToEnd(const SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
