import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'studentsprofile_model.dart';
export 'studentsprofile_model.dart';

class StudentsprofileWidget extends StatefulWidget {
  const StudentsprofileWidget({
    super.key,
    required this.studentref,
    required this.classref,
    required this.schoolref,
  });

  final DocumentReference? studentref;
  final List<DocumentReference>? classref;
  final DocumentReference? schoolref;

  @override
  State<StudentsprofileWidget> createState() => _StudentsprofileWidgetState();
}

class _StudentsprofileWidgetState extends State<StudentsprofileWidget> {
  late StudentsprofileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentsprofileModel());

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

      context.pushNamed(
        'IndiStudentAdmin',
        queryParameters: {
          'studentsref': serializeParam(
            widget.studentref,
            ParamType.DocumentReference,
          ),
          'classref': serializeParam(
            widget.classref,
            ParamType.DocumentReference,
            isList: true,
          ),
          'schoolref': serializeParam(
            widget.schoolref,
            ParamType.DocumentReference,
          ),
        }.withoutNulls,
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
                    'IndiStudentAdmin',
                    queryParameters: {
                      'studentsref': serializeParam(
                        widget.studentref,
                        ParamType.DocumentReference,
                      ),
                      'classref': serializeParam(
                        widget.classref,
                        ParamType.DocumentReference,
                        isList: true,
                      ),
                      'schoolref': serializeParam(
                        widget.schoolref,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Stack(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: MediaQuery.sizeOf(context).width * 0.3,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD7F9CB),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      height: MediaQuery.sizeOf(context).width * 0.2,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4BA22E),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 35.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                child: Text(
                  'Student profile \nupdated succesfully',
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
