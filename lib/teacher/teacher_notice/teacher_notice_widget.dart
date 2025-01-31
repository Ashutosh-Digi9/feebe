import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/shimmer_effects/notifications_shimmer/notifications_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'teacher_notice_model.dart';
export 'teacher_notice_model.dart';

class TeacherNoticeWidget extends StatefulWidget {
  const TeacherNoticeWidget({
    super.key,
    this.schoolref,
    required this.teacherref,
  });

  final DocumentReference? schoolref;
  final DocumentReference? teacherref;

  @override
  State<TeacherNoticeWidget> createState() => _TeacherNoticeWidgetState();
}

class _TeacherNoticeWidgetState extends State<TeacherNoticeWidget> {
  late TeacherNoticeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeacherNoticeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.calendarDate = getCurrentTimestamp;
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TeachersRecord>(
      stream: TeachersRecord.getDocument(widget.teacherref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const NotificationsShimmerWidget(),
          );
        }

        final teacherNoticeTeachersRecord = snapshot.data!;

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
                  context.pushNamed(
                    'Teacher_profile',
                    queryParameters: {
                      'teacherRef': serializeParam(
                        widget.teacherref,
                        ParamType.DocumentReference,
                      ),
                      'schoolref': serializeParam(
                        widget.schoolref,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                },
              ),
              title: Text(
                'Teacher Notice',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Builder(
                builder: (context) {
                  final notice = teacherNoticeTeachersRecord.notices
                      .sortedList(keyOf: (e) => e.eventDate!, desc: true)
                      .toList();

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: notice.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                    itemBuilder: (context, noticeIndex) {
                      final noticeItem = notice[noticeIndex];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (noticeItem.eventName == 'Notice')
                                          Icon(
                                            Icons.push_pin_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            size: 25.0,
                                          ),
                                        if (noticeItem.eventName == 'Holiday')
                                          Icon(
                                            Icons.celebration_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            size: 25.0,
                                          ),
                                        if (noticeItem.eventName == 'Home work')
                                          Icon(
                                            Icons.home_work_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            size: 25.0,
                                          ),
                                        if (noticeItem.eventName == 'Assinment')
                                          Icon(
                                            Icons.assignment_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            size: 25.0,
                                          ),
                                        Text(
                                          noticeItem.eventName,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: Text(
                                      dateTimeFormat(
                                          "dd MMM , y", noticeItem.eventDate!),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: Text(
                                      noticeItem.eventTitle,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      noticeItem.eventDescription,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.1,
                                    child: Builder(
                                      builder: (context) {
                                        final uploadedimages =
                                            noticeItem.eventImages.toList();
                                        if (uploadedimages.isEmpty) {
                                          return const EmptyWidget();
                                        }

                                        return GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 10.0,
                                            childAspectRatio: 1.0,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: uploadedimages.length,
                                          itemBuilder:
                                              (context, uploadedimagesIndex) {
                                            final uploadedimagesItem =
                                                uploadedimages[
                                                    uploadedimagesIndex];
                                            return Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: const BoxDecoration(),
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
                                                    await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                            FlutterFlowExpandedImageView(
                                                          image: Image.network(
                                                            uploadedimagesItem,
                                                            fit: BoxFit.contain,
                                                          ),
                                                          allowRotation: false,
                                                          tag:
                                                              uploadedimagesItem,
                                                          useHeroAnimation:
                                                              true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Hero(
                                                    tag: uploadedimagesItem,
                                                    transitionOnUserGestures:
                                                        true,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        uploadedimagesItem,
                                                        fit: BoxFit.cover,
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
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
