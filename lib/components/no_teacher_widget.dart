import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_teacher_model.dart';
export 'no_teacher_model.dart';

class NoTeacherWidget extends StatefulWidget {
  const NoTeacherWidget({
    super.key,
    required this.schoolRef,
  });

  final DocumentReference? schoolRef;

  @override
  State<NoTeacherWidget> createState() => _NoTeacherWidgetState();
}

class _NoTeacherWidgetState extends State<NoTeacherWidget> {
  late NoTeacherModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoTeacherModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.0, 0.0),
          child: Text(
            'It looks like no teachers have been added yet. \nAdd a teacher to continue.',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.0, -1.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pushNamed(
                'add_Teacher_manually_Admin',
                queryParameters: {
                  'schoolRef': serializeParam(
                    widget.schoolRef,
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
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.2,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEADFFF),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.15,
                            height: MediaQuery.sizeOf(context).width * 0.15,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fflat-style-woman-avatar_90220-2876.jpg?alt=media&token=2c9154f7-595d-40d6-87fd-c0be9eb08d5a',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 1.0),
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'No teacher yet',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Nunito',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
