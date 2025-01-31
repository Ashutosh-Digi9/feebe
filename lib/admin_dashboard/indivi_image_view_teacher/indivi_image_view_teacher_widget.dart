import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'indivi_image_view_teacher_model.dart';
export 'indivi_image_view_teacher_model.dart';

class IndiviImageViewTeacherWidget extends StatefulWidget {
  const IndiviImageViewTeacherWidget({
    super.key,
    required this.teacher,
    required this.index,
    required this.schoolref,
  });

  final DocumentReference? teacher;
  final int? index;
  final DocumentReference? schoolref;

  @override
  State<IndiviImageViewTeacherWidget> createState() =>
      _IndiviImageViewTeacherWidgetState();
}

class _IndiviImageViewTeacherWidgetState
    extends State<IndiviImageViewTeacherWidget> {
  late IndiviImageViewTeacherModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IndiviImageViewTeacherModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TeachersRecord>(
      stream: TeachersRecord.getDocument(widget.teacher!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
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

        final indiviImageViewTeacherTeachersRecord = snapshot.data!;

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
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Color(0x58001B36),
                  size: 20.0,
                ),
                onPressed: () async {
                  context.goNamed(
                    'Teacher_profile',
                    queryParameters: {
                      'teacherRef': serializeParam(
                        widget.teacher,
                        ParamType.DocumentReference,
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Text(
                              dateTimeFormat(
                                  "dd MMM , y",
                                  indiviImageViewTeacherTeachersRecord
                                      .teacherTimeline
                                      .elementAtOrNull(widget.index!)!
                                      .date!),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Text(
                              dateTimeFormat(
                                  "jm",
                                  indiviImageViewTeacherTeachersRecord
                                      .teacherTimeline
                                      .elementAtOrNull(widget.index!)!
                                      .date!),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          'Class : ${indiviImageViewTeacherTeachersRecord.teacherTimeline.elementAtOrNull(widget.index!)?.className}',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Nunito',
                                color:
                                    FlutterFlowTheme.of(context).tertiaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: FlutterFlowExpandedImageView(
                                image: Image.network(
                                  indiviImageViewTeacherTeachersRecord
                                      .uploadedPictures
                                      .elementAtOrNull(widget.index!)!,
                                  fit: BoxFit.contain,
                                ),
                                allowRotation: false,
                                tag: indiviImageViewTeacherTeachersRecord
                                    .uploadedPictures
                                    .elementAtOrNull(widget.index!)!,
                                useHeroAnimation: true,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: indiviImageViewTeacherTeachersRecord
                              .uploadedPictures
                              .elementAtOrNull(widget.index!)!,
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              indiviImageViewTeacherTeachersRecord
                                  .uploadedPictures
                                  .elementAtOrNull(widget.index!)!,
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1.0, 1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Builder(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Share.share(
                                      functions.convertImagePathToString(
                                          indiviImageViewTeacherTeachersRecord
                                              .uploadedPictures
                                              .elementAtOrNull(
                                                  widget.index!)!),
                                      sharePositionOrigin:
                                          getWidgetBoundingBox(context),
                                    );
                                  },
                                  child: Icon(
                                    Icons.share,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await downloadFile(
                                    filename: functions
                                        .extractFileNameFromFirebaseLink(
                                            indiviImageViewTeacherTeachersRecord
                                                .uploadedPictures
                                                .elementAtOrNull(
                                                    widget.index!)!),
                                    url: functions.convertImagePathToString(
                                        indiviImageViewTeacherTeachersRecord
                                            .uploadedPictures
                                            .elementAtOrNull(widget.index!)!),
                                  );
                                },
                                child: Icon(
                                  Icons.download_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 26.0,
                                ),
                              ),
                            ].divide(const SizedBox(width: 15.0)),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(height: 10.0)),
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
