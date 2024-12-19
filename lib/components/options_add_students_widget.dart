import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'options_add_students_model.dart';
export 'options_add_students_model.dart';

class OptionsAddStudentsWidget extends StatefulWidget {
  const OptionsAddStudentsWidget({
    super.key,
    required this.classref,
    required this.schoolRef,
  });

  final DocumentReference? classref;
  final DocumentReference? schoolRef;

  @override
  State<OptionsAddStudentsWidget> createState() =>
      _OptionsAddStudentsWidgetState();
}

class _OptionsAddStudentsWidgetState extends State<OptionsAddStudentsWidget> {
  late OptionsAddStudentsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionsAddStudentsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: const AlignmentDirectional(1.0, -1.0),
              child: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.close,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              'Add students to the class',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Nunito',
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  context.pushNamed(
                    'SelectStudentsAdmin',
                    queryParameters: {
                      'schoolref': serializeParam(
                        widget.schoolRef,
                        ParamType.DocumentReference,
                      ),
                      'classref': serializeParam(
                        widget.classref,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );

                  Navigator.pop(context);
                },
                text: 'Select students',
                icon: Icon(
                  Icons.check_circle_outline_sharp,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 20.0,
                ),
                options: FFButtonOptions(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 60.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Nunito',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            if (valueOrDefault(currentUserDocument?.userRole, 0) == 2)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: AuthUserStreamWidget(
                  builder: (context) => FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(
                        'add_student_manually',
                        queryParameters: {
                          'schoolref': serializeParam(
                            widget.schoolRef,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );

                      Navigator.pop(context);
                    },
                    text: 'Add students',
                    icon: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 60.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Nunito',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
          ].divide(const SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
