import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'teacherdetailsedited_model.dart';
export 'teacherdetailsedited_model.dart';

class TeacherdetailseditedWidget extends StatefulWidget {
  const TeacherdetailseditedWidget({
    super.key,
    required this.schoolref,
    required this.teacheref,
  });

  final DocumentReference? schoolref;
  final DocumentReference? teacheref;

  @override
  State<TeacherdetailseditedWidget> createState() =>
      _TeacherdetailseditedWidgetState();
}

class _TeacherdetailseditedWidgetState
    extends State<TeacherdetailseditedWidget> {
  late TeacherdetailseditedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeacherdetailseditedModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.soundPlayer ??= AudioPlayer();
      if (_model.soundPlayer!.playing) {
        await _model.soundPlayer!.stop();
      }
      _model.soundPlayer!.setVolume(1.0);
      _model.soundPlayer!
          .setAsset('assets/audios/music-box-98027.mp3')
          .then((_) => _model.soundPlayer!.play());

      HapticFeedback.lightImpact();
      await Future.delayed(const Duration(milliseconds: 2000));

      context.goNamed(
        'Teacher_profile',
        queryParameters: {
          'teacherRef': serializeParam(
            widget.teacheref,
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
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondary,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).info,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(
                    'Teacher_profile',
                    queryParameters: {
                      'teacherRef': serializeParam(
                        widget.teacheref,
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
                child: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset(
                'assets/jsons/Animation_-_1731654084345.json',
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.6,
                fit: BoxFit.contain,
                animate: true,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                child: Text(
                  'Teacher details updated Succesfully',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito',
                        fontSize: 34.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
