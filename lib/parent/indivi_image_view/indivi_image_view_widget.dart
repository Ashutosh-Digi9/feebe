import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'indivi_image_view_model.dart';
export 'indivi_image_view_model.dart';

class IndiviImageViewWidget extends StatefulWidget {
  const IndiviImageViewWidget({
    super.key,
    required this.student,
    required this.index,
  });

  final DocumentReference? student;
  final int? index;

  @override
  State<IndiviImageViewWidget> createState() => _IndiviImageViewWidgetState();
}

class _IndiviImageViewWidgetState extends State<IndiviImageViewWidget> {
  late IndiviImageViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IndiviImageViewModel());
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

        final indiviImageViewStudentsRecord = snapshot.data!;

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
                                  indiviImageViewStudentsRecord.timeline
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
                                  indiviImageViewStudentsRecord.timeline
                                      .elementAtOrNull(widget.index!)!
                                      .date!),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
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
                          'Uploaded by : ${indiviImageViewStudentsRecord.timeline.elementAtOrNull(widget.index!)?.activityAddedby}',
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
                                  indiviImageViewStudentsRecord.imageslist
                                      .elementAtOrNull(widget.index!)!,
                                  fit: BoxFit.contain,
                                ),
                                allowRotation: false,
                                tag: indiviImageViewStudentsRecord.imageslist
                                    .elementAtOrNull(widget.index!)!,
                                useHeroAnimation: true,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: indiviImageViewStudentsRecord.imageslist
                              .elementAtOrNull(widget.index!)!,
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              indiviImageViewStudentsRecord.imageslist
                                  .elementAtOrNull(widget.index!)!,
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 300.0,
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
                                          indiviImageViewStudentsRecord.timeline
                                              .elementAtOrNull(widget.index!)!
                                              .activityImages),
                                      sharePositionOrigin:
                                          getWidgetBoundingBox(context),
                                    );
                                  },
                                  child: Icon(
                                    Icons.share,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
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
                                            indiviImageViewStudentsRecord
                                                .imageslist
                                                .elementAtOrNull(
                                                    widget.index!)!),
                                    url: functions.convertImagePathToString(
                                        indiviImageViewStudentsRecord.imageslist
                                            .elementAtOrNull(widget.index!)!),
                                  );
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.download,
                                  color: FlutterFlowTheme.of(context).alternate,
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
