import '/backend/backend.dart';
import '/components/emptytimeline_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/shimmer_effects/main_dashboard_shimmer/main_dashboard_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'timelinedetails_model.dart';
export 'timelinedetails_model.dart';

class TimelinedetailsWidget extends StatefulWidget {
  const TimelinedetailsWidget({
    super.key,
    required this.studentRef,
    required this.schoolref,
    required this.date,
  });

  final DocumentReference? studentRef;
  final DocumentReference? schoolref;
  final DateTime? date;

  @override
  State<TimelinedetailsWidget> createState() => _TimelinedetailsWidgetState();
}

class _TimelinedetailsWidgetState extends State<TimelinedetailsWidget> {
  late TimelinedetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimelinedetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.calendarDate = widget.date;
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
    return StreamBuilder<StudentsRecord>(
      stream: StudentsRecord.getDocument(widget.studentRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
            body: const MainDashboardShimmerWidget(),
          );
        }

        final timelinedetailsStudentsRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).info,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: FlutterFlowTheme.of(context).bgColor1,
                  size: 26.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Timeline',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 10.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: Container(
                                            width: 65.0,
                                            height: 65.0,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child:
                                                        FlutterFlowExpandedImageView(
                                                      image: Image.network(
                                                        valueOrDefault<String>(
                                                          timelinedetailsStudentsRecord
                                                              .studentImage,
                                                          'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                      allowRotation: false,
                                                      tag: valueOrDefault<
                                                          String>(
                                                        timelinedetailsStudentsRecord
                                                            .studentImage,
                                                        'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                      ),
                                                      useHeroAnimation: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Hero(
                                                tag: valueOrDefault<String>(
                                                  timelinedetailsStudentsRecord
                                                      .studentImage,
                                                  'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                ),
                                                transitionOnUserGestures: true,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      timelinedetailsStudentsRecord
                                                          .studentImage,
                                                      'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 5.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              timelinedetailsStudentsRecord
                                                  .studentName,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .snackbar,
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                timelinedetailsStudentsRecord
                                                    .className,
                                                textAlign: TextAlign.start,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              'Age : ${functions.calculateAge(timelinedetailsStudentsRecord.dateOfBirth!)}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ].divide(const SizedBox(height: 8.0)),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 20.0,
                                            buttonSize:
                                                MediaQuery.sizeOf(context)
                                                        .width *
                                                    0.09,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            icon: Icon(
                                              Icons.call,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 20.0,
                                            ),
                                            onPressed: () async {
                                              _model.school = await SchoolRecord
                                                  .getDocumentOnce(
                                                      widget.schoolref!);
                                              await launchUrl(Uri(
                                                scheme: 'tel',
                                                path: _model
                                                    .school!
                                                    .principalDetails
                                                    .phoneNumber,
                                              ));

                                              safeSetState(() {});
                                            },
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                            child: Text(
                                              'Call School ',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ].divide(const SizedBox(width: 10.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 5.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.calendarDate =
                                    functions.prevDate(_model.calendarDate);
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.chevron_left,
                                color: FlutterFlowTheme.of(context).alternate,
                                size: 24.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              functions.formatDate(_model.calendarDate!) ==
                                      functions.formatDate(getCurrentTimestamp)
                                  ? 'Today '
                                  : dateTimeFormat(
                                      "dd MMM , y", _model.calendarDate),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          if (functions.formatDate(_model.calendarDate!) !=
                              functions.formatDate(getCurrentTimestamp))
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.calendarDate =
                                      functions.nextDate(_model.calendarDate);
                                  safeSetState(() {});
                                },
                                child: Icon(
                                  Icons.navigate_next_sharp,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  size: 24.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: Builder(
                        builder: (context) {
                          final timeline = timelinedetailsStudentsRecord
                              .timeline
                              .where((e) =>
                                  functions.formatDate(e.date!) ==
                                  functions.formatDate(_model.calendarDate!))
                              .toList()
                              .sortedList(keyOf: (e) => e.date!, desc: true)
                              .toList();
                          if (timeline.isEmpty) {
                            return const EmptytimelineWidget();
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: timeline.length,
                            itemBuilder: (context, timelineIndex) {
                              final timelineItem = timeline[timelineIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: valueOrDefault<Color>(
                                        timelineItem.activityId == 5
                                            ? const Color(0xFFFAD7B9)
                                            : FlutterFlowTheme.of(context)
                                                .newBgcolor,
                                        FlutterFlowTheme.of(context).secondary,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 5.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.22,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.1,
                                                  decoration: const BoxDecoration(),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      () {
                                                        if (timelineItem
                                                                .activityId ==
                                                            0) {
                                                          return FFAppConstants
                                                              .food;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            1) {
                                                          return FFAppConstants
                                                              .nap;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            2) {
                                                          return FFAppConstants
                                                              .camera;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            4) {
                                                          return FFAppConstants
                                                              .potty;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            3) {
                                                          return FFAppConstants
                                                              .gdeed;
                                                        } else if (timelineItem
                                                                .id ==
                                                            5) {
                                                          return FFAppConstants
                                                              .incident;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            0) {
                                                          return FFAppConstants
                                                              .food;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            1) {
                                                          return FFAppConstants
                                                              .nap;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            2) {
                                                          return FFAppConstants
                                                              .camera;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            4) {
                                                          return FFAppConstants
                                                              .potty;
                                                        } else if (timelineItem
                                                                .activityId ==
                                                            3) {
                                                          return FFAppConstants
                                                              .gdeed;
                                                        } else if (timelineItem
                                                                .id ==
                                                            5) {
                                                          return FFAppConstants
                                                              .incident;
                                                        } else {
                                                          return FFAppConstants
                                                              .incident;
                                                        }
                                                      }(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.68,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                0.0,
                                                                10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Text(
                                                            timelineItem
                                                                .activityName,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        if (timelineItem
                                                                    .activityDescription !=
                                                                '')
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.6,
                                                            decoration:
                                                                const BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                              child: Text(
                                                                timelineItem
                                                                    .activityDescription,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        if ((timelineItem
                                                                    .activityId ==
                                                                2) &&
                                                            !functions
                                                                .isVideoFile(
                                                                    timelineItem
                                                                        .video))
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await Navigator
                                                                  .push(
                                                                context,
                                                                PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      FlutterFlowExpandedImageView(
                                                                    image: Image
                                                                        .network(
                                                                      functions.converttoimagepath(
                                                                          timelineItem
                                                                              .video),
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                    allowRotation:
                                                                        false,
                                                                    tag: functions
                                                                        .converttoimagepath(
                                                                            timelineItem.video),
                                                                    useHeroAnimation:
                                                                        true,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Hero(
                                                              tag: functions
                                                                  .converttoimagepath(
                                                                      timelineItem
                                                                          .video),
                                                              transitionOnUserGestures:
                                                                  true,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                                child: Image
                                                                    .network(
                                                                  functions.converttoimagepath(
                                                                      timelineItem
                                                                          .video),
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.6,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.2,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if ((timelineItem
                                                                    .activityId ==
                                                                2) &&
                                                            functions
                                                                .isVideoFile(
                                                                    timelineItem
                                                                        .video))
                                                          FlutterFlowVideoPlayer(
                                                            path: functions
                                                                .converttovideo(
                                                                    timelineItem
                                                                        .video),
                                                            videoType: VideoType
                                                                .network,
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.65,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.3,
                                                            autoPlay: false,
                                                            looping: true,
                                                            showControls: false,
                                                            allowFullScreen:
                                                                true,
                                                            allowPlaybackSpeedMenu:
                                                                false,
                                                          ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            dateTimeFormat(
                                                                "jm",
                                                                timelineItem
                                                                    .date!),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  letterSpacing:
                                                                      0.0,
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
                                        ],
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
                  ]
                      .divide(const SizedBox(height: 10.0))
                      .around(const SizedBox(height: 10.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
